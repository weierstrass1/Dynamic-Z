!R = !Scratch0
!G = !Scratch1
!B = !Scratch2

!H = !Scratch3
!S = !Scratch4
!V = !Scratch5

!Delta = !Scratch6
!Min = !Scratch7

macro SeparateChannels(value)
    REP #$20
    LDA <value>
    LSR
    LSR
    XBA
    AND #$001F
    STA !B

    LDA <value>
    CLC
    ASL
    ASL
    ASL
    SEP #$20

    XBA
    AND #$1F 
    STA !G

    LDA <value>
    AND #$1F
    STA !R
endmacro

macro JoinChannels()
    LDA !B      ;
    CLC         ;
    ASL         ;
    ASL         ;
    STA !B      ;!B = !B<<2
    LDA !G      ;
    LSR         ;
    LSR         ;
    LSR         ;
    ORA !B      ;!B = !B<<2|!G>>3
    STA !B      ;
                ;
    LDA !G      ;
    CLC         ;
    ASL         ;
    ASL         ;
    ASL         ;
    ASL         ;
    ASL         ;
    ORA !R      ;!G = !G<<5|!R
    STA !G      ;

endmacro

macro CalculateSV()
    LDA !R
    CMP !G
    BCC ?+      ;if(!R >= !G)
                ;{
    CMP !B      ;   if(!R >= !B)
    BCC ?++     ;   {
                ;
    LDX #$0000  ;       X = Max = !R;
                ;
    LDA !G      ;       if(!G >= !B)
    CMP !B      ;       {
    BCC ?++++   ;
                ;
    LDA !B      ;
    STA !Min    ;           !Min = !B;
    BRA ?+++    ;       }
                ;       else
?++++           ;       
    STA !Min    ;           !min = !G;
    BRA ?+++    ;   }
                ;
?++             ;   else
                ;   {
    LDX #$0002  ;       X = Max = !B;
    LDA !G      ;       
    STA !Min    ;       !Min = !G;
    BRA ?+++    ;   }
                ;else
?+              ;{
    CMP !B      ;
    BCC ?++     ;       if(!R >= B)
                ;       {
    LDX #$0001  ;           X = Max = !G;
    LDA !B      ;           
    STA !Min    ;           !Min = !B;
    BRA ?+++    ;       }
?++             ;       else
    LDA !R      ;       {
    STA !Min    ;           !Min = !R;
                ;
    LDA !G      ;
    CMP !B      ;
    BCC ?++++   ;           if(!G >= !B)
                ;           {
    LDX #$0001  ;               X = Max = !G;
    BRA ?+++    ;
                ;           }
?++++           ;           else
                ;           {
    LDX #$0002  ;               X = Max = !B;
                ;           }
?+++            ;}
    LDA !R,x    ;
    STA !V      ;!V = Max;
    SEC         ;
    SBC !Min    ;
    STA !Delta  ;!Delta = Max - !Min;
    BNE ?+
    LDX #$0003  
?+
    PHB
    LDA #$00
    PHA
    PLB

    %Mul(" !Delta", " #$1F")
    %DivWAfterMul(" !V")

    LDA !MultiplicationResult
    STA !S      ;!S = !Delta/!Max
    PLB

    LDA !V
    BNE +
    STZ !S      ; if(Max == 0) !S = 0;
+
    REP #$20
    TXA         ;\
    CLC         ;|
    ASL         ;|X *= 2
    TAX         ;/
    SEP #$20

endmacro

pmTab:
    db $1F,$1E,$1D,$1C,$1B,$1A,$19,$18,$17,$16,$15,$14,$13,$12,$11,$10,$0F,$0E,$0D,$0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00

qmTab:
    db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F
    db $1F,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1F,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
    db $1F,$1E,$1E,$1D,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1F,$1E,$1E,$1D,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1E,$1E,$1E,$1D,$1D
    db $1F,$1E,$1D,$1D,$1C,$1C,$1E,$1E,$1D,$1C,$1C,$1E,$1E,$1D,$1D,$1C,$1F,$1E,$1D,$1D,$1C,$1C,$1E,$1E,$1D,$1C,$1C,$1E,$1E,$1D,$1D,$1C
    db $1F,$1E,$1D,$1C,$1C,$1B,$1E,$1D,$1D,$1C,$1B,$1E,$1E,$1D,$1C,$1B,$1F,$1E,$1D,$1C,$1C,$1B,$1E,$1D,$1D,$1C,$1B,$1E,$1E,$1D,$1C,$1B
    db $1F,$1E,$1D,$1C,$1B,$1A,$1E,$1D,$1C,$1B,$1A,$1E,$1D,$1C,$1B,$1A,$1F,$1E,$1D,$1C,$1B,$1A,$1E,$1D,$1C,$1B,$1A,$1E,$1D,$1C,$1B,$1A
    db $1F,$1D,$1C,$1B,$1A,$19,$1E,$1D,$1C,$1A,$19,$1E,$1D,$1C,$1B,$1A,$1F,$1D,$1C,$1B,$1A,$19,$1E,$1D,$1C,$1A,$19,$1E,$1D,$1C,$1B,$1A
    db $1F,$1D,$1C,$1B,$19,$18,$1E,$1C,$1B,$1A,$18,$1E,$1D,$1B,$1A,$19,$1F,$1D,$1C,$1B,$19,$18,$1E,$1C,$1B,$1A,$18,$1E,$1D,$1B,$1A,$19
    db $1F,$1D,$1C,$1A,$19,$17,$1E,$1C,$1B,$19,$18,$1E,$1D,$1B,$1A,$18,$1F,$1D,$1C,$1A,$19,$17,$1E,$1C,$1B,$19,$18,$1E,$1D,$1B,$1A,$18
    db $1F,$1D,$1B,$19,$18,$16,$1D,$1C,$1A,$18,$17,$1E,$1C,$1B,$19,$17,$1F,$1D,$1B,$19,$18,$16,$1D,$1C,$1A,$18,$17,$1E,$1C,$1B,$19,$17
    db $1F,$1D,$1B,$19,$17,$15,$1D,$1B,$1A,$18,$16,$1E,$1C,$1A,$18,$16,$1F,$1D,$1B,$19,$17,$15,$1D,$1B,$1A,$18,$16,$1E,$1C,$1A,$18,$16
    db $1F,$1C,$1A,$18,$16,$14,$1D,$1B,$19,$17,$15,$1E,$1C,$1A,$18,$16,$1F,$1C,$1A,$18,$16,$14,$1D,$1B,$19,$17,$15,$1E,$1C,$1A,$18,$16
    db $1F,$1C,$1A,$18,$16,$13,$1D,$1B,$19,$16,$14,$1E,$1C,$19,$17,$15,$1F,$1C,$1A,$18,$16,$13,$1D,$1B,$19,$16,$14,$1E,$1C,$19,$17,$15
    db $1F,$1C,$1A,$17,$15,$12,$1D,$1A,$18,$16,$13,$1E,$1B,$19,$16,$14,$1F,$1C,$1A,$17,$15,$12,$1D,$1A,$18,$16,$13,$1E,$1B,$19,$16,$14
    db $1F,$1C,$19,$17,$14,$11,$1D,$1A,$18,$15,$12,$1E,$1B,$18,$16,$13,$1F,$1C,$19,$17,$14,$11,$1D,$1A,$18,$15,$12,$1E,$1B,$18,$16,$13
    db $1F,$1C,$19,$16,$13,$10,$1D,$1A,$17,$14,$11,$1E,$1B,$18,$15,$12,$1F,$1C,$19,$16,$13,$10,$1D,$1A,$17,$14,$11,$1E,$1B,$18,$15,$12
    db $1F,$1C,$19,$16,$13,$10,$1D,$1A,$17,$14,$11,$1E,$1B,$18,$15,$12,$1F,$1C,$19,$16,$13,$10,$1D,$1A,$17,$14,$11,$1E,$1B,$18,$15,$12
    db $1F,$1B,$18,$15,$12,$0F,$1C,$19,$16,$13,$10,$1D,$1A,$17,$14,$11,$1F,$1B,$18,$15,$12,$0F,$1C,$19,$16,$13,$10,$1D,$1A,$17,$14,$11
    db $1F,$1B,$18,$14,$11,$0E,$1C,$19,$16,$12,$0F,$1D,$1A,$17,$13,$10,$1F,$1B,$18,$14,$11,$0E,$1C,$19,$16,$12,$0F,$1D,$1A,$17,$13,$10
    db $1F,$1B,$17,$14,$10,$0D,$1C,$19,$15,$11,$0E,$1D,$1A,$16,$13,$0F,$1F,$1B,$17,$14,$10,$0D,$1C,$19,$15,$11,$0E,$1D,$1A,$16,$13,$0F
    db $1F,$1B,$17,$13,$10,$0C,$1C,$18,$15,$11,$0D,$1D,$1A,$16,$12,$0E,$1F,$1B,$17,$13,$10,$0C,$1C,$18,$15,$11,$0D,$1D,$1A,$16,$12,$0E
    db $1F,$1B,$17,$13,$0F,$0B,$1C,$18,$14,$10,$0C,$1D,$19,$15,$11,$0D,$1F,$1B,$17,$13,$0F,$0B,$1C,$18,$14,$10,$0C,$1D,$19,$15,$11,$0D
    db $1F,$1A,$16,$12,$0E,$0A,$1C,$18,$14,$0F,$0B,$1D,$19,$15,$11,$0D,$1F,$1A,$16,$12,$0E,$0A,$1C,$18,$14,$0F,$0B,$1D,$19,$15,$11,$0D
    db $1F,$1A,$16,$12,$0D,$09,$1C,$17,$13,$0F,$0A,$1D,$19,$14,$10,$0C,$1F,$1A,$16,$12,$0D,$09,$1C,$17,$13,$0F,$0A,$1D,$19,$14,$10,$0C
    db $1F,$1A,$16,$11,$0D,$08,$1C,$17,$13,$0E,$0A,$1D,$19,$14,$10,$0B,$1F,$1A,$16,$11,$0D,$08,$1C,$17,$13,$0E,$0A,$1D,$19,$14,$10,$0B
    db $1F,$1A,$15,$10,$0C,$07,$1B,$17,$12,$0D,$09,$1D,$18,$14,$0F,$0A,$1F,$1A,$15,$10,$0C,$07,$1B,$17,$12,$0D,$09,$1D,$18,$14,$0F,$0A
    db $1F,$1A,$15,$10,$0B,$06,$1B,$16,$12,$0D,$08,$1D,$18,$13,$0E,$09,$1F,$1A,$15,$10,$0B,$06,$1B,$16,$12,$0D,$08,$1D,$18,$13,$0E,$09
    db $1F,$19,$14,$0F,$0A,$05,$1B,$16,$11,$0C,$07,$1D,$18,$13,$0E,$09,$1F,$19,$14,$0F,$0A,$05,$1B,$16,$11,$0C,$07,$1D,$18,$13,$0E,$09
    db $1F,$19,$14,$0F,$0A,$04,$1B,$16,$11,$0B,$06,$1D,$18,$12,$0D,$08,$1F,$19,$14,$0F,$0A,$04,$1B,$16,$11,$0B,$06,$1D,$18,$12,$0D,$08
    db $1F,$19,$14,$0E,$09,$03,$1B,$15,$10,$0B,$05,$1D,$17,$12,$0C,$07,$1F,$19,$14,$0E,$09,$03,$1B,$15,$10,$0B,$05,$1D,$17,$12,$0C,$07
    db $1F,$19,$13,$0E,$08,$02,$1B,$15,$10,$0A,$04,$1D,$17,$11,$0C,$06,$1F,$19,$13,$0E,$08,$02,$1B,$15,$10,$0A,$04,$1D,$17,$11,$0C,$06
    db $1F,$19,$13,$0D,$07,$01,$1B,$15,$0F,$09,$03,$1D,$17,$11,$0B,$05,$1F,$19,$13,$0D,$07,$01,$1B,$15,$0F,$09,$03,$1D,$17,$11,$0B,$05

tmTab:
    db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F
    db $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E
    db $1D,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1D,$1E,$1E,$1D,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1E,$1E,$1E,$1D,$1D,$1D,$1E,$1E
    db $1C,$1C,$1D,$1D,$1E,$1E,$1C,$1C,$1D,$1E,$1E,$1C,$1C,$1D,$1D,$1E,$1C,$1C,$1D,$1D,$1E,$1E,$1C,$1C,$1D,$1E,$1E,$1C,$1C,$1D,$1D,$1E
    db $1B,$1B,$1C,$1D,$1E,$1E,$1B,$1C,$1D,$1D,$1E,$1B,$1C,$1C,$1D,$1E,$1B,$1B,$1C,$1D,$1E,$1E,$1B,$1C,$1D,$1D,$1E,$1B,$1C,$1C,$1D,$1E
    db $1A,$1A,$1B,$1C,$1D,$1E,$1A,$1B,$1C,$1D,$1E,$1A,$1B,$1C,$1D,$1E,$1A,$1A,$1B,$1C,$1D,$1E,$1A,$1B,$1C,$1D,$1E,$1A,$1B,$1C,$1D,$1E
    db $19,$1A,$1B,$1C,$1D,$1E,$19,$1A,$1C,$1D,$1E,$19,$1A,$1B,$1C,$1D,$19,$1A,$1B,$1C,$1D,$1E,$19,$1A,$1C,$1D,$1E,$19,$1A,$1B,$1C,$1D
    db $18,$19,$1A,$1B,$1D,$1E,$18,$1A,$1B,$1C,$1E,$18,$19,$1B,$1C,$1D,$18,$19,$1A,$1B,$1D,$1E,$18,$1A,$1B,$1C,$1E,$18,$19,$1B,$1C,$1D
    db $17,$18,$1A,$1B,$1D,$1E,$18,$19,$1B,$1C,$1E,$17,$19,$1A,$1C,$1D,$17,$18,$1A,$1B,$1D,$1E,$18,$19,$1B,$1C,$1E,$17,$19,$1A,$1C,$1D
    db $16,$17,$19,$1B,$1C,$1E,$17,$18,$1A,$1C,$1D,$16,$18,$19,$1B,$1D,$16,$17,$19,$1B,$1C,$1E,$17,$18,$1A,$1C,$1D,$16,$18,$19,$1B,$1D
    db $15,$16,$18,$1A,$1C,$1E,$16,$18,$1A,$1B,$1D,$15,$17,$19,$1B,$1D,$15,$16,$18,$1A,$1C,$1E,$16,$18,$1A,$1B,$1D,$15,$17,$19,$1B,$1D
    db $14,$16,$18,$1A,$1C,$1E,$15,$17,$19,$1B,$1D,$14,$16,$18,$1A,$1C,$14,$16,$18,$1A,$1C,$1E,$15,$17,$19,$1B,$1D,$14,$16,$18,$1A,$1C
    db $13,$15,$17,$19,$1C,$1E,$14,$16,$19,$1B,$1D,$13,$16,$18,$1A,$1C,$13,$15,$17,$19,$1C,$1E,$14,$16,$19,$1B,$1D,$13,$16,$18,$1A,$1C
    db $12,$14,$16,$19,$1B,$1E,$13,$16,$18,$1A,$1D,$12,$15,$17,$1A,$1C,$12,$14,$16,$19,$1B,$1E,$13,$16,$18,$1A,$1D,$12,$15,$17,$1A,$1C
    db $11,$13,$16,$18,$1B,$1E,$12,$15,$18,$1A,$1D,$11,$14,$17,$19,$1C,$11,$13,$16,$18,$1B,$1E,$12,$15,$18,$1A,$1D,$11,$14,$17,$19,$1C
    db $10,$12,$15,$18,$1B,$1E,$11,$14,$17,$1A,$1D,$10,$13,$16,$19,$1C,$10,$12,$15,$18,$1B,$1E,$11,$14,$17,$1A,$1D,$10,$13,$16,$19,$1C
    db $0F,$12,$15,$18,$1B,$1E,$11,$14,$17,$1A,$1D,$10,$13,$16,$19,$1C,$0F,$12,$15,$18,$1B,$1E,$11,$14,$17,$1A,$1D,$10,$13,$16,$19,$1C
    db $0E,$11,$14,$17,$1A,$1D,$10,$13,$16,$19,$1C,$0F,$12,$15,$18,$1B,$0E,$11,$14,$17,$1A,$1D,$10,$13,$16,$19,$1C,$0F,$12,$15,$18,$1B
    db $0D,$10,$13,$17,$1A,$1D,$0F,$12,$16,$19,$1C,$0E,$11,$14,$18,$1B,$0D,$10,$13,$17,$1A,$1D,$0F,$12,$16,$19,$1C,$0E,$11,$14,$18,$1B
    db $0C,$0F,$13,$16,$1A,$1D,$0E,$11,$15,$19,$1C,$0D,$10,$14,$17,$1B,$0C,$0F,$13,$16,$1A,$1D,$0E,$11,$15,$19,$1C,$0D,$10,$14,$17,$1B
    db $0B,$0E,$12,$16,$1A,$1D,$0D,$11,$15,$18,$1C,$0C,$10,$13,$17,$1B,$0B,$0E,$12,$16,$1A,$1D,$0D,$11,$15,$18,$1C,$0C,$10,$13,$17,$1B
    db $0A,$0D,$11,$15,$19,$1D,$0C,$10,$14,$18,$1C,$0B,$0F,$13,$17,$1B,$0A,$0D,$11,$15,$19,$1D,$0C,$10,$14,$18,$1C,$0B,$0F,$13,$17,$1B
    db $09,$0D,$11,$15,$19,$1D,$0B,$0F,$14,$18,$1C,$0A,$0E,$12,$16,$1A,$09,$0D,$11,$15,$19,$1D,$0B,$0F,$14,$18,$1C,$0A,$0E,$12,$16,$1A
    db $08,$0C,$10,$14,$19,$1D,$0A,$0F,$13,$17,$1C,$09,$0D,$12,$16,$1A,$08,$0C,$10,$14,$19,$1D,$0A,$0F,$13,$17,$1C,$09,$0D,$12,$16,$1A
    db $07,$0B,$10,$14,$19,$1D,$0A,$0E,$13,$17,$1C,$08,$0D,$11,$16,$1A,$07,$0B,$10,$14,$19,$1D,$0A,$0E,$13,$17,$1C,$08,$0D,$11,$16,$1A
    db $06,$0A,$0F,$14,$18,$1D,$09,$0D,$12,$17,$1B,$07,$0C,$10,$15,$1A,$06,$0A,$0F,$14,$18,$1D,$09,$0D,$12,$17,$1B,$07,$0C,$10,$15,$1A
    db $05,$09,$0E,$13,$18,$1D,$08,$0D,$12,$16,$1B,$06,$0B,$10,$15,$1A,$05,$09,$0E,$13,$18,$1D,$08,$0D,$12,$16,$1B,$06,$0B,$10,$15,$1A
    db $04,$09,$0E,$13,$18,$1D,$07,$0C,$11,$16,$1B,$05,$0A,$0F,$14,$19,$04,$09,$0E,$13,$18,$1D,$07,$0C,$11,$16,$1B,$05,$0A,$0F,$14,$19
    db $03,$08,$0D,$12,$18,$1D,$06,$0B,$11,$16,$1B,$04,$0A,$0F,$14,$19,$03,$08,$0D,$12,$18,$1D,$06,$0B,$11,$16,$1B,$04,$0A,$0F,$14,$19
    db $02,$07,$0C,$12,$17,$1D,$05,$0B,$10,$15,$1B,$03,$09,$0E,$14,$19,$02,$07,$0C,$12,$17,$1D,$05,$0B,$10,$15,$1B,$03,$09,$0E,$14,$19
    db $01,$06,$0C,$11,$17,$1D,$04,$0A,$10,$15,$1B,$02,$08,$0E,$13,$19,$01,$06,$0C,$11,$17,$1D,$04,$0A,$10,$15,$1B,$02,$08,$0E,$13,$19
    db $00,$05,$0B,$11,$17,$1D,$03,$09,$0F,$15,$1B,$01,$07,$0D,$13,$19,$00,$05,$0B,$11,$17,$1D,$03,$09,$0F,$15,$1B,$01,$07,$0D,$13,$19

Mult60degrees:

;Delta -31 -30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -09 -08 -07 -06 -05 -04 -03 -02 -01  00  01  02  03  04  05  06  07  08  09  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31 PAD Max-Min
    db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00; 00
    db $5B,$60,$65,$6B,$70,$75,$7B,$80,$85,$8B,$90,$95,$9B,$A0,$A5,$AB,$B0,$B5,$BB,$C0,$C5,$CB,$D0,$D5,$DB,$E0,$E5,$EB,$F0,$F5,$FB,$00,$05,$0B,$10,$15,$1B,$20,$25,$2B,$30,$35,$3B,$40,$45,$4B,$50,$55,$5B,$60,$65,$6B,$70,$75,$7B,$80,$85,$8B,$90,$95,$9B,$A0,$A5,$00; 01
    db $AD,$B0,$B3,$B5,$B8,$BB,$BD,$C0,$C3,$C5,$C8,$CB,$CD,$D0,$D3,$D5,$D8,$DB,$DD,$E0,$E3,$E5,$E8,$EB,$ED,$F0,$F3,$F5,$F8,$FB,$FD,$00,$03,$05,$08,$0B,$0D,$10,$13,$15,$18,$1B,$1D,$20,$23,$25,$28,$2B,$2D,$30,$33,$35,$38,$3B,$3D,$40,$43,$45,$48,$4B,$4D,$50,$53,$00; 02
    db $C9,$CB,$CC,$CE,$D0,$D2,$D4,$D5,$D7,$D9,$DB,$DC,$DE,$E0,$E2,$E4,$E5,$E7,$E9,$EB,$EC,$EE,$F0,$F2,$F4,$F5,$F7,$F9,$FB,$FC,$FE,$00,$02,$04,$05,$07,$09,$0B,$0C,$0E,$10,$12,$14,$15,$17,$19,$1B,$1C,$1E,$20,$22,$24,$25,$27,$29,$2B,$2C,$2E,$30,$32,$34,$35,$37,$00; 03
    db $D7,$D8,$D9,$DB,$DC,$DD,$DF,$E0,$E1,$E3,$E4,$E5,$E7,$E8,$E9,$EB,$EC,$ED,$EF,$F0,$F1,$F3,$F4,$F5,$F7,$F8,$F9,$FB,$FC,$FD,$FF,$00,$01,$03,$04,$05,$07,$08,$09,$0B,$0C,$0D,$0F,$10,$11,$13,$14,$15,$17,$18,$19,$1B,$1C,$1D,$1F,$20,$21,$23,$24,$25,$27,$28,$29,$00; 04
    db $DF,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$00,$01,$02,$03,$04,$05,$06,$07,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$00; 05
    db $E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$EC,$ED,$EE,$EF,$F0,$F1,$F2,$F3,$F4,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FC,$FD,$FE,$FF,$00,$01,$02,$03,$04,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$00; 06
    db $E8,$E9,$EA,$EB,$EB,$EC,$ED,$EE,$EE,$EF,$F0,$F1,$F2,$F2,$F3,$F4,$F5,$F5,$F6,$F7,$F8,$F8,$F9,$FA,$FB,$FB,$FC,$FD,$FE,$FE,$FF,$00,$01,$02,$02,$03,$04,$05,$05,$06,$07,$08,$08,$09,$0A,$0B,$0B,$0C,$0D,$0E,$0E,$0F,$10,$11,$12,$12,$13,$14,$15,$15,$16,$17,$18,$00; 07
    db $EB,$EC,$ED,$ED,$EE,$EF,$EF,$F0,$F1,$F1,$F2,$F3,$F3,$F4,$F5,$F5,$F6,$F7,$F7,$F8,$F9,$F9,$FA,$FB,$FB,$FC,$FD,$FD,$FE,$FF,$FF,$00,$01,$01,$02,$03,$03,$04,$05,$05,$06,$07,$07,$08,$09,$09,$0A,$0B,$0B,$0C,$0D,$0D,$0E,$0F,$0F,$10,$11,$11,$12,$13,$13,$14,$15,$00; 08
    db $EE,$EE,$EF,$EF,$F0,$F1,$F1,$F2,$F2,$F3,$F4,$F4,$F5,$F5,$F6,$F7,$F7,$F8,$F8,$F9,$F9,$FA,$FB,$FB,$FC,$FC,$FD,$FE,$FE,$FF,$FF,$00,$01,$01,$02,$02,$03,$04,$04,$05,$05,$06,$07,$07,$08,$08,$09,$09,$0A,$0B,$0B,$0C,$0C,$0D,$0E,$0E,$0F,$0F,$10,$11,$11,$12,$12,$00; 09
    db $EF,$F0,$F1,$F1,$F2,$F2,$F3,$F3,$F4,$F4,$F5,$F5,$F6,$F6,$F7,$F7,$F8,$F9,$F9,$FA,$FA,$FB,$FB,$FC,$FC,$FD,$FD,$FE,$FE,$FF,$FF,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F,$10,$11,$00; 10
    db $F1,$F1,$F2,$F2,$F3,$F3,$F4,$F4,$F5,$F5,$F6,$F6,$F7,$F7,$F8,$F8,$F9,$F9,$FA,$FA,$FB,$FB,$FC,$FC,$FD,$FD,$FE,$FE,$FF,$FF,$00,$00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F,$00; 11
    db $F2,$F3,$F3,$F4,$F4,$F4,$F5,$F5,$F6,$F6,$F7,$F7,$F8,$F8,$F8,$F9,$F9,$FA,$FA,$FB,$FB,$FC,$FC,$FC,$FD,$FD,$FE,$FE,$FF,$FF,$00,$00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0C,$0D,$0D,$0E,$00; 12
    db $F3,$F4,$F4,$F5,$F5,$F5,$F6,$F6,$F7,$F7,$F7,$F8,$F8,$F9,$F9,$F9,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$00,$00,$00,$01,$01,$02,$02,$02,$03,$03,$04,$04,$05,$05,$05,$06,$06,$07,$07,$07,$08,$08,$09,$09,$09,$0A,$0A,$0B,$0B,$0B,$0C,$0C,$0D,$00; 13
    db $F4,$F5,$F5,$F5,$F6,$F6,$F6,$F7,$F7,$F8,$F8,$F8,$F9,$F9,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FD,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$00,$00,$00,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$05,$05,$05,$06,$06,$06,$07,$07,$08,$08,$08,$09,$09,$0A,$0A,$0A,$0B,$0B,$0B,$0C,$00; 14
    db $F5,$F5,$F6,$F6,$F6,$F7,$F7,$F7,$F8,$F8,$F9,$F9,$F9,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FC,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$04,$04,$04,$05,$05,$05,$06,$06,$06,$07,$07,$07,$08,$08,$09,$09,$09,$0A,$0A,$0A,$0B,$0B,$00; 15
    db $F6,$F6,$F6,$F7,$F7,$F7,$F8,$F8,$F8,$F9,$F9,$F9,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FC,$FD,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$05,$06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$09,$0A,$0A,$0A,$00; 16
    db $F6,$F7,$F7,$F7,$F8,$F8,$F8,$F8,$F9,$F9,$F9,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,$05,$06,$06,$06,$07,$07,$07,$08,$08,$08,$08,$09,$09,$09,$0A,$00; 17
    db $F7,$F7,$F7,$F8,$F8,$F8,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05,$06,$06,$06,$07,$07,$07,$07,$08,$08,$08,$09,$09,$09,$00; 18
    db $F7,$F8,$F8,$F8,$F8,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$08,$08,$08,$08,$09,$00; 19
    db $F8,$F8,$F8,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$07,$08,$08,$08,$00; 20
    db $F8,$F8,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$07,$08,$08,$00; 21
    db $F8,$F9,$F9,$F9,$F9,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$07,$08,$00; 22
    db $F9,$F9,$F9,$FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$06,$07,$07,$07,$00; 23
    db $F9,$F9,$FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$06,$07,$07,$00; 24
    db $F9,$FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$06,$07,$00; 25
    db $FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$00; 26
    db $FA,$FA,$FA,$FA,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06,$06,$06,$06,$00; 27
    db $FA,$FA,$FA,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06,$06,$06,$00; 28
    db $FA,$FA,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06,$06,$00; 29
    db $FA,$FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06,$00; 30
    db $FB,$FB,$FB,$FB,$FB,$FC,$FC,$FC,$FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$00; 31
CalculateHue:
    dw RMax
    dw GMax
    dw BMax
    dw Delta0
RMax:
    LDA #$00
    XBA

    LDA !Delta
    REP #$20
    CLC
    ASL
    ASL
    ASL
    ASL
    ASL
    ASL
    SEP #$20
    PHA

    LDA !G
    SEC
    SBC !B
    CLC
    ADC #$1F
    ORA $01,s
    TAX
    PLA

    LDA.l Mult60degrees,x
    BPL +
    CLC
    ADC #$20
+
    STA !H
RTS

GMax:
    LDA #$00
    XBA

    LDA !Delta
    REP #$20
    CLC
    ASL
    ASL
    ASL
    ASL
    ASL
    ASL
    SEP #$20
    PHA

    LDA !B
    SEC
    SBC !R
    CLC
    ADC #$1F
    ORA $01,s
    TAX
    PLA

    LDA.l Mult60degrees,x
    CLC
    ADC #$0B
    STA !H
RTS

BMax:
    LDA #$00
    XBA

    LDA !Delta
    REP #$20
    CLC
    ASL
    ASL
    ASL
    ASL
    ASL
    ASL
    SEP #$20
    PHA

    LDA !R
    SEC
    SBC !G
    CLC
    ADC #$1F
    ORA $01,s
    TAX
    PLA

    LDA.l Mult60degrees,x
    CLC
    ADC #$15
    STA !H
RTS

Delta0:
    STZ !H
RTS

!BasePointer #= $01+4
!Length = !BasePointer+7,s
!Destination = !BasePointer+5,s
!Source = !BasePointer+3,s

!SrcIndex = !BasePointer-2,s
!DstIndex = !BasePointer-4,s

%StartFunction("SetBaseAsHSV", $04)

    REP #$30                                ;X/Y 16 bits
    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
                                            ;
-                                           ;
    LDA !SrcIndex                           ;!SrcIndex < !Length;)
    CMP !Length                             ;
    BCC +                                   ;              
    SEP #$30                                ;
%RTLN($04)                                  ;
+                                           ;{
    TAY                                     ;   Y = !SrcIndex; 
    INC A                                   ;
    INC A                                   ;
    STA !SrcIndex                           ;   !SrcIndex+=2;
    SEP #$20                                ;
                                            ;
    %SeparateChannels("(!Source),y")        ;   !R = Red value; !G = Green Value; !B = Blue Value;
    %CalculateSV()                          ;   !S = Saturation; !V = Value;
    JSR (CalculateHue,x)                    ;   !H = Hue;
                                            ;
    REP #$20                                ;
    LDA !DstIndex                           ;   
    TAY                                     ;   Y = !DstIndex;
    SEP #$20                                ;
    LDA !H                                  ;
    STA (!Destination),y                    ;   !Destination[Y] = !H
    INY                                     ;
    LDA !S                                  ;
    STA (!Destination),y                    ;   !Destination[Y+1] = !S
    INY                                     ;
    LDA !V                                  ;
    STA (!Destination),y                    ;   !Destination[Y+2] = !V
    INY                                     ;
    REP #$20                                ;
    TYA                                     ;
    STA !DstIndex                           ;   !DstIndex+=3;
    JMP -                                   ;}

%StartFunction("SetBaseAsRGB", $04)

    REP #$30                                ;X/Y 16 bits
    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
                                            ;
-                                           ;
    LDA !SrcIndex                           ;!SrcIndex < !Length;)
    CMP !Length                             ;
    BCC +   ;              
    SEP #$30                                ;
