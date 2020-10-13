!ColorOffset = $0001
!PaletteSize = $001F

!SetPalette = $58
!Ratio = $5C
!NewValue = $60

MixHue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1F
	STA !NewValue
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
	%MixPaletteHueWithOffset(!NewValue, !Ratio, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValue
	BPL +
	LDA #$1F
	STA !NewValue

	DEC !Ratio
	BPL +
	LDA #$08
	STA !Ratio
+
	RTL
