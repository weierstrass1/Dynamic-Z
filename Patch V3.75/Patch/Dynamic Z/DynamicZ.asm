;dont touch this
	!dp = $0000
	!addr = $0000
    !rom = $800000
	!sa1 = 0
    !Variables = $7F0B44 
    !MaxSprites = $0C
    !SpriteStatus = $14C8
    !SpriteNumberNormal = $7FAB9E
    !SpriteLoadStatus = $161A
    !SpriteLoadTable = $7FAF00
    !ExtraByte1 = $7FAB40


if read1($00FFD5) == $23
sa1rom
	!dp = $3000
	!addr = $6000
	!sa1 = 1
    !rom = $000000
    !Variables = $418000  
    !MaxSprites = $16
    !SpriteStatus = $3242
    !SpriteNumberNormal = $400083
    !SpriteLoadStatus = $7578
    !SpriteLoadTable = $418A00
    !ExtraByte1 = $400099
endif

    !Scratch0 = $00
    !Scratch1 = $01
    !Scratch2 = $02
    !Scratch3 = $03
    !Scratch4 = $04
    !Scratch5 = $05
    !Scratch6 = $06
    !Scratch7 = $07
    !Scratch8 = $08
    !Scratch9 = $09
    !ScratchA = $0A
    !ScratchB = $0B
    !ScratchC = $0C
    !ScratchD = $0D
    !ScratchE = $0E
    !ScratchF = $0F
    !Scratch45 = $45
    !Scratch46 = $46
    !Scratch47 = $47
    !Scratch48 = $48
    !Scratch49 = $49
    !Scratch4A = $4A
    !Scratch4B = $4B
    !Scratch4C = $4C
    !Scratch4D = $4D
    !Scratch4E = $4E
    !Scratch4F = $4F
    !Scratch50 = $50
    !Scratch51 = $51
    !Scratch52 = $52
    !Scratch53 = $53

    !ClusterSpriteNumber = $1892|!addr
    !ExtendedSpriteNumber = $170B|!addr
    !OWSpriteNumber = $0DE5|!addr

incsrc "Hijacks/BaseHijack.asm"
incsrc "Options.asm"
incsrc "Hijacks/MarioGFXDMAOptimizationHijack.asm"
incsrc "header.asm"

freecode

Routines:
    dl ClearSlot|!rom
    dl CheckSlot|!rom
    dl FindSpace|!rom
    dl DynamicRoutine|!rom
if read2($00823D+4) == $8449
    dl $000000
    print "A"
else
    print "B"
    !__main_clean = read3((read1($0082DA+4)<<16+read2($00823D+4))+$0C)
    print hex(!__main_clean)
    if read3(!__main_clean-3) != $FFFFFF
        dl $000000
    else
        dl !__main_clean
    endif
endif
    dl CheckEvenOrOdd|!rom
    dl GetVramDisp|!rom
    dl GetVramDispDynamicRoutine|!rom
    dl RemapOamTile|!rom
    dl CheckNormalSharedDynamicExisted|!rom
    dl CheckClusterSharedDynamicExisted|!rom
    dl CheckExtendedSharedDynamicExisted|!rom
    dl CheckOWSharedDynamicExisted|!rom
    dl CheckIfLastNormalSharedProcessed|!rom
    dl CheckIfLastClusterSharedProcessed|!rom
    dl CheckIfLastExtendedSharedProcessed|!rom
    dl CheckIfLastOWSharedProcessed|!rom

print hex(Routines)

GameModeTable:
    db $00,$00,$00,$00,$00,$00,$01,$01
    ;  g00,g01,g02,g03,g04,g05,g06,g07
    db $01,$01,$01,$00,$00,$02,$02,$00
    ;  g08,g09,g0A,g0B,g0C,g0D,g0E,g0F
    db $00,$00,$01,$01,$01,$00,$00,$00
    ;  g10,g11,g12,g13,g14,g15,g16,g17
    db $00,$00,$00,$00,$00,$00,$00,$00
    ;  g18,g19,g1A,g1B,g1C,g1D,g1E,g1F
    db $00,$00,$00,$00,$00,$00,$00,$00
    ;  g20,g21,g22,g23,g24,g25,g26,g27
    db $00,$00,$00,$00,$00,$00,$00,$00
    ;  g28,g29,g2A,g2B,g2C,g2D,g2E,g2F
