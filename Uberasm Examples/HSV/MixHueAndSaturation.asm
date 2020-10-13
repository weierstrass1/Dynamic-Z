!ColorOffset = $00D1
!PaletteSize = $000F

!SetPalette = $58
!Ratio = $5C
!NewValueH = $60
!NewValueS = $61

MixHueAndSaturation:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1E
	STA !NewValueH
	LDA #$1E
	STA !NewValueS
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
	%MixPaletteHueAndSaturationWithOffset(!NewValueH, !NewValueS, !Ratio, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValueH
	DEC !NewValueH
	BPL +
	LDA #$1E
	STA !NewValueH

	DEC !NewValueS
	DEC !NewValueS
	BPL +
	LDA #$1E
	STA !NewValueS

	DEC !Ratio
	DEC !Ratio
	BPL +
	LDA #$08
	STA !Ratio
+
	RTL