%RTLN($04)                                  ;
+                                           ;{
    TAY                                     ;   Y = !SrcIndex; 
    INC A                                   ;
    INC A                                   ;
    STA !SrcIndex                           ;   !SrcIndex+=2;
    SEP #$20                                ;
                                            ;
    %SeparateChannels("(!Source),y")        ;   !R = Red value; !G = Green Value; !B = Blue Value;
                                            ;
    REP #$20                                ;
    LDA !DstIndex                           ;   
    TAY                                     ;   Y = !DstIndex;
    SEP #$20                                ;
    LDA !R                                  ;
    STA (!Destination),y                    ;   !Destination[Y] = !H
    INY                                     ;
    LDA !G                                  ;
    STA (!Destination),y                    ;   !Destination[Y+1] = !S
    INY                                     ;
    LDA !B                                  ;
    STA (!Destination),y                    ;   !Destination[Y+2] = !V
    INY                                     ;
    REP #$20                                ;
    TYA                                     ;
    STA !DstIndex                           ;   !DstIndex+=3;
    BRA -                                   ;}

Hi:
    db $00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05

!BasePointer #= $01+5
!NewValue2 = !BasePointer+10,s
!NewValue1 = !BasePointer+9,s
!NewValue = !BasePointer+9,s
!Length = !BasePointer+7,s
!Destination = !BasePointer+5,s
!Source = !BasePointer+3,s

