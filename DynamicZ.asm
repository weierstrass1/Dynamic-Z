incsrc "header.asm"
incsrc "Hijacks/BaseHijack.asm"



freecode

Routines:
    dl Reserve32x32NormalSpriteOf30FPS

GameModeTable:
    db $00,$00,$00,$00,$00,$00,$01,$01
    ;  g00,g01,g02,g03,g04,g05,g06,g07
    db $01,$01,$01,$00,$00,$02,$02,$00
    ;  g08,g09,g0A,g0B,g0C,g0D,g0E,g0F
    db $00,$00,$00,$01,$01,$00,$00,$00
    ;  g10,g11,g12,g13,g14,g15,g16,g17
    db $00,$00,$00,$00,$00,$00,$00,$00
    ;  g18,g19,g1A,g1B,g1C,g1D,g1E,g1F
    db $00,$00,$00,$00,$00,$00,$00,$00
    ;  g20,g21,g22,g23,g24,g25,g26,g27
    db $00,$00,$00,$00,$00,$00,$00,$00
    ;  g28,g29,g2A,g2B,g2C,g2D,g2E,g2F
DynamicZ:

    PHB
	PHK
	PLB
	
	PHP
	PHD

	REP #$20

	LDA #$4300
	TCD                 ;direct page = 4300 for speed
	LDA #$1801              
	STA $00             ;parameter of DMA
	
	LDY #$01            ;Used to activate DMA Transfer
	LDX #$80                
	STX $2115

    SEP #$20
    LDX $0100|!addr

    ;Find on the table if the current level mode activate Dynamic Z
    LDA GameModeTable,x
    BNE +

    ;If Dynamic Z is inactive, reset its importants variables
    JSR DynamicZStart
    PLD
    PLP
    PLB
RTL
+

    JSR DynamicSpriteSupport

    JSR DynamicZUpdateVariables

    PLD
    PLP
    PLB
RTL

DynamicZStart:

    REP #$20
    LDA #$FFFF
    STA !DMAMapNext+$00         ;All this clear Next Table
    STA !DMAMapNext+$02
    STA !DMAMapNext+$04
    STA !DMAMapNext+$06
    STA !DMAMapNext+$08
    STA !DMAMapNext+$0A
    STA !DMAMapNext+$0C
    STA !DMAMapNext+$0E
    STA !DMAMapNext+$10
    STA !DMAMapNext+$12
    STA !DMAMapNext+$14
    STA !DMAMapNext+$16
    STA !DMAMapNext+$18
    STA !DMAMapNext+$1A
    STA !DMAMapNext+$1C
    STA !DMAMapNext+$1E
    STA !DMAMapNext+$20
    STA !DMAMapNext+$22
    STA !DMAMapNext+$24
    STA !DMAMapNext+$26
    STA !DMAMapNext+$28
    STA !DMAMapNext+$2A
    STA !DMAMapNext+$2C
    STA !DMAMapNext+$2E
    STA !DMAMapNext+$30
    STA !DMAMapNext+$32
    STA !DMAMapNext+$34
    STA !DMAMapNext+$36
    STA !DMAMapNext+$38
    STA !DMAMapNext+$3A
    STA !DMAMapNext+$3C
    STA !DMAMapNext+$3E
    STA !DMAMapNext+$40
    STA !DMAMapNext+$42
    STA !DMAMapNext+$44
    STA !DMAMapNext+$46
    STA !DMAMapNext+$48
    STA !DMAMapNext+$4A
    STA !DMAMapNext+$4C
    STA !DMAMapNext+$4E
    STA !DMAMapNext+$50
    STA !DMAMapNext+$52
    STA !DMAMapNext+$54
    STA !DMAMapNext+$56
    STA !DMAMapNext+$58
    STA !DMAMapNext+$5A
    STA !DMAMapNext+$5C
    STA !DMAMapNext+$5E
    STA !FirstSlot              ;Clear First and Last Slot
    LDA #$0000
    STA !SlotSpriteType+$00     ;Clear Dynamic Sprite Slots
    STA !SlotSpriteType+$02
    STA !SlotSpriteType+$04
    STA !SlotSpriteType+$06
    STA !SlotSpriteType+$08
    STA !SlotSpriteType+$0A
    STA !SignalsSP4SecondHalf   ;Clear Signals
    STA !SlotsUsedEven          ;Slot Used = 0
    SEP #$20

    STA !SignalsSP3SecondHalf
    LDA #$04
    STA !MaxSlots               ;By Default MaxSlots = 4
    LDA #$01
    STA !NumberOfBlocks         ;By Default You can use complete SP4
