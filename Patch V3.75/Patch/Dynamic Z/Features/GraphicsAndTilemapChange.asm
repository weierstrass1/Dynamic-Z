VRAMDMA:
    LDA #$00
    XBA
    LDA.l DZ.PPUMirrors.VRAMTransferLength
    CMP #$FF
    BNE +
RTS
+
    LDX #$80                
	STX $2115

    REP #$30
    ASL
    TAX

	LDA #$1801              
	STA $00             ;parameter of DMA
-
    LDA.l DZ.PPUMirrors.VRAMTransferSourceBNK,x
    STA $04

    LDA.l DZ.PPUMirrors.VRAMTransferSourceLength,x
    STA $05                 ;Load Length

    LDA.l DZ.PPUMirrors.VRAMTransferOffset,x
    STA $2116               ;Loads VRAM destination

    LDA.l DZ.PPUMirrors.VRAMTransferSource,x
    STA $02                 ;Load Resource

    STY $420B               ;Start the DMA Transfer

    DEX
    DEX 
    BPL -

    SEP #$30
    LDA #$FF
    STA.l DZ.PPUMirrors.VRAMTransferLength
RTS