!SrcIndex = !BasePointer-2,s
!DstIndex = !BasePointer-4,s
!Hi = !BasePointer-5,s

macro HueToHi(value)
    LDA #$00
    XBA
    LDA <value>
    STA !H
    TAX

    LDA.l Hi,x
    CLC
    ASL
    STA !Hi
endmacro

macro HSVToP()
    LDA #$00
    XBA
    LDA !S
    TAX

    %Mul(".l pmTab,x"," !V")
    %DivWAfterMul(" #$1F")
    LDA !DivisionResult

endmacro

macro HSVToQ()
    LDA #$00
    XBA

    LDA !S
    REP #$20
    CLC
    ASL
    ASL
    ASL
    ASL
    ASL
    SEP #$20
    ORA !H
    TAX

    %Mul(".l qmTab,x"," !V")
    %DivWAfterMul(" #$1F")
    LDA !DivisionResult

endmacro

macro HSVToT()
    LDA #$00
    XBA
    
    LDA !S
    REP #$20
    CLC
    ASL
    ASL
    ASL
    ASL
    ASL
    SEP #$20
    ORA !H
    TAX

    %Mul(".l tmTab,x"," !V")
    %DivWAfterMul(" #$1F")
    LDA !DivisionResult

endmacro

macro EndLoopHSV()
    LDA !Hi
    AND #$00FF
    TAX
    SEP #$20

    JSR (CalculateRGBBasedOnHiPQT,x)

    %JoinChannels()

    REP #$20
    LDA !DstIndex
    TAY

    LDA !G
    STA (!Destination),y

    INY
    INY
    TYA
    STA !DstIndex
