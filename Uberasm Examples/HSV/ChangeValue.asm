!ColorOffset = $0081
!PaletteSize = $000F

!SetPalette = $58
!NewValue1 = $5C

ChangeValue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1F
	STA !NewValue1
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
	%ChangePaletteValueWithOffset(!NewValue1, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValue1
	BPL +
	LDA #$1F
	STA !NewValue1
+
	RTL
