;Get a*cos(b)
;Input:
;A = a, 8 bits
;X = b, 16 bits (min value 0, max value $02CF)
;Output:
;A = a*cos(b), 8 bits

    STA $0E
    LDY #$0000
    LDA.l CosTable,x
    BPL ?+
    EOR #$FF
    INC A
    LDY #$0001
?+
    STA $0F
    %MulW(" $0E", " $0F")
    REP #$20
    LDA !MultiplicationResult
?++
    if !sa1
        STA $2251
        SEP #$20
        LDA #$01
        STA $2250

        LDA #$7F
        STA $2253
        STZ $2254
    else
        STA $4204
        SEP #$20
        LDA #$7F
        STA $4206
        NOP : NOP : NOP : NOP
        NOP
    endif
    REP #$20
    CPY #$0001
    BEQ +
    LDA !DivisionResult
RTL
+
    LDA #$0000
    SEC
    SBC !DivisionResult
RTL

CosTable:
    db $7F,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7D,$7D,$7D,$7D,$7D,$7D,$7C,$7C,$7C,$7C,$7B,$7B,$7B,$7B,$7A
    db $7A,$7A,$7A,$79,$79,$79,$78,$78,$78,$77,$77,$76,$76,$76,$75,$75,$74,$74,$74,$73,$73,$72,$72,$71,$71,$70,$70,$6F,$6F,$6E
    db $6D,$6D,$6C,$6C,$6B,$6B,$6A,$69,$69,$68,$68,$67,$66,$66,$65,$64,$64,$63,$62,$61,$61,$60,$5F,$5F,$5E,$5D,$5C,$5C,$5B,$5A
    db $59,$59,$58,$57,$56,$55,$54,$54,$53,$52,$51,$50,$4F,$4F,$4E,$4D,$4C,$4B,$4A,$49,$48,$47,$47,$46,$45,$44,$43,$42,$41,$40
    db $3F,$3E,$3D,$3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30,$2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$21
    db $20,$1F,$1E,$1D,$1C,$1B,$1A,$19,$18,$17,$16,$14,$13,$12,$11,$10,$0F,$0E,$0D,$0C,$0B,$09,$08,$07,$06,$05,$04,$03,$02,$01
    db $00,$FF,$FE,$FD,$FC,$FB,$FA,$F9,$F8,$F7,$F5,$F4,$F3,$F2,$F1,$F0,$EF,$EE,$ED,$EC,$EA,$E9,$E8,$E7,$E6,$E5,$E4,$E3,$E2,$E1
    db $E0,$DF,$DD,$DC,$DB,$DA,$D9,$D8,$D7,$D6,$D5,$D4,$D3,$D2,$D1,$D0,$CF,$CE,$CD,$CC,$CB,$CA,$C9,$C8,$C7,$C6,$C5,$C4,$C3,$C2
    db $C1,$C0,$BF,$BE,$BD,$BC,$BB,$BA,$B9,$B9,$B8,$B7,$B6,$B5,$B4,$B3,$B2,$B1,$B1,$B0,$AF,$AE,$AD,$AC,$AC,$AB,$AA,$A9,$A8,$A7
    db $A7,$A6,$A5,$A4,$A4,$A3,$A2,$A1,$A1,$A0,$9F,$9F,$9E,$9D,$9C,$9C,$9B,$9A,$9A,$99,$98,$98,$97,$97,$96,$95,$95,$94,$94,$93
    db $93,$92,$91,$91,$90,$90,$8F,$8F,$8E,$8E,$8D,$8D,$8C,$8C,$8C,$8B,$8B,$8A,$8A,$8A,$89,$89,$88,$88,$88,$87,$87,$87,$86,$86
    db $86,$86,$85,$85,$85,$85,$84,$84,$84,$84,$83,$83,$83,$83,$83,$83,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
    db $81,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$82,$83,$83,$83,$83,$83,$83,$84,$84,$84,$84,$85,$85,$85,$85,$86
    db $86,$86,$86,$87,$87,$87,$88,$88,$88,$89,$89,$8A,$8A,$8A,$8B,$8B,$8C,$8C,$8C,$8D,$8D,$8E,$8E,$8F,$8F,$90,$90,$91,$91,$92
    db $93,$93,$94,$94,$95,$95,$96,$97,$97,$98,$98,$99,$9A,$9A,$9B,$9C,$9C,$9D,$9E,$9F,$9F,$A0,$A1,$A1,$A2,$A3,$A4,$A4,$A5,$A6
    db $A7,$A7,$A8,$A9,$AA,$AB,$AC,$AC,$AD,$AE,$AF,$B0,$B1,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$C0
    db $C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DF
    db $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EC,$ED,$EE,$EF,$F0,$F1,$F2,$F3,$F4,$F5,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF
    db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F
    db $20,$21,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E
    db $3F,$40,$41,$42,$43,$44,$45,$46,$47,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$4F,$50,$51,$52,$53,$54,$54,$55,$56,$57,$58,$59
    db $59,$5A,$5B,$5C,$5C,$5D,$5E,$5F,$5F,$60,$61,$61,$62,$63,$64,$64,$65,$66,$66,$67,$68,$68,$69,$69,$6A,$6B,$6B,$6C,$6C,$6D
    db $6D,$6E,$6F,$6F,$70,$70,$71,$71,$72,$72,$73,$73,$74,$74,$74,$75,$75,$76,$76,$76,$77,$77,$78,$78,$78,$79,$79,$79,$7A,$7A
    db $7A,$7A,$7B,$7B,$7B,$7B,$7C,$7C,$7C,$7C,$7D,$7D,$7D,$7D,$7D,$7D,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E