;@tailsplayer.bin,tailsplayerPal.bin
!ResourceIndex = $00
%GFXTabDef(!ResourceIndex)
%GFXDef(00)
%GFXDef(01)

init:
	LDA #!GFX00>>16
	STA DZ_Player_GFX_BNK
	LDA #$00
	STA DZ_Player_GFX_BNK+1
	LDA #!GFX01>>16
	STA DZ_Player_Palette_BNK

	REP #$20
	LDA #!GFX00
	STA DZ_Player_GFX_Addr
	LDA #$FFFF
    STA $0D85|!addr
    STA $0D87|!addr
    STA $0D89|!addr
    STA $0D8B|!addr
    STA $0D8D|!addr
    STA $0D8F|!addr
    STA $0D91|!addr
    STA $0D93|!addr
    STA $0D95|!addr
    STA $0D97|!addr
    STA $0D99|!addr

	LDA #!GFX01
	CLC
	ADC #$000A
	STA DZ_Player_Palette_Addr
	SEP #$20
	rtl

main:
	rtl











