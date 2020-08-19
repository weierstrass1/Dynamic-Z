CGRAMDMA:
    LDA.l DZ.PPUMirrors.CGRAMTransferLength
    BPL +
RTS
+
    PHA
    ASL
    TAX

    REP #$20
	LDA #$2202              
	STA $00             ;parameter of DMA
-
    LDA.w #$0000
    STA $05

    LDA.l DZ.PPUMirrors.CGRAMTransferSourceBNKLength,x
    STA $04
    
    LDA.l DZ.PPUMirrors.CGRAMTransferSource,x
    STA $02                 ;Load Resource
    SEP #$20

    PLX

    LDA.l DZ.PPUMirrors.CGRAMTransferOffset,x
    STA $2121

    STY $420B

    TXA
    DEC A
    BMI +

    PHA
    ASL
    TAX
    BRA -
+
    LDA #$FF
    STA.l DZ.PPUMirrors.CGRAMTransferLength
RTS