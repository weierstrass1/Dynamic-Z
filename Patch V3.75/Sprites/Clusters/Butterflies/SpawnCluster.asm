    
;Routine that spawns an extended sprite with initial speed at the position (+offset)
;of the calling sprite and returns the sprite index in Y
;For a list of extended sprites see here: http://www.smwiki.net/wiki/RAM_Address/$7E:170B

;Input:  A   = number
;        $00 = 
;        $04 = x offset  \
;        $05 = y offset  | you could also just ignore these and set them later
;
;Output: Y   = index to extended sprite (#$FF means no sprite spawned)
;        C   = Carry Set = spawn failed, Carry Clear = spawn successful.
    
    CLC
    ADC #!ClusterOffset
    PHA

    LDY #$13
-
    LDA !cluster_num,y
    BEQ +

    DEY
    BPL -
    PLA
    CLC
RTL
+
    PLA
    STA !cluster_num,y

    STZ $06
    LDA #$00
    XBA
    LDA $04

    REP #$20
    PHA

    LDA $05
    CLC
    ADC $02
    STA $02

    PLA
    CLC
    ADC $00
    STA $00
    SEP #$20

    LDA $00
    STA !cluster_x_low,y

    LDA $01
    STA $1E3E|!Base2,y

    LDA $02
    STA !cluster_y_low,y

    LDA $03
    STA $1E2A|!Base2,y

    LDA #$01
    STA $18B8|!Base2
    SEC
RTL