endmacro

%StartFunction("ChangePaletteHue", $05)
    %HueToHi("!NewValue")   

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    INY           
        
    LDA (!Source),y         
    STA !S
    INY
    INY
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    BRA -

%StartFunction("ChangePaletteSaturation", $05)

    LDA !NewValue
    STA !S
    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY
    SEP #$20

    LDA (!Source),y 
    STA !H
    INY
    INY       
    %HueToHi(!H)           

    LDA (!Source),y         
    STA !V
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    BRA -

%StartFunction("ChangePaletteValue", $05)

    LDA !NewValue
    STA !V
    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY
    SEP #$20

    LDA (!Source),y 
    STA !H
    INY    
    %HueToHi(!H)           

    LDA (!Source),y         
    STA !S
    INY
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    BRA -

%StartFunction("ChangePaletteHueAndSaturation", $05)

    LDA !NewValue2
    STA !S

    %HueToHi("!NewValue1") 
    
    REP #$30
    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY
    SEP #$20

    INY
    INY          

    LDA (!Source),y         
    STA !V
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    BRA -

%StartFunction("ChangePaletteHueAndValue", $05)

    LDA !NewValue2
    STA !V

    %HueToHi("!NewValue1")

    REP #$30
    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY
    SEP #$20

    INY          

    LDA (!Source),y         
    STA !S
    INY
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    BRA -