RTS

DynamicZUpdateVariables:
    LDA !DynamicTimer
    INC A
    STA !DynamicTimer           ;Update Dynamic Timer

    LDA !SignalsSP4SecondHalf
    TAX
    LDA SignalUpdateTable,x
    STA !SignalsSP4SecondHalf   ;Update Signals of SP4 Second Half

    LDA !SignalsSP4FirstHalf
    TAX
    LDA SignalUpdateTable,x
    STA !SignalsSP4FirstHalf    ;Update Signals of SP4 First Half

    LDA !SignalsSP3SecondHalf
    TAX
    LDA SignalUpdateTable,x
    STA !SignalsSP3SecondHalf   ;Update Signals of SP3 Second Half

RTS

SignalUpdateTable:
    db $00,$00,$01,$02,$00,$00,$01,$02,$04,$04,$05,$06,$08,$08,$09,$0A
    db $00,$00,$01,$02,$00,$00,$01,$02,$04,$04,$05,$06,$08,$08,$09,$0A
    db $10,$10,$11,$12,$10,$10,$11,$12,$14,$14,$15,$16,$18,$18,$19,$1A
    db $20,$20,$21,$22,$20,$20,$21,$22,$24,$24,$25,$26,$28,$28,$29,$2A
    db $00,$00,$01,$02,$00,$00,$01,$02,$04,$04,$05,$06,$08,$08,$09,$0A
    db $00,$00,$01,$02,$00,$00,$01,$02,$04,$04,$05,$06,$08,$08,$09,$0A
    db $10,$10,$11,$12,$10,$10,$11,$12,$14,$14,$15,$16,$18,$18,$19,$1A
    db $20,$20,$21,$22,$20,$20,$21,$22,$24,$24,$25,$26,$28,$28,$29,$2A
    db $40,$40,$41,$42,$40,$40,$41,$42,$44,$44,$45,$46,$48,$48,$49,$4A
    db $40,$40,$41,$42,$40,$40,$41,$42,$44,$44,$45,$46,$48,$48,$49,$4A
    db $50,$50,$51,$52,$50,$50,$51,$52,$54,$54,$55,$56,$58,$58,$59,$5A
    db $60,$60,$61,$62,$60,$60,$61,$62,$64,$64,$65,$66,$68,$68,$69,$6A
    db $80,$80,$81,$82,$80,$80,$81,$82,$84,$84,$85,$86,$88,$88,$89,$8A
    db $80,$80,$81,$82,$80,$80,$81,$82,$84,$84,$85,$86,$88,$88,$89,$8A
    db $90,$90,$91,$92,$90,$90,$91,$92,$94,$94,$95,$96,$98,$98,$99,$9A
    db $A0,$A0,$A1,$A2,$A0,$A0,$A1,$A2,$A4,$A4,$A5,$A6,$A8,$A8,$A9,$AA


DZBaseHijack1:
	JSL DynamicZ
	PHK
	PEA.w .jslrtsreturn-1
	PEA.w $0084CF-1 ; varies per bank, must point to RTL-1 in the same bank as the JML target (example: $0084CF-1)
	JML $0085D2|!rom
.jslrtsreturn
	PHK
	PEA.w .jslrtsreturn2-1
	PEA.w $0084CF-1 ; varies per bank, must point to RTL-1 in the same bank as the JML target (example: $0084CF-1)
	JML $008449|!rom
.jslrtsreturn2
	JML $008243|!rom

DZBaseHijack2:
	JSL DynamicZ
	BIT.w $0D9B|!addr
	BVS +
	JML $0082E8|!rom
+	
	JML $0082DF|!rom

incsrc "Library/Routines.asm"
incsrc "Dynamic Sprites Support/DynamicSpritesSupport.asm"