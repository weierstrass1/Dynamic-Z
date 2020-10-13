!ColorOffset = $0021
!PaletteSize = $000F

!SetPalette = $58
!NewValueS = $5C
!NewValueV = $60

ChangeSaturationAndValue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1F
	STA !NewValueS
	LDA #$1F
	STA !NewValueV
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
	%ChangePaletteSaturationAndValueWithOffset(!NewValueS, !NewValueV, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValueS
	BPL +
	LDA #$1F
	STA !NewValueS

	DEC !NewValueV
	BPL +
	LDA #$1F
	STA !NewValueV
+
	RTL