%StartFunction("ChangePaletteSaturationAndValue", $05)

    LDA !NewValue1
    STA !S
    LDA !NewValue2
    STA !V

    REP #$30
    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY
    SEP #$20

    %HueToHi("(!Source),y")
    INY          
    INY
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    BRA -

MulRatio:
    db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F
    db $00,$01*2,$02*2,$03*2,$04*2,$05*2,$06*2,$07*2,$08*2,$09*2,$0A*2,$0B*2,$0C*2,$0D*2,$0E*2,$0F*2,$10*2,$11*2,$12*2,$13*2,$14*2,$15*2,$16*2,$17*2,$18*2,$19*2,$1A*2,$1B*2,$1C*2,$1D*2,$1E*2,$1F*2
    db $00,$01*3,$02*3,$03*3,$04*3,$05*3,$06*3,$07*3,$08*3,$09*3,$0A*3,$0B*3,$0C*3,$0D*3,$0E*3,$0F*3,$10*3,$11*3,$12*3,$13*3,$14*3,$15*3,$16*3,$17*3,$18*3,$19*3,$1A*3,$1B*3,$1C*3,$1D*3,$1E*3,$1F*3
    db $00,$01*4,$02*4,$03*4,$04*4,$05*4,$06*4,$07*4,$08*4,$09*4,$0A*4,$0B*4,$0C*4,$0D*4,$0E*4,$0F*4,$10*4,$11*4,$12*4,$13*4,$14*4,$15*4,$16*4,$17*4,$18*4,$19*4,$1A*4,$1B*4,$1C*4,$1D*4,$1E*4,$1F*4
    db $00,$01*5,$02*5,$03*5,$04*5,$05*5,$06*5,$07*5,$08*5,$09*5,$0A*5,$0B*5,$0C*5,$0D*5,$0E*5,$0F*5,$10*5,$11*5,$12*5,$13*5,$14*5,$15*5,$16*5,$17*5,$18*5,$19*5,$1A*5,$1B*5,$1C*5,$1D*5,$1E*5,$1F*5
    db $00,$01*6,$02*6,$03*6,$04*6,$05*6,$06*6,$07*6,$08*6,$09*6,$0A*6,$0B*6,$0C*6,$0D*6,$0E*6,$0F*6,$10*6,$11*6,$12*6,$13*6,$14*6,$15*6,$16*6,$17*6,$18*6,$19*6,$1A*6,$1B*6,$1C*6,$1D*6,$1E*6,$1F*6
    db $00,$01*7,$02*7,$03*7,$04*7,$05*7,$06*7,$07*7,$08*7,$09*7,$0A*7,$0B*7,$0C*7,$0D*7,$0E*7,$0F*7,$10*7,$11*7,$12*7,$13*7,$14*7,$15*7,$16*7,$17*7,$18*7,$19*7,$1A*7,$1B*7,$1C*7,$1D*7,$1E*7,$1F*7
    db $00,$01*8,$02*8,$03*8,$04*8,$05*8,$06*8,$07*8,$08*8,$09*8,$0A*8,$0B*8,$0C*8,$0D*8,$0E*8,$0F*8,$10*8,$11*8,$12*8,$13*8,$14*8,$15*8,$16*8,$17*8,$18*8,$19*8,$1A*8,$1B*8,$1C*8,$1D*8,$1E*8,$1F*8

