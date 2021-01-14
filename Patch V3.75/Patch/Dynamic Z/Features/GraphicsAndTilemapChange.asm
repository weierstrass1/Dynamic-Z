VRAMDMA:
    LDA #$00
    XBA
    LDA.l DZ_PPUMirrors_VRAM_Transfer_Length
    CMP #$FF
    BNE +
RTS
+
    LDX #$80                
	STX $2115

    REP #$30
    ASL
    TAX
    LDA #$0000
    STA $0045|!dp
	LDA #$1801              
	STA $00             ;parameter of DMA
-
    LDA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK,x
    STA $04

    LDA.l DZ_PPUMirrors_VRAM_Transfer_SourceLength,x
    STA $05                 ;Load Length
    BNE +
    WDM
+
    CLC
    ADC $0045|!dp
    STA $0045|!dp
    CMP #$0C00
    BCC +

    WDM
+

    LDA.l DZ_PPUMirrors_VRAM_Transfer_Offset,x
    STA $2116               ;Loads VRAM destination

    LDA.l DZ_PPUMirrors_VRAM_Transfer_Source,x
    STA $02                 ;Load Resource

    STY $420B               ;Start the DMA Transfer

    DEX
    DEX 
    BPL -

    SEP #$30
    LDA #$FF
    STA.l DZ_PPUMirrors_VRAM_Transfer_Length
RTS