DynamicZ:

    LDX $0100|!addr

    ;Find on the table if the current level mode activate Dynamic Z
    LDA.l GameModeTable,x
    BNE +

    ;If Dynamic Z is inactive, reset its importants variables
    JSR DynamicZStart
RTL
+
    PHD

	REP #$30
	LDY #$0001            ;Used to activate DMA Transfer

	LDA #$4300
	TCD                 ;direct page = 4300 for speed

    SEP #$30

    LDA.l DZ.PPUMirrors.Reg420B
    BEQ +
    STY $420B
    LDA #$00
    STA.l DZ.PPUMirrors.Reg420B
+
    JSR VRAMDMA
    JSR CGRAMDMA

    LDA DZ.Timer
    INC A
    STA DZ.Timer

    PLD
RTL

DynamicZStart:

if !PlayerFeatures == !True
    REP #$20
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
    SEP #$20
endif

    PHB
    LDA.b #!Variables>>16
    PHA
    PLB

    REP #$20
    LDA.w #!DefaultLevelDSVRAMOFfset
    STA.w DZ.DSStartingVRAMOffset

    LDA.w #!DefaultLevelMaxDataTransferPerFrame
    STA.w DZ.MaxDataPerFrame

    LDA #$0000
    STA.w DZ.DSTotalSpaceUsed
    STA.w DZ.DSTotalSpaceUsedOdd
    STA.w DZ.DSTotalDataSentOdd
    STA.w DZ.PPUMirrors.CGRAMLastPlayerPal

    LDA #$FFFF
    STA.w DZ.DSLocUsedBy
    STA.w DZ.DSLocUsedBy+$02
    STA.w DZ.DSLocUsedBy+$04
    STA.w DZ.DSLocUsedBy+$06
    STA.w DZ.DSLocUsedBy+$08
    STA.w DZ.DSLocUsedBy+$0A
    STA.w DZ.DSLocUsedBy+$0C
    STA.w DZ.DSLocUsedBy+$0E
    STA.w DZ.DSLocUsedBy+$10
    STA.w DZ.DSLocUsedBy+$12
    STA.w DZ.DSLocUsedBy+$14
    STA.w DZ.DSLocUsedBy+$16
    STA.w DZ.DSLocUsedBy+$18
    STA.w DZ.DSLocUsedBy+$1A
    STA.w DZ.DSLocUsedBy+$1C
    STA.w DZ.DSLocUsedBy+$1E
    STA.w DZ.DSLocUsedBy+$20
    STA.w DZ.DSLocUsedBy+$22
    STA.w DZ.DSLocUsedBy+$24
    STA.w DZ.DSLocUsedBy+$26
    STA.w DZ.DSLocUsedBy+$28
    STA.w DZ.DSLocUsedBy+$2A
    STA.w DZ.DSLocUsedBy+$2C
    STA.w DZ.DSLocUsedBy+$2E

    STA.w DZ.DSLocNextSlot
    STA.w DZ.DSLocNextSlot+$02
    STA.w DZ.DSLocNextSlot+$04
    STA.w DZ.DSLocNextSlot+$06
    STA.w DZ.DSLocNextSlot+$08
    STA.w DZ.DSLocNextSlot+$0A
    STA.w DZ.DSLocNextSlot+$0C
    STA.w DZ.DSLocNextSlot+$0E
    STA.w DZ.DSLocNextSlot+$10
    STA.w DZ.DSLocNextSlot+$12
    STA.w DZ.DSLocNextSlot+$14
    STA.w DZ.DSLocNextSlot+$16
    STA.w DZ.DSLocNextSlot+$18
    STA.w DZ.DSLocNextSlot+$1A
    STA.w DZ.DSLocNextSlot+$1C
    STA.w DZ.DSLocNextSlot+$1E
    STA.w DZ.DSLocNextSlot+$20
    STA.w DZ.DSLocNextSlot+$22
    STA.w DZ.DSLocNextSlot+$24
    STA.w DZ.DSLocNextSlot+$26
    STA.w DZ.DSLocNextSlot+$28
    STA.w DZ.DSLocNextSlot+$2A
    STA.w DZ.DSLocNextSlot+$2C
    STA.w DZ.DSLocNextSlot+$2E
    STA.w DZ.DSLocPreviewSlot
    STA.w DZ.DSLocPreviewSlot+$02
    STA.w DZ.DSLocPreviewSlot+$04
    STA.w DZ.DSLocPreviewSlot+$06
    STA.w DZ.DSLocPreviewSlot+$08
    STA.w DZ.DSLocPreviewSlot+$0A
    STA.w DZ.DSLocPreviewSlot+$0C
    STA.w DZ.DSLocPreviewSlot+$0E
    STA.w DZ.DSLocPreviewSlot+$10
    STA.w DZ.DSLocPreviewSlot+$12
    STA.w DZ.DSLocPreviewSlot+$14
    STA.w DZ.DSLocPreviewSlot+$16
    STA.w DZ.DSLocPreviewSlot+$18
    STA.w DZ.DSLocPreviewSlot+$1A
    STA.w DZ.DSLocPreviewSlot+$1C
    STA.w DZ.DSLocPreviewSlot+$1E
    STA.w DZ.DSLocPreviewSlot+$20
    STA.w DZ.DSLocPreviewSlot+$22
    STA.w DZ.DSLocPreviewSlot+$24
    STA.w DZ.DSLocPreviewSlot+$26
    STA.w DZ.DSLocPreviewSlot+$28
    STA.w DZ.DSLocPreviewSlot+$2A
    STA.w DZ.DSLocPreviewSlot+$2C
    STA.w DZ.DSLocPreviewSlot+$2E

    STA.w DZ.DSLastSlot
    SEP #$20

    STA.w DZ.PPUMirrors.VRAMTransferLength
    STA.w DZ.PPUMirrors.CGRAMTransferLength
    STA.w DZ.DSCurrentSlotSearcher

    LDA.b #!DefaultLevelDSMaxSpaceIn16x16Tiles
    STA.w DZ.DSMaxSpace

    LDA.b #!DefaultLevelMaxDataTransferPerFrameIn16x16Tiles
    STA.w DZ.MaxDataPerFrameIn16x16Tiles

    LDA.b #!DefaultLevelFindMethod
    STA.w DZ.DSFindSpaceMethod

    LDA.b #!DefaultLevelDSVRAMOffsetIn8x8Tiles
    STA.w DZ.DSStartingVRAMOffset8x8Tiles

    LDA.b #$00
    STA.w DZ.PPUMirrors.Reg420B
    STA.w DZ.DSLength

    PLB
RTS

DZBaseHijack1:
    JSL DynamicZ
	PHK
	PEA.w .jslrtsreturn-1
	PEA.w $0084CE|!rom ; varies per bank, must point to RTL-1 in the same bank as the JML target (example: $0084CF-1)
	JML $0085D2|!rom
.jslrtsreturn
	PHK
	PEA.w .jslrtsreturn2-1
	PEA.w $0084CE|!rom ; varies per bank, must point to RTL-1 in the same bank as the JML target (example: $0084CF-1)
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
incsrc "Features/GraphicsAndTilemapChange.asm"
incsrc "Features/ColorPaletteChange.asm"
if !PlayerFeatures == !True
incsrc "Features/MarioGFXDMAOptimization.asm"
endif

print hex(DZ.Timer)