macro RatioToX()
    LDA #$00
    XBA

    LDA !Ratio
    CLC
    REP #$30
    ASL
    ASL
    ASL
    ASL
    ASL
    SEP #$20
endmacro

macro ApplyRatio(value)
    ORA <value>
    TAX
    LDA.l MulRatio,x
endmacro

macro FlipRatio()
    LDA #$08
    SEC
    SBC !Ratio
    CLC
    ASL
    ASL
    ASL
    ASL
    STA !Ratio
endmacro

!BasePointer #= $01+5
!NewValue3 = !BasePointer+12,s
!NewValue2 = !BasePointer+11,s
!NewValue1 = !BasePointer+10,s
!NewValue = !BasePointer+10,s
!Ratio = !BasePointer+9,s
!Length = !BasePointer+7,s
!Destination = !BasePointer+5,s
!Source = !BasePointer+3,s

!SrcIndex = !BasePointer-2,s
!DstIndex = !BasePointer-4,s
!Hi = !BasePointer-5,s

%StartFunction("MixPaletteHue", $05)

    %RatioToX()
    %ApplyRatio("!NewValue")
    STA !NewValue
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue
    LSR
    LSR
    LSR
    STA !H

    %HueToHi("!H")
    INY
        
    REP #$20
    LDA (!Source),y         
    STA !S
    INY
    INY
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -

