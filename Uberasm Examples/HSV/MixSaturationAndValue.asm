!ColorOffset = $0031
!PaletteSize = $002F

!SetPalette = $58
!Ratio = $5C
!NewValueS = $60
!NewValueV = $61

MixSaturationAndValue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1E
	STA !NewValueS
	LDA #$1E
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
	%MixPaletteSaturationAndValueWithOffset(!NewValueS, !NewValueV, !Ratio, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValueS
	DEC !NewValueS
	BPL +
	LDA #$1E
	STA !NewValueS

	DEC !NewValueV
	DEC !NewValueV
	BPL +
	LDA #$1E
	STA !NewValueV

	DEC !Ratio
	DEC !Ratio
	BPL +
	LDA #$08
	STA !Ratio
+
	RTL
