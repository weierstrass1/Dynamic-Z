!ColorOffset = $0031
!PaletteSize = $002F

!SetPalette = $58
!Ratio = $5C
!NewValueH = $60
!NewValueV = $61

MixHueAndValue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1E
	STA !NewValueH
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
	%MixPaletteHueAndValueWithOffset(!NewValueH, !NewValueV, !Ratio, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValueH
	DEC !NewValueH
	BPL +
	LDA #$1E
	STA !NewValueH

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