%StartFunction("MixPaletteSaturation", $05)

    %RatioToX()
    %ApplyRatio("!NewValue")
    STA !NewValue
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20
    LDA (!Source),y         
    STA !H
    %HueToHi("!H")
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue
    LSR
    LSR
    LSR
    STA !S

    INY
        
    REP #$20
    LDA (!Source),y         
    STA !V
    INY
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -

%StartFunction("MixPaletteValue", $05)

    %RatioToX()
    %ApplyRatio("!NewValue")
    STA !NewValue
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    LDA (!Source),y         
    STA !H
    SEP #$20
    %HueToHi("!H")
    INY
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue
    LSR
    LSR
    LSR
    STA !V

    INY
        
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -

%StartFunction("MixPaletteHueAndSaturation", $05)

    %RatioToX()
    %ApplyRatio("!NewValue1")
    STA !NewValue1
    %RatioToX()
    %ApplyRatio("!NewValue2")
    STA !NewValue2
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue1
    LSR
    LSR
    LSR
    STA !H

    %HueToHi("!H")
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue2
    LSR
    LSR
    LSR
    STA !S
    INY
        
    LDA (!Source),y         
    STA !V
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -

%StartFunction("MixPaletteHueAndValue", $05)

    %RatioToX()
    %ApplyRatio("!NewValue1")
    STA !NewValue1
    %RatioToX()
    %ApplyRatio("!NewValue2")
    STA !NewValue2
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue1
    LSR
    LSR
    LSR
    STA !H

    %HueToHi("!H")
    INY

    LDA (!Source),y         
    STA !S
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue2
    LSR
    LSR
    LSR
    STA !V
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -


