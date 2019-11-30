incsrc "header.asm"
incsrc "Hijacks/BaseHijack.asm"



freecode

Routines:
    dl DynamicRoutine16x16
    dl DynamicRoutine32x16
    dl DynamicRoutine32x32
    dl DynamicRoutine48x48
    dl DynamicRoutine64x64
    dl Reserve16x16NormalSpriteOf30FPS
    dl Reserve16x16NormalSpriteOf60FPS
    dl Reserve32x16NormalSpriteOf30FPS
    dl Reserve32x16NormalSpriteOf60FPS
    dl Reserve32x32NormalSpriteOf30FPS
    dl Reserve32x32NormalSpriteOf60FPS
    dl Reserve48x48NormalSpriteOf30FPS
    dl Reserve48x48NormalSpriteOf60FPS
    dl Reserve64x64NormalSpriteOf30FPS
    dl Reserve64x64NormalSpriteOf60FPS
    dl Reserve16x16ClusterSpriteOf30FPS
    dl Reserve16x16ClusterSpriteOf60FPS
    dl Reserve32x16ClusterSpriteOf30FPS
    dl Reserve32x16ClusterSpriteOf60FPS
    dl Reserve32x32ClusterSpriteOf30FPS
    dl Reserve32x32ClusterSpriteOf60FPS
    dl Reserve48x48ClusterSpriteOf30FPS
    dl Reserve48x48ClusterSpriteOf60FPS
    dl Reserve64x64ClusterSpriteOf30FPS
    dl Reserve64x64ClusterSpriteOf60FPS
    dl SendSignal16x16Normal
    dl SendSignal32x16Normal
    dl SendSignal32x32Normal
    dl SendSignal48x48Normal
    dl SendSignal64x64Normal
    dl SendSignal16x16Cluster
    dl SendSignal32x16Cluster
    dl SendSignal32x32Cluster
    dl SendSignal48x48Cluster
    dl SendSignal64x64Cluster
    dl SendSignal16x16Extended
    dl SendSignal32x16Extended
    dl SendSignal32x32Extended
    dl SendSignal48x48Extended
    dl SendSignal64x64Extended
    dl SendSignal16x16OW
    dl SendSignal32x16OW
    dl SendSignal32x32OW
    dl SendSignal48x48OW
    dl SendSignal64x64OW

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
    STA !SlotSpriteType+$0C     ;Clear Dynamic Sprite Slots
    STA !SlotSpriteType+$0E
    STA !SlotSpriteType+$10
    STA !SlotSpriteType+$12
    STA !SlotSpriteType+$14
    STA !SlotSpriteType+$16
    STA !SlotSpriteType+$18     ;Clear Dynamic Sprite Slots
    STA !SlotSpriteType+$1A
    STA !SlotSpriteType+$1C
    STA !SlotSpriteType+$1E
    STA !SlotSpriteType+$20
    STA !SlotSpriteType+$22
    STA !SignalSP4SecondHalfBottomLeftQuarter       ;Clear Signals
    STA !SignalSP4SecondHalfBottomLeftQuarter+$02   ;Clear Signals
    STA !SignalSP4SecondHalfBottomLeftQuarter+$04   ;Clear Signals
    STA !SignalSP4SecondHalfBottomLeftQuarter+$06   ;Clear Signals
    STA !SignalSP4SecondHalfBottomLeftQuarter+$08   ;Clear Signals
    STA !SignalSP4SecondHalfBottomLeftQuarter+$0A   ;Clear Signals
    STA !SlotsUsedEven          ;Slot Used = 0
    SEP #$20

    LDA #$20
    STA !MaxSlots               ;By Default MaxSlots = 4
    LDA #$01
    STA !NumberOfBlocks         ;By Default You can use complete SP4
RTS

DynamicZUpdateVariables:
    LDA !DynamicTimer
    INC A
    STA !DynamicTimer           ;Update Dynamic Timer

    LDA !SignalSP4SecondHalfBottomLeftQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4SecondHalfBottomLeftQuarter

    LDA !SignalSP4SecondHalfBottomRightQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4SecondHalfBottomRightQuarter

    LDA !SignalSP4SecondHalfTopLeftQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4SecondHalfTopLeftQuarter

    LDA !SignalSP4SecondHalfTopRightQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4SecondHalfTopRightQuarter

    LDA !SignalSP4FirstHalfBottomLeftQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4FirstHalfBottomLeftQuarter

    LDA !SignalSP4FirstHalfBottomRightQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4FirstHalfBottomRightQuarter

    LDA !SignalSP4FirstHalfTopLeftQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4FirstHalfTopLeftQuarter

    LDA !SignalSP4FirstHalfTopRightQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP4FirstHalfTopRightQuarter

    LDA !SignalSP3SecondHalfBottomLeftQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP3SecondHalfBottomLeftQuarter

    LDA !SignalSP3SecondHalfBottomRightQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP3SecondHalfBottomRightQuarter

    LDA !SignalSP3SecondHalfTopLeftQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP3SecondHalfTopLeftQuarter

    LDA !SignalSP3SecondHalfTopRightQuarter
    TAX
    LDA SignalUpdateTable,x
    STA !SignalSP3SecondHalfTopRightQuarter

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