!ColorOffset = $0021
!PaletteSize = $000F

!SetPalette = $58
!NewValueH = $5C
!NewValueV = $60

ChangeHueAndValue:
.init
	%TransferToCGRAMBuffer(!ColorOffset, #!PaletteSize*2)
	STZ !SetPalette
	LDA #$1F
	STA !NewValueH
	LDA #$1F
	STA !NewValueV
	rtl

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
	%ChangePaletteHueAndValueWithOffset(!NewValueH, !NewValueV, !PaletteSize*2, !ColorOffset)
	%TransferToCGRAM(#!ColorOffset, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror+(!ColorOffset*2), #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #!PaletteSize*2)

	DEC !NewValueH
	BPL +
	LDA #$1F
	STA !NewValueH

	DEC !NewValueV
	BPL +
	LDA #$1F
	STA !NewValueV
+
	rtl