%StartFunction("MixPaletteSaturationAndValue", $05)

    %RatioToX()
    %ApplyRatio("!NewValue1")
    STA !NewValue1
    %RatioToX()
    %ApplyRatio("!NewValue2")
    STA !NewValue2
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20

    %HueToHi("(!Source),y")
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue1
    LSR
    LSR
    LSR
    STA !S
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue2
    LSR
    LSR
    LSR
    STA !V
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -

%StartFunction("MixPaletteHueSaturationAndValue", $05)

    %RatioToX()
    %ApplyRatio("!NewValue1")
    STA !NewValue1
    %RatioToX()
    %ApplyRatio("!NewValue2")
    STA !NewValue2
    %RatioToX()
    %ApplyRatio("!NewValue3")
    STA !NewValue3
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue1
    LSR
    LSR
    LSR
    STA !H
    INY
    %HueToHi("!H")

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue2
    LSR
    LSR
    LSR
    STA !S
    INY

    LDA #$00
    XBA 

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue3
    LSR
    LSR
    LSR
    STA !V
    INY
    REP #$20
    TYA
    STA !SrcIndex

    %EndLoopHSV()

    JMP -

CalculateRGBBasedOnHiPQT:
    dw Hi0
    dw Hi1
    dw Hi2
    dw Hi3
    dw Hi4
    dw Hi5

Hi0:
    PHB
    LDA #$00
    PHA
    PLB

    LDA !V
    STA !R
    %HSVToT()
    STA !G
    %HSVToP()
    STA !B
    PLB
RTS

Hi1:
    PHB
    LDA #$00
    PHA
    PLB

    %HSVToQ()
    STA !R
    LDA !V
    STA !G
    %HSVToP()
    STA !B
    PLB
RTS

Hi2:
    PHB
    LDA #$00
    PHA
    PLB
    
    %HSVToP()
    STA !R
    LDA !V
    STA !G
    %HSVToT()
    STA !B
    PLB
RTS

Hi3:
    PHB
    LDA #$00
    PHA
    PLB
    
    %HSVToP()
    STA !R
    %HSVToQ()
    STA !G
    LDA !V
    STA !B
    PLB
RTS

Hi4:
    PHB
    LDA #$00
    PHA
    PLB
    
    %HSVToT()
    STA !R
    %HSVToP()
    STA !G
    LDA !V
    STA !B
    PLB
RTS

Hi5:
    PHB
    LDA #$00
    PHA
    PLB
    
    LDA !V
    STA !R
    %HSVToP()
    STA !G
    %HSVToQ()
    STA !B
    PLB
RTS

RandomizePalette:
%StartFunction("MixWithColor", $05)

    %RatioToX()
    %ApplyRatio("!NewValue1")
    STA !NewValue1
    %RatioToX()
    %ApplyRatio("!NewValue2")
    STA !NewValue2
    %RatioToX()
    %ApplyRatio("!NewValue3")
    STA !NewValue3
    %FlipRatio()

    REP #$30

    LDA #$0000                              ;
    STA !SrcIndex                           ;
    STA !DstIndex                           ;for(!SrcIndex = 0, !DstIndex = 0;
-
    LDA !DstIndex
    CMP !Length
    BCC +
    SEP #$30
    
%RTLN($05)
+
    LDA !SrcIndex
    TAY

    SEP #$20

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue1
    LSR
    LSR
    LSR
    STA !R
    INY

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue2
    LSR
    LSR
    LSR
    STA !G
    INY

    LDA !Ratio
    REP #$20
    ASL
    SEP #$20
    %ApplyRatio("(!Source),y")
    CLC
    ADC !NewValue3
    LSR
    LSR
    LSR
    STA !B
    INY
    REP #$20
    TYA
    STA !SrcIndex
    SEP #$20

    %JoinChannels()

    REP #$20
    LDA !DstIndex
    TAY

    LDA !G
    STA (!Destination),y

    INY
    INY
    TYA
    STA !DstIndex

    JMP -
MixWithBaseColor:
