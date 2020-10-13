!ColorOffset = $0001
!PaletteSize = $002F

!SetPalette = $58
!Ratio = $5C
!NewValueH = $60
!NewValueS = $61
!NewValueV = $62

MixHueSaturationAndValue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1C
	STA !NewValueH
	LDA #$1C
	STA !NewValueS
	LDA #$1C
	STA !NewValueV
	LDA #$08
	STA !Ratio
	RTL

.main
	LDA !SetPalette
	BNE +
	INC !SetPalette
	%SetBaseAsHSVWithOffset(!PaletteSize*2, !ColorOffset)
+
	LDA !LockAnimationFlag
	BEQ +
	RTL
+
	%MixPaletteHueSaturationAndValueWithOffset(!NewValueH, !NewValueS, !NewValueV, !Ratio, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValueH
	DEC !NewValueH
	DEC !NewValueH
	DEC !NewValueH
	BPL +
	LDA #$1C
	STA !NewValueH

	DEC !NewValueS
	DEC !NewValueS
	DEC !NewValueS
	DEC !NewValueS
	BPL +
	LDA #$1C
	STA !NewValueS

	DEC !NewValueV
	DEC !NewValueV
	DEC !NewValueV
	DEC !NewValueV
	BPL +
	LDA #$1C
	STA !NewValueV

	DEC !Ratio
	DEC !Ratio
	BPL +
	LDA #$08
	STA !Ratio
+
	RTL
