;Constant
!MaxResistTime = $20	
!ResistXSpeed = $20
!RecoilXSpeed = $20
!RecoilYSpeed = $C0
!WalkSpeed = $18
	
	!dp = $0000
	!addr = $0000
    !rom = $800000
	!sa1 = 0
	!gsu = 0
    !sram7000 = $000000
    !sram7008 = $000000
    !ram7F9A7B = $000000
    !ram7FC700 = $000000
	!PaletteFreeRAM = $7F0B44 
	!DSXFreeRAM = $7F0B44
	!MaxSprites = $0C

if read1($00FFD6) == $15
	sfxrom
	!dp = $6000
	!addr = !dp
	!gsu = 1
elseif read1($00FFD5) == $23
	sa1rom
	!dp = $3000
	!addr = $6000
	!sa1 = 1
    !rom = $000000
    !sram7000 = $2E4000
    !sram7008 = $2E6800
    !ram7F9A7B = $3E127B
    !ram7FC700 = $3DFF00
	!PaletteFreeRAM = $418000  
	!DSXFreeRAM = $418000
	!MaxSprites = $16
endif

;########################################
;######## Scratchs Rams [$00,$0F] #######
;########################################
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

;########################################
;############## Counters ################
;########################################
!TrueFrameCounter = $13
!EffectiveFrameCounter = $14

;########################################
;############## Control #################
;########################################
!ButtonPressed_BYETUDLR = $15
!ButtonDown_BYETUDLR = $16
!ButtonPressed_AXLR0000 = $17
!ButtonDown_AXLR0000 = $18

;########################################
;############## Layers ##################
;########################################
!Layer1X = $1A
!Layer1Y = $1C
!Layer2X = $1E
!Layer2Y = $20
!Layer3X = $22
!Layer3Y = $24

;########################################
;############## Player ##################
;########################################
!PlayerX = $94
!PlayerY = $96
!PlayerXSpeed = $7B
!PlayerYSpeed = $7D
!PowerUp = $19
!Lives = $0DBE|!addr
!Coins = $0DBF|!addr
!ItemBox = $0DC2|!addr
!PlayerInAirFlag = $72
!PlayerDuckingFlag = $73
!PlayerClimbingFlag_N00SIFHB = $74
!PlayerWaterFlag = $75
!PlayerDirection = $76
!PlayerBlockedStatus_S00MUDLR = $77
!PlayerHide_DLUCAPLU = $78
!CurrentPlayer = $0DB3|!addr
!CapeImage = $13DF|!addr
!PlayerPose = $13E0|!addr
!PlayerSlope = $13E1|!addr
!SpinjumpTimer = $13E2|!addr
!PlayerWallRunningFlag = $13E3|!addr
!PlayerFrozenFlag = $13FB|!addr
!PlayerCarryingFlag = $1470|!addr
!PlayerCarryingFlagImage = $148F|!addr
!PlayerAnimationTimer = $1496|!addr
!PlayerFlashingTimer = $1497|!addr
!P1PowerUp = $0DB8|!addr
!P2PowerUp = $0DB9|!addr
!P1Lives = $0DB4|!addr
!P2Lives = $0DB5|!addr
!P1Coins = $0DB6|!addr
!P2Coins = $0DB7|!addr
!P1YoshiColor = $0DBA|!addr
!P2YoshiColor = $0DBB|!addr
!P1ItemBox = $0DBC|!addr
!P2ItemBox = $0DBD|!addr

;########################################
;############### Global #################
;########################################
!LockAnimationFlag = $9D
!HScrollEnable = $1411|!addr
!VScrollEnable = $1412|!addr
!HScrollLayer2Type = $1413|!addr
!VScrollLayer2Type = $1414|!addr
!WaterFlag = $85
!SlipperyFlag = $86
!GameMode = $0100|!addr
!TwoPlayersFlag = $0DB2|!addr

;########################################
;################ OAM ###################
;########################################
!TileXPosition200 = $0200|!addr
!TileYPosition200 = $0201|!addr
!TileCode200 = $0202|!addr
!TileProperty200 = $0203|!addr
!TileSize420 = $0420|!addr
!TileXPosition = $0300|!addr
!TileYPosition = $0301|!addr
!TileCode = $0302|!addr
!TileProperty = $0303|!addr
!TileSize460 = $0460|!addr

;########################################
;############### Yoshi ##################
;########################################
!YoshiX = $18B0|!addr
!YoshiY = $18B2|!addr
!YoshiKeyInMouthFlag = $191C|!addr

;########################################
;############## Clusters ################
;########################################
!ClusterNumber = $1892|!addr
!ClusterXLow = $1E16|!addr
!ClusterYLow = $1E02|!addr
!ClusterXHigh = $1E3E|!addr
!ClusterYHigh = $1E2A|!addr
!ClusterMiscTable1 = $0F4A|!addr
!ClusterMiscTable2 = $0F5E|!addr
!ClusterMiscTable3 = $0F72|!addr
!ClusterMiscTable4 = $0F86|!addr
!ClusterMiscTable5 = $0F9A|!addr
!ClusterMiscTable6 = $1E52|!addr
!ClusterMiscTable7 = $1E66|!addr
!ClusterMiscTable8 = $1E7A|!addr
!ClusterMiscTable9 = $1E8E|!addr

;########################################
;############## Extended ################
;########################################
!ExtendedNumber = $170B|!addr
!ExtendedXLow = $171F|!addr
!ExtendedYLow = $1715|!addr
!ExtendedXHigh = $1733|!addr
!ExtendedYHigh = $1729|!addr
!ExtendedXSpeed = $1747|!addr
!ExtendedYSpeed = $173D|!addr
!ExtendedXSpeedAccumulatingFraction = $175B|!addr
!ExtendedYSpeedAccumulatingFraction = $1751|!addr
!ExtendedBehindLayersFlag = $1779|!addr
!ExtendedMiscTable1 = $1765|!addr
!ExtendedMiscTable2 = $176F|!addr

;########################################
;############### Sprites ################
;########################################
!SpriteIndex = $15E9|!addr
!SpriteNumber = $9E
!SpriteStatus = $14C8
!SpriteXLow = $E4
!SpriteYLow = $D8
!SpriteXHigh = $14E0
!SpriteYHigh = $14D4
!SpriteXSpeed = $B6
!SpriteYSpeed = $AA
!SpriteXSpeedAccumulatingFraction = $14F8
!SpriteYSpeedAccumulatingFraction = $14EC
!SpriteDirection = $157C
!SpriteBlockedStatus_ASB0UDLR = $1588
!SpriteHOffScreenFlag = $15A0
!SpriteVOffScreenFlag = $186C
!SpriteHMoreThan4TilesOffScreenFlag = $15C4
!SpriteSlope = $15B8
!SpriteYoshiTongueFlag = $15D0
!SpriteInteractionWithObjectEnable = $15DC
!SpriteIndexOAM = $15EA
!SpriteProperties_YXPPCCCT = $15F6
!SpriteLoadStatus = $161A
!SpriteBehindEscenaryFlag = $1632
!SpriteInLiquidFlag = $164A
!SpriteDecTimer1 = $1540
!SpriteDecTimer2 = $154C
!SpriteDecTimer3 = $1558
!SpriteDecTimer4 = $1564
!SpriteDecTimer5 = $15AC
!SpriteDecTimer6 = $163E
!SpriteDecTimer7 = $1FE2
!SpriteTweaker1656_SSJJCCCC = $1656
!SpriteTweaker1662_DSCCCCCC = $1662
!SpriteTweaker166E_LWCFPPPG = $166E
!SpriteTweaker167A_DPMKSPIS = $167A
!SpriteTweaker1686_DNCTSWYE = $1686
!SpriteTweaker190F_WCDJ5SDP = $190F
!SpriteMiscTable1 = $0DF5|!addr
!SpriteMiscTable2 = $0E0B|!addr
!SpriteMiscTable3 = $C2
!SpriteMiscTable4 = $1504
!SpriteMiscTable5 = $1510
!SpriteMiscTable6 = $151C
!SpriteMiscTable7 = $1528
!SpriteMiscTable8 = $1534
!SpriteMiscTable9 = $1570
!SpriteMiscTable10 = $1594
!SpriteMiscTable11 = $1602
!SpriteMiscTable12 = $160E
!SpriteMiscTable13 = $1626
!SpriteMiscTable14 = $187B
!SpriteMiscTable15 = $1FD6

;########################################
;############### GIEPY ##################
;########################################
!ExtraBits = $7FAB10
!NewCodeFlag = $7FAB1C
!ExtraProp1 = $7FAB28
!ExtraProp2 = $7FAB34
!ExtraByte1 = $7FAB40
!ExtraByte2 = $7FAB4C
!ExtraByte3 = $7FAB58
!ExtraByte4 = $7FAB64
!ShooterExtraByte = $7FAB70
!GeneratorExtraByte = $7FAB78
!ScrollerExtraByte = $7FAB79
!CustomSpriteNumber = $7FAB9E
!ShooterExtraBits = $7FABAA
!GeneratorExtraBits = $7FABB2
!Layer1ExtraBits = $7FABB3
!Layer2ExtraBits = $7FABB4
!SpriteFlags = $7FABB5

if !sa1

!SpriteNumber = $3200
!SpriteYSpeed = $9E
!SpriteXSpeed = $B6
!SpriteMiscTable3 = $D8
!SpriteYLow = $3216
!SpriteXLow = $322C
!SpriteStatus = $3242
!SpriteYHigh = $3258
!SpriteXHigh = $326E
!SpriteYSpeedAccumulatingFraction = $74C8
!SpriteXSpeedAccumulatingFraction = $74DE
!SpriteMiscTable4 = $74F4
!SpriteMiscTable5 = $750A
!SpriteMiscTable6 = $3284
!SpriteMiscTable7 = $329A
!SpriteMiscTable8 = $32B0
!SpriteDecTimer1 = $32C6
!SpriteDecTimer2 = $32DC
!SpriteDecTimer3 = $32F2
!SpriteDecTimer4 = $3308
!SpriteMiscTable9 = $331E
!SpriteDirection = $3334
!SpriteBlockedStatus_ASB0UDLR = $334A
!SpriteMiscTable10 = $3360
!SpriteHOffScreenFlag = $3376
!SpriteDecTimer5 = $338C
!SpriteSlope = $7520
!SpriteHMoreThan4TilesOffScreenFlag = $7536
!SpriteYoshiTongueFlag = $754C
!SpriteInteractionWithObjectEnable = $7562
!SpriteIndexOAM = $33A2
!SpriteProperties_YXPPCCCT = $33B8
!SpriteMiscTable11 = $33CE
!SpriteMiscTable12 = $33E4
!SpriteLoadStatus = $7578
!SpriteMiscTable13 = $758E
!SpriteBehindEscenaryFlag = $75A4
!SpriteDecTimer6 = $33FA
!SpriteInLiquidFlag = $75BA
!SpriteTweaker1656_SSJJCCCC = $75D0
!SpriteTweaker1662_DSCCCCCC = $75EA
!SpriteTweaker166E_LWCFPPPG = $7600
!SpriteTweaker167A_DPMKSPIS = $7616
!SpriteTweaker1686_DNCTSWYE = $762C
!SpriteVOffScreenFlag = $7642
!SpriteMiscTable14 = $3410
!SpriteTweaker190F_WCDJ5SDP = $7658
!SpriteMiscTable15 = $766E
!SpriteDecTimer7 = $7FD6

!ExtraBits = $400040
!NewCodeFlag = $400056
!ExtraProp1 = $400057
!ExtraProp2 = $40006D
!ExtraByte1 = $4000A4
!ExtraByte2 = $4000BA
!ExtraByte3 = $4000D0
!ExtraByte4 = $4000E6
!ShooterExtraByte = $400110
!GeneratorExtraByte = $4000FC
!ScrollerExtraByte = $4000FD
!CustomSpriteNumber = $400083
!ShooterExtraBits = $400099
!GeneratorExtraBits = $4000A1
!Layer1ExtraBits = $4000A2
!Layer2ExtraBits = $4000A3
!SpriteFlags = $400118

endif 

!Variables = !PaletteFreeRAM+$180
;#################################################
;############# Dynamic Sprite Support ############
;#################################################

!DynamicTimer = !Variables
!SignalSP4SecondHalfBottomLeftQuarter = !Variables+$0001
!SignalSP4SecondHalfBottomRightQuarter = !Variables+$0002
!SignalSP4SecondHalfTopLeftQuarter = !Variables+$0003
!SignalSP4SecondHalfTopRightQuarter = !Variables+$0004
!SignalSP4FirstHalfBottomLeftQuarter = !Variables+$0005
!SignalSP4FirstHalfBottomRightQuarter = !Variables+$0006
!SignalSP4FirstHalfTopLeftQuarter = !Variables+$0007
!SignalSP4FirstHalfTopRightQuarter = !Variables+$0008
!SignalSP3SecondHalfBottomLeftQuarter = !Variables+$0009
!SignalSP3SecondHalfBottomRightQuarter = !Variables+$000A
!SignalSP3SecondHalfTopLeftQuarter = !Variables+$000B
!SignalSP3SecondHalfTopRightQuarter = !Variables+$000C
!SlotsUsedEven = !Variables+$000D
!SlotsUsedOdd = !Variables+$000E
!MaxSlots = !Variables+$000F
!NumberOfBlocks = !Variables+$0010
!VRAMDispNormalSprite = !Variables+$0011
!VRAMDispExtendedSprite = !Variables+!MaxSprites+$0011
!VRAMDispClusterSprite = !Variables+!MaxSprites+$001B
!VRAMDispOWSprite = !Variables+!MaxSprites+$002F
!TransferFrameNormalSprite = !Variables+!MaxSprites+$003F
!TransferFrameExtendedSprite = !Variables+!MaxSprites+!MaxSprites+$003F
!TransferFrameClusterSprite = !Variables+!MaxSprites+!MaxSprites+$0049
!TransferFrameOWSprite = !Variables+!MaxSprites+!MaxSprites+$005D
!SlotsUsedBySprite = !Variables+!MaxSprites+!MaxSprites+$006D
!FPSSprite = !Variables+!MaxSprites+!MaxSprites+$009D
!SlotSpriteType = !Variables+!MaxSprites+!MaxSprites+$00CD
!SlotSpriteID = !Variables+!MaxSprites+!MaxSprites+$00FD
!SlotSpriteNumber = !Variables+!MaxSprites+!MaxSprites+$012D
!DMAMapResource = !Variables+!MaxSprites+!MaxSprites+$015D
!DMAMapBNK = !Variables+!MaxSprites+!MaxSprites+$021D
!DMAMapLenght = !Variables+!MaxSprites+!MaxSprites+$027D
!DMAMapNext = !Variables+!MaxSprites+!MaxSprites+$033D
!FirstSlot = !Variables+!MaxSprites+!MaxSprites+$039D
!LastSlot = !Variables+!MaxSprites+!MaxSprites+$039E
!Mode50More = !Variables+!MaxSprites+!MaxSprites+$039F

!Routines = (read1($0082DA+4)<<16)+read2($00823D+4)

!DynamicRoutine16x16 = read3(!Routines+0)
!DynamicRoutine32x16 = read3(!Routines+3)
!DynamicRoutine32x32 = read3(!Routines+6)
!DynamicRoutine48x48 = read3(!Routines+9)
!DynamicRoutine64x64 = read3(!Routines+12)
!Reserve16x16NormalSpriteOf30FPS = read3(!Routines+15)
!Reserve16x16NormalSpriteOf60FPS = read3(!Routines+18)
!Reserve32x16NormalSpriteOf30FPS = read3(!Routines+21)
!Reserve32x16NormalSpriteOf60FPS = read3(!Routines+24)
!Reserve32x32NormalSpriteOf30FPS = read3(!Routines+27)
!Reserve32x32NormalSpriteOf60FPS = read3(!Routines+30)
!Reserve48x48NormalSpriteOf30FPS = read3(!Routines+33)
!Reserve48x48NormalSpriteOf60FPS = read3(!Routines+36)
!Reserve64x64NormalSpriteOf30FPS = read3(!Routines+39)
!Reserve64x64NormalSpriteOf60FPS = read3(!Routines+42)
!Reserve16x16ClusterSpriteOf30FPS = read3(!Routines+45)
!Reserve16x16ClusterSpriteOf60FPS = read3(!Routines+48)
!Reserve32x16ClusterSpriteOf30FPS = read3(!Routines+51)
!Reserve32x16ClusterSpriteOf60FPS = read3(!Routines+54)
!Reserve32x32ClusterSpriteOf30FPS = read3(!Routines+57)
!Reserve32x32ClusterSpriteOf60FPS = read3(!Routines+60)
!Reserve48x48ClusterSpriteOf30FPS = read3(!Routines+63)
!Reserve48x48ClusterSpriteOf60FPS = read3(!Routines+66)
!Reserve64x64ClusterSpriteOf30FPS = read3(!Routines+69)
!Reserve64x64ClusterSpriteOf60FPS = read3(!Routines+72)
!SendSignal16x16Normal = read3(!Routines+75)
!SendSignal32x16Normal = read3(!Routines+78)
!SendSignal32x32Normal = read3(!Routines+81)
!SendSignal48x48Normal = read3(!Routines+84)
!SendSignal64x64Normal = read3(!Routines+87)
!SendSignal16x16Cluster = read3(!Routines+90)
!SendSignal32x16Cluster = read3(!Routines+93)
!SendSignal32x32Cluster = read3(!Routines+96)
!SendSignal48x48Cluster = read3(!Routines+99)
!SendSignal64x64Cluster = read3(!Routines+102)
!SendSignal16x16Extended = read3(!Routines+105)
!SendSignal32x16Extended = read3(!Routines+108)
!SendSignal32x32Extended = read3(!Routines+111)
!SendSignal48x48Extended = read3(!Routines+114)
!SendSignal64x64Extended = read3(!Routines+117)
!SendSignal16x16OW = read3(!Routines+120)
!SendSignal32x16OW = read3(!Routines+123)
!SendSignal32x32OW = read3(!Routines+126)
!SendSignal48x48OW = read3(!Routines+129)
!SendSignal64x64OW = read3(!Routines+132)

;Call
!FrameIndex = $45
!BNK = $46
!GFXPointer = $47
!ResourceOffset = $4A
!ResourceSize = $4D

macro DynamicRoutine(FPS, SignalRoutine, TransferFrame, FrameIndex, LastFrameIndex, VRAMDisp, BNK, DynamicRoutine, GFXPointer, ResourceOffset, ResourceSize)
	JSL <SignalRoutine>					;Send Signal to Dynamic Z to avoid be overrited for other dynamic sprite

if <FPS>
	LDA <TransferFrame>,x	;\
	AND #$01							;|
	STA $00								;|Check if it is possible change frame
										;|
	LDA !DynamicTimer					;|
	AND #$01							;|
	CMP $00								;|
	BEQ ?+								;/
RTS
?+
endif

	LDA <FrameIndex>,x					;\
	CMP <LastFrameIndex>,x				;|If the frame didnt change, then don't reupload graphics
	BNE ?+								;/
RTS
?+
    STA <LastFrameIndex>,x				;Updates last frame
    STA $02

    LDA <BNK>
    STA !BNK

    LDA.b #<GFXPointer>&$FF
    STA !GFXPointer
    LDA.b #<GFXPointer>>>$08
    STA !GFXPointer+1
    LDA.b #<GFXPointer>>>$10
    STA !GFXPointer+2

    LDA.b #<ResourceOffset>&$FF
    STA !ResourceOffset
    LDA.b #<ResourceOffset>>>$08
    STA !ResourceOffset+1
    LDA.b #<ResourceOffset>>>$10
    STA !ResourceOffset+2

    LDA.b #<ResourceSize>&$FF
    STA !ResourceSize
    LDA.b #<ResourceSize>>>$08
    STA !ResourceSize+1
    LDA.b #<ResourceSize>>>$10
    STA !ResourceSize+2

    LDA	<VRAMDisp>,x			;|
    PHX
    JSL <DynamicRoutine>
    PLX
endmacro

;######################################
;############## Defines ###############
;######################################

!FrameIndex = !SpriteMiscTable1
!AnimationTimer = !SpriteMiscTable7
!AnimationIndex = !SpriteMiscTable2
!AnimationFrameIndex = !SpriteMiscTable3
!LocalFlip = !SpriteMiscTable4
!GlobalFlip = !SpriteMiscTable5
!LastFrameIndex = !SpriteMiscTable6
!ResistTimer = !SpriteDecTimer1
!State = !SpriteMiscTable8

;######################################
;########### Init Routine #############
;######################################
print "INIT ",pc
	LDA #$01
	STA !GlobalFlip,x
	LDA #$00
	STA !ResistTimer,x
	STA !State,x

	LDA #-!WalkSpeed
	STA !SpriteXSpeed,x

	JSL InitWrapperChangeAnimationFromStart
	LDA #$FF
	STA !LastFrameIndex,x

	JSL !Reserve64x64NormalSpriteOf30FPS
	BCS +
	RTL
+
	JSL !SendSignal64x64Normal
    ;Here you can write your Init Code
    ;This will be excecuted when the sprite is spawned 
RTL

;######################################
;########## Main Routine ##############
;######################################
print "MAIN ",pc
    PHB
    PHK
    PLB
    JSR SpriteCode
    PLB
RTL

;>Routine: SpriteCode
;>Description: This routine excecute the logic of the sprite
;>RoutineLength: Short
Return:
RTS
SpriteCode:

    JSR GraphicRoutine                  ;Calls the graphic routine and updates sprite graphics
	JSR DynamicRoutine

    ;Here you can put code that will be excecuted each frame even if the sprite is locked

    LDA !SpriteStatus,x			        
	CMP #$08                            ;if sprite dead return
	BNE Return	

	LDA !LockAnimationFlag				    
	BNE Return			                    ;if locked animation return.

    %SubOffScreen()

    JSR InteractMarioSprite
    ;After this routine, if the sprite interact with mario, Carry is Set.

	JSR StateMachine
    ;Here you can write your sprite code routine
    ;This will be excecuted once per frame excepts when 
    ;the animation is locked or when sprite status is not #$08

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw
    
    RTS

;>EndRoutine

;######################################
;######## Sub Routine Space ###########
;######################################

;Here you can write routines or tables
StateMachine:
	LDA !State,x
	ASL
	TAY

	REP #$20
	LDA States,y
	STA !Scratch0
	SEP #$20

	LDX #$00
	JSR ($0000|!dp,x)
RTS

States:
	dw Idle
	dw Flip
	dw Resist
	dw Dead

WalkSpeed:
	db !WalkSpeed,-!WalkSpeed
StartIdle:
	STZ !State,x	
	LDA !GlobalFlip,x
	TAY
	LDA WalkSpeed,y
	STA !SpriteXSpeed,x
RTS

Idle:
	LDX !SpriteIndex

	LDA !AnimationIndex,x
	BEQ +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BEQ +

	JSR ChangeAnimationFromStart_Walk
+

	JSL $01802A|!rom
RTS

StartFlip:

RTS

Flip:
	LDX !SpriteIndex
RTS

ResistXSpeed:
	db -!ResistXSpeed,!ResistXSpeed
RecoilXSpeed:
	db !RecoilXSpeed,-!RecoilXSpeed
StartResist:
	LDA #!MaxResistTime
	STA !ResistTimer,x

	LDA #$02
	STA !State,x
	LDA !GlobalFlip,x
	TAY
	LDA ResistXSpeed,y
	STA !SpriteXSpeed,x
	LDA RecoilXSpeed,y
	STA !PlayerXSpeed
	LDA #!RecoilYSpeed
	STA !PlayerYSpeed
RTS

Resist:
	LDX !SpriteIndex

	LDA !AnimationIndex,x
	CMP #$04
	BEQ +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BEQ +

	JSR ChangeAnimationFromStart_Resist
+

	LDA !SpriteXSpeed,x
	BMI +
	BEQ ++

	DEC A

	BRA ++
+
	INC A
++
	STA !SpriteXSpeed,x

	JSL $01802A|!rom

	LDA !ResistTimer,x
	BNE +

	LDA !SpriteBlockedStatus_ASB0UDLR,x
	AND #$04
	BEQ +

	JSR StartIdle
+
RTS

StartDead:

RTS

Dead:
	LDX !SpriteIndex
RTS



;>Section Dynamic
;######################################
;########## Animation Space ###########
;######################################
ResourceOffset:
Walk0_ResourceOffset:
	dw $0000,$0200,$0400,$0460
Walk1_ResourceOffset:
	dw $04A0,$06A0,$08A0,$0920
Walk2_ResourceOffset:
	dw $0960,$0B60,$0D60,$0E00
Walk3_ResourceOffset:
	dw $0E80,$1080,$1280,$1300
Walk4_ResourceOffset:
	dw $1380,$1580,$1780,$1800
Walk5_ResourceOffset:
	dw $1880,$1A80,$1C80,$1CE0
Walk6_ResourceOffset:
	dw $1CE0,$1EE0,$20E0,$2140
Walk7_ResourceOffset:
	dw $2180,$2380,$2580,$2620
Flip0_ResourceOffset:
	dw $26A0,$28A0,$2AA0,$2B00
Resist0_ResourceOffset:
	dw $2B40,$2D40,$2F40,$2FC0
Death0_ResourceOffset:
	dw $3000,$3200,$3400,$34E0
Death1_ResourceOffset:
	dw $35A0,$37A0,$39A0,$3A40
Death2_ResourceOffset:
	dw $3AC0,$3CC0,$3EC0,$3F80
Death3_ResourceOffset:
	dw $4040,$4220,$4400,$44C0
Death4_ResourceOffset:
	dw $4580,$4780,$4980,$49A0
Death5_ResourceOffset:
	dw $49A0,$4BA0,$4DA0,$4DA0
Death6_ResourceOffset:
	dw $4DA0,$4FA0,$51A0,$51A0


ResourceSize:
Walk0_ResourceSize:
	dw $0460,$0000,$0000,$0040
Walk1_ResourceSize:
	dw $0480,$0000,$0000,$0040
Walk2_ResourceSize:
	dw $04A0,$0000,$0000,$0080
Walk3_ResourceSize:
	dw $0480,$0000,$0000,$0080
Walk4_ResourceSize:
	dw $0480,$0000,$0000,$0080
Walk5_ResourceSize:
	dw $0460,$0000,$0000,$0000
Walk6_ResourceSize:
	dw $0460,$0000,$0000,$0040
Walk7_ResourceSize:
	dw $04A0,$0000,$0000,$0080
Flip0_ResourceSize:
	dw $0460,$0000,$0000,$0040
Resist0_ResourceSize:
	dw $0480,$0000,$0000,$0040
Death0_ResourceSize:
	dw $04E0,$0000,$0000,$00C0
Death1_ResourceSize:
	dw $04A0,$0000,$0000,$0080
Death2_ResourceSize:
	dw $04C0,$0000,$0000,$00C0
Death3_ResourceSize:
	dw $01E0,$01E0,$00C0,$00C0
Death4_ResourceSize:
	dw $0420,$0000,$0000,$0000
Death5_ResourceSize:
	dw $0400,$0000,$0000,$0000
Death6_ResourceSize:
	dw $0400,$0000,$0000,$0000

VRAMSlot64x64:
	db $00
	db $10,$20
	db $30,$40

DynamicRoutine:
	PHB
	PLA
	STA $53
	%DynamicRoutine(1, !SendSignal64x64Normal, !TransferFrameNormalSprite, !FrameIndex, !LastFrameIndex, !VRAMDispNormalSprite, $53, !DynamicRoutine64x64, GFXPointer, ResourceOffset, ResourceSize)
RTS

GFXPointer:
dw resource

;fill this with the name of your exgfx (replace "resource.bin" for the name of your graphic.bin)
resource:
incbin "sprites\Klump.bin"
;>End Dynamic Section

;Don't Delete or write another >Section Graphics or >End Section
;All code between >Section Graphics and >End Graphics Section will be changed by Dyzen : Sprite Maker
;>Section Graphics
;######################################
;########## Graphics Space ############
;######################################

;This space is for routines used for graphics
;if you don't know enough about asm then
;don't edit them.

;>Routine: GraphicRoutine
;>Description: Updates tiles on the oam map
;results will be visible the next frame.
;>RoutineLength: Short
OAMOffset:
	db $40,$60
	db $80,$A0
	db $C0
GraphicRoutine:

    %GetDrawInfo()                     ;Calls GetDrawInfo to get the free slot and the XDisp and YDisp

	PHX
	LDA	!VRAMDispNormalSprite,x
	TAX  
	LDA OAMOffset,x
	STA !ScratchE
	PLX

    STZ !Scratch3                       ;$02 = Free Slot but in 16bits
    STY !Scratch2


    STZ !Scratch5
    LDA !GlobalFlip,x   
    EOR !LocalFlip,x
    STA !ScratchF
    ASL
    STA !Scratch4                       ;$04 = Global Flip but in 16bits
    LDA !ScratchF
    CLC
    ROR A
    ROR A 
    ROR A
    STA !ScratchF


    PHX                                 ;Preserve X
    
    STZ !Scratch7
    LDA !FrameIndex,x
    STA !Scratch6                       ;$06 = Frame Index but in 16bits

    REP #$30                            ;A/X/Y 16bits mode
    LDY !Scratch4                       ;Y = Global Flip
    LDA !Scratch6
    ASL
	CLC
    ADC FramesFlippers,y
    TAX                                 ;X = Frame Index

    LDA FramesLength,x
    CMP #$FFFF
    BNE +
    SEP #$30
    PLX
    RTS
+
    STA !Scratch8

    LDA FramesEndPosition,x
    STA !Scratch4                       ;$04 = End Position + A value used to select a frame version that is flipped

    LDA FramesStartPosition,x           
    TAX                                 ;X = Start Position
    SEP #$20                            ;A 8bits mode
    LDY !Scratch2                       ;Y = Free Slot
    CPY #$00FD
    BCS .return                         ;Y can't be more than #$00FD
-
    LDA Tiles,x
	CLC
	ADC !ScratchE
    STA !TileCode,y                     ;Set the Tile code of the tile Y

	LDA #$2D

    EOR !ScratchF
    STA !TileProperty,y                 ;Set the Tile property of the tile Y

    LDA !Scratch0
	CLC
	ADC XDisplacements,x
	STA !TileXPosition,y                ;Set the Tile x pos of the tile Y

    LDA !Scratch1
	CLC
	ADC YDisplacements,x
	STA !TileYPosition,y                ;Set the Tile y pos of the tile Y

    PHY
	REP #$20                                 
    TYA
    LSR
    LSR
    TAY                                 ;Y = Y/4 because size directions are not continuous to map 200 and 300
	SEP #$20
    LDA Sizes,x
    STA !TileSize460,y                  ;Set the Tile size of the tile Y
    PLY

    INY
    INY
    INY
    INY                                 ;Next OAM Slot
    CPY #$00FD
    BCS .return                         ;Y can't be more than #$00FD

    DEX
    BMI .return
    CPX !Scratch4                       ;if X < start position or is negative then return
    BCS -                               ;else loop

.return
    SEP #$10
    PLX                                 ;Restore X
    
    LDY #$FF                            ;Allows mode of 8 or 16 bits
    LDA !Scratch8                       ;Load the number of tiles used by the frame
    JSL $01B7B3|!rom                  		;This insert the new tiles into the oam, 
                                        ;A = #$00 => only tiles of 8x8, A = #$02 = only tiles of 16x16, A = #$04 = tiles of 8x8 or 16x16
                                        ;if you select A = #$04 then you must put the sizes of the tiles in !TileSize
RTS
;>EndRoutine

;All words that starts with '@' and finish with '.' will be replaced by Dyzen

;>Table: FramesLengths
;>Description: How many tiles use each frame.
;>ValuesSize: 16
FramesLength:
    dw $0009,$000A,$000A,$0009,$0009,$000A,$0009,$000A,$0009,$000A,$000B,$000A,$000A,$000A,$0008,$000A
	dw $0007
	dw $0009,$000A,$000A,$0009,$0009,$000A,$0009,$000A,$0009,$000A,$000B,$000A,$000A,$000A,$0008,$000A
	dw $0007
;>EndTable


;>Table: FramesFlippers
;>Description: Values used to add values to FramesStartPosition and FramesEndPosition
;To use a flipped version of the frames.
;>ValuesSize: 16
FramesFlippers:
    dw $0000,$0022
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0009,$0014,$001F,$0029,$0033,$003E,$0048,$0053,$005D,$0068,$0074,$007F,$008A,$0095,$009E,$00A9
	dw $00B1
	dw $00BB,$00C6,$00D1,$00DB,$00E5,$00F0,$00FA,$0105,$010F,$011A,$0126,$0131,$013C,$0147,$0150,$015B
	dw $0163
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$000A,$0015,$0020,$002A,$0034,$003F,$0049,$0054,$005E,$0069,$0075,$0080,$008B,$0096,$009F
	dw $00AA
	dw $00B2,$00BC,$00C7,$00D2,$00DC,$00E6,$00F1,$00FB,$0106,$0110,$011B,$0127,$0132,$013D,$0148,$0151
	dw $015C
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Walk0_Tiles:
	db $20,$0E,$0C,$0A,$08,$06,$04,$02,$00,$22
Frame1_Walk1_Tiles:
	db $23,$20,$0E,$22,$0C,$0A,$08,$06,$00,$04,$02
Frame2_Walk2_Tiles:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$00,$02,$24
Frame3_Walk3_Tiles:
	db $22,$20,$0E,$0C,$0A,$08,$06,$00,$04,$02
Frame4_Walk4_Tiles:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00
Frame5_Walk5_Tiles:
	db $0E,$22,$21,$0C,$0A,$08,$20,$06,$04,$02,$00
Frame6_Walk6_Tiles:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00
Frame7_Walk7_Tiles:
	db $22,$20,$0E,$0C,$0A,$08,$06,$00,$04,$02,$24
Frame8_Flip0_Tiles:
	db $20,$0E,$0C,$0A,$08,$06,$04,$02,$00,$22
Frame9_Resist0_Tiles:
	db $23,$20,$0E,$22,$0C,$0A,$08,$02,$00,$06,$04
Frame10_Death0_Tiles:
	db $24,$22,$26,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00
Frame11_Death1_Tiles:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00,$24
Frame12_Death2_Tiles:
	db $24,$22,$20,$0E,$0C,$0A,$08,$06,$02,$00,$04
Frame13_Death3_Tiles:
	db $24,$22,$20,$0D,$0B,$09,$03,$00,$07,$05,$01
Frame14_Death4_Tiles:
	db $0E,$0C,$0A,$20,$08,$06,$04,$02,$00
Frame15_Death5_Tiles:
	db $0C,$0A,$08,$1F,$06,$04,$1E,$02,$0F,$00,$0E
Frame16_Death6_Tiles:
	db $0E,$0C,$0A,$08,$06,$04,$02,$00
Frame0_Walk0_TilesFlipX:
	db $20,$0E,$0C,$0A,$08,$06,$04,$02,$00,$22
Frame1_Walk1_TilesFlipX:
	db $23,$20,$0E,$22,$0C,$0A,$08,$06,$00,$04,$02
Frame2_Walk2_TilesFlipX:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$00,$02,$24
Frame3_Walk3_TilesFlipX:
	db $22,$20,$0E,$0C,$0A,$08,$06,$00,$04,$02
Frame4_Walk4_TilesFlipX:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00
Frame5_Walk5_TilesFlipX:
	db $0E,$22,$21,$0C,$0A,$08,$20,$06,$04,$02,$00
Frame6_Walk6_TilesFlipX:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00
Frame7_Walk7_TilesFlipX:
	db $22,$20,$0E,$0C,$0A,$08,$06,$00,$04,$02,$24
Frame8_Flip0_TilesFlipX:
	db $20,$0E,$0C,$0A,$08,$06,$04,$02,$00,$22
Frame9_Resist0_TilesFlipX:
	db $23,$20,$0E,$22,$0C,$0A,$08,$02,$00,$06,$04
Frame10_Death0_TilesFlipX:
	db $24,$22,$26,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00
Frame11_Death1_TilesFlipX:
	db $22,$20,$0E,$0C,$0A,$08,$06,$04,$02,$00,$24
Frame12_Death2_TilesFlipX:
	db $24,$22,$20,$0E,$0C,$0A,$08,$06,$02,$00,$04
Frame13_Death3_TilesFlipX:
	db $24,$22,$20,$0D,$0B,$09,$03,$00,$07,$05,$01
Frame14_Death4_TilesFlipX:
	db $0E,$0C,$0A,$20,$08,$06,$04,$02,$00
Frame15_Death5_TilesFlipX:
	db $0C,$0A,$08,$1F,$06,$04,$1E,$02,$0F,$00,$0E
Frame16_Death6_TilesFlipX:
	db $0E,$0C,$0A,$08,$06,$04,$02,$00
;>EndTable

;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Walk0_XDisp:
	db $F5,$F8,$F8,$01,$01,$05,$05,$0D,$0D,$11
Frame1_Walk1_XDisp:
	db $EC,$EF,$F4,$F7,$FE,$FF,$FF,$FF,$0C,$0E,$0E
Frame2_Walk2_XDisp:
	db $EB,$F2,$F6,$F6,$FE,$FF,$FF,$FF,$0C,$0D,$0F
Frame3_Walk3_XDisp:
	db $F5,$F6,$F6,$FF,$FF,$00,$00,$09,$0D,$0D
Frame4_Walk4_XDisp:
	db $F4,$F9,$F9,$FE,$FE,$04,$04,$0D,$0D,$0D
Frame5_Walk5_XDisp:
	db $F5,$FB,$FB,$FB,$FD,$FD,$05,$05,$0D,$0D,$11
Frame6_Walk6_XDisp:
	db $F3,$FB,$FB,$FB,$FD,$FD,$FD,$0B,$0B,$0B
Frame7_Walk7_XDisp:
	db $F2,$FA,$FA,$FF,$FF,$02,$02,$06,$0B,$0B,$0F
Frame8_Flip0_XDisp:
	db $F1,$F7,$F7,$FB,$FB,$FB,$07,$0B,$0B,$17
Frame9_Resist0_XDisp:
	db $E7,$EF,$F1,$F7,$FF,$FF,$01,$0B,$0B,$0E,$0E
Frame10_Death0_XDisp:
	db $EA,$F9,$FA,$FA,$FC,$FC,$FC,$0A,$0C,$0C,$0C,$11
Frame11_Death1_XDisp:
	db $ED,$F8,$F8,$F8,$FD,$08,$08,$08,$0F,$11,$18
Frame12_Death2_XDisp:
	db $F4,$F5,$F8,$F9,$02,$04,$04,$04,$0F,$0F,$10
Frame13_Death3_XDisp:
	db $F0,$F0,$F6,$FD,$00,$00,$0B,$0D,$10,$10,$15
Frame14_Death4_XDisp:
	db $F0,$F0,$F9,$00,$00,$09,$0E,$0E,$16
Frame15_Death5_XDisp:
	db $EE,$F1,$FD,$FE,$FE,$0D,$0E,$0E,$1D,$1E,$27
Frame16_Death6_XDisp:
	db $EC,$F1,$FC,$01,$0C,$11,$16,$16
Frame0_Walk0_XDispFlipX:
	db $0B,$08,$08,$FF,$FF,$FB,$FB,$F3,$F3,$F7
Frame1_Walk1_XDispFlipX:
	db $1C,$11,$0C,$11,$02,$01,$01,$01,$F4,$F2,$F2
Frame2_Walk2_XDispFlipX:
	db $15,$0E,$0A,$0A,$02,$01,$01,$01,$F4,$F3,$F9
Frame3_Walk3_XDispFlipX:
	db $0B,$0A,$0A,$01,$01,$00,$00,$F7,$F3,$F3
Frame4_Walk4_XDispFlipX:
	db $0C,$07,$07,$02,$02,$FC,$FC,$F3,$F3,$F3
Frame5_Walk5_XDispFlipX:
	db $0B,$0D,$0D,$05,$03,$03,$03,$FB,$F3,$F3,$EF
Frame6_Walk6_XDispFlipX:
	db $15,$05,$05,$05,$03,$03,$03,$F5,$F5,$F5
Frame7_Walk7_XDispFlipX:
	db $0E,$06,$06,$01,$01,$FE,$FE,$FA,$F5,$F5,$F9
Frame8_Flip0_XDispFlipX:
	db $0F,$09,$09,$05,$05,$05,$F9,$F5,$F5,$F1
Frame9_Resist0_XDispFlipX:
	db $21,$11,$0F,$11,$01,$01,$FF,$F5,$F5,$F2,$F2
Frame10_Death0_XDispFlipX:
	db $16,$07,$0E,$06,$04,$04,$04,$F6,$F4,$F4,$F4,$EF
Frame11_Death1_XDispFlipX:
	db $13,$08,$08,$08,$03,$F8,$F8,$F8,$F1,$EF,$F0
Frame12_Death2_XDispFlipX:
	db $0C,$0B,$08,$07,$FE,$FC,$FC,$FC,$F1,$F1,$F0
Frame13_Death3_XDispFlipX:
	db $10,$10,$0A,$03,$00,$00,$F5,$F3,$F0,$F0,$EB
Frame14_Death4_XDispFlipX:
	db $10,$10,$07,$08,$00,$F7,$F2,$F2,$EA
Frame15_Death5_XDispFlipX:
	db $12,$0F,$03,$0A,$02,$F3,$FA,$F2,$EB,$E2,$E1
Frame16_Death6_XDispFlipX:
	db $14,$0F,$04,$FF,$F4,$EF,$EA,$EA
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Walk0_YDisp:
	db $10,$F0,$00,$E3,$F3,$03,$11,$F5,$05,$ED
Frame1_Walk1_YDisp:
	db $01,$F1,$01,$11,$11,$E3,$F3,$03,$08,$E8,$F8
Frame2_Walk2_YDisp:
	db $F9,$E9,$F9,$09,$12,$E2,$F2,$02,$04,$F4,$EC
Frame3_Walk3_YDisp:
	db $0F,$EF,$FF,$E3,$F3,$03,$13,$0D,$ED,$FD
Frame4_Walk4_YDisp:
	db $12,$F2,$02,$E3,$F3,$03,$12,$EE,$FE,$0E
Frame5_Walk5_YDisp:
	db $12,$F5,$FD,$02,$E5,$F5,$05,$0D,$F0,$00,$10
Frame6_Walk6_YDisp:
	db $1A,$F7,$07,$12,$E6,$F6,$06,$F1,$01,$11
Frame7_Walk7_YDisp:
	db $13,$F3,$03,$E5,$F5,$05,$14,$13,$F3,$03,$EB
Frame8_Flip0_YDisp:
	db $F5,$05,$14,$E6,$F6,$06,$10,$F4,$00,$FE
Frame9_Resist0_YDisp:
	db $04,$FB,$0B,$1B,$EB,$FB,$09,$0B,$1B,$EB,$FB
Frame10_Death0_YDisp:
	db $03,$12,$03,$0A,$E5,$F5,$05,$15,$E7,$F7,$07,$FD
Frame11_Death1_YDisp:
	db $13,$E5,$F5,$05,$13,$EC,$FC,$0C,$14,$04,$FC
Frame12_Death2_YDisp:
	db $E7,$F7,$07,$11,$1E,$EE,$FE,$0E,$F8,$08,$12
Frame13_Death3_YDisp:
	db $EA,$FA,$0A,$0E,$F2,$02,$20,$10,$F6,$00,$10
Frame14_Death4_YDisp:
	db $F1,$01,$10,$F8,$00,$0F,$F9,$09,$10
Frame15_Death5_YDisp:
	db $F8,$08,$10,$FC,$01,$10,$FD,$04,$13,$03,$02
Frame16_Death6_YDisp:
	db $FC,$0A,$01,$10,$00,$0E,$F6,$06
Frame0_Walk0_YDispFlipX:
	db $10,$F0,$00,$E3,$F3,$03,$11,$F5,$05,$ED
Frame1_Walk1_YDispFlipX:
	db $01,$F1,$01,$11,$11,$E3,$F3,$03,$08,$E8,$F8
Frame2_Walk2_YDispFlipX:
	db $F9,$E9,$F9,$09,$12,$E2,$F2,$02,$04,$F4,$EC
Frame3_Walk3_YDispFlipX:
	db $0F,$EF,$FF,$E3,$F3,$03,$13,$0D,$ED,$FD
Frame4_Walk4_YDispFlipX:
	db $12,$F2,$02,$E3,$F3,$03,$12,$EE,$FE,$0E
Frame5_Walk5_YDispFlipX:
	db $12,$F5,$FD,$02,$E5,$F5,$05,$0D,$F0,$00,$10
Frame6_Walk6_YDispFlipX:
	db $1A,$F7,$07,$12,$E6,$F6,$06,$F1,$01,$11
Frame7_Walk7_YDispFlipX:
	db $13,$F3,$03,$E5,$F5,$05,$14,$13,$F3,$03,$EB
Frame8_Flip0_YDispFlipX:
	db $F5,$05,$14,$E6,$F6,$06,$10,$F4,$00,$FE
Frame9_Resist0_YDispFlipX:
	db $04,$FB,$0B,$1B,$EB,$FB,$09,$0B,$1B,$EB,$FB
Frame10_Death0_YDispFlipX:
	db $03,$12,$03,$0A,$E5,$F5,$05,$15,$E7,$F7,$07,$FD
Frame11_Death1_YDispFlipX:
	db $13,$E5,$F5,$05,$13,$EC,$FC,$0C,$14,$04,$FC
Frame12_Death2_YDispFlipX:
	db $E7,$F7,$07,$11,$1E,$EE,$FE,$0E,$F8,$08,$12
Frame13_Death3_YDispFlipX:
	db $EA,$FA,$0A,$0E,$F2,$02,$20,$10,$F6,$00,$10
Frame14_Death4_YDispFlipX:
	db $F1,$01,$10,$F8,$00,$0F,$F9,$09,$10
Frame15_Death5_YDispFlipX:
	db $F8,$08,$10,$FC,$01,$10,$FD,$04,$13,$03,$02
Frame16_Death6_YDispFlipX:
	db $FC,$0A,$01,$10,$00,$0E,$F6,$06
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Walk0_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame1_Walk1_Sizes:
	db $00,$02,$02,$00,$02,$02,$02,$02,$02,$02,$02
Frame2_Walk2_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame3_Walk3_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame4_Walk4_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame5_Walk5_Sizes:
	db $02,$00,$00,$02,$02,$02,$00,$02,$02,$02,$02
Frame6_Walk6_Sizes:
	db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame7_Walk7_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame8_Flip0_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame9_Resist0_Sizes:
	db $00,$02,$02,$00,$02,$02,$02,$02,$02,$02,$02
Frame10_Death0_Sizes:
	db $02,$02,$00,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame11_Death1_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame12_Death2_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame13_Death3_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame14_Death4_Sizes:
	db $02,$02,$02,$00,$02,$02,$02,$02,$02
Frame15_Death5_Sizes:
	db $02,$02,$02,$00,$02,$02,$00,$02,$00,$02,$00
Frame16_Death6_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02
Frame0_Walk0_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame1_Walk1_SizesFlipX:
	db $00,$02,$02,$00,$02,$02,$02,$02,$02,$02,$02
Frame2_Walk2_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame3_Walk3_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame4_Walk4_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame5_Walk5_SizesFlipX:
	db $02,$00,$00,$02,$02,$02,$00,$02,$02,$02,$02
Frame6_Walk6_SizesFlipX:
	db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame7_Walk7_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame8_Flip0_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame9_Resist0_SizesFlipX:
	db $00,$02,$02,$00,$02,$02,$02,$02,$02,$02,$02
Frame10_Death0_SizesFlipX:
	db $02,$02,$00,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame11_Death1_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
Frame12_Death2_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame13_Death3_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Frame14_Death4_SizesFlipX:
	db $02,$02,$02,$00,$02,$02,$02,$02,$02
Frame15_Death5_SizesFlipX:
	db $02,$02,$02,$00,$02,$02,$00,$02,$00,$02,$00
Frame16_Death6_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02
;>EndTable

;>End Graphics Section

;Don't Delete or write another >Section Animation or >End Section
;All code between >Section Animations and >End Animations Section will be changed by Dyzen : Sprite Maker
;>Section Animations
;######################################
;########## Animation Space ###########
;######################################

;This space is for routines used for graphics
;if you don't know enough about asm then
;don't edit them.
InitWrapperChangeAnimationFromStart:
	PHB
    PHK
    PLB
	STZ !AnimationIndex,x
	JSR ChangeAnimationFromStart
	PLB
	RTL

ChangeAnimationFromStart_Walk:
	STZ !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_Flip:
	LDA #$01
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_Resist:
	LDA #$02
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_DeathLoop:
	LDA #$03
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_Death:
	LDA #$04
	STA !AnimationIndex,x


ChangeAnimationFromStart:
	STZ !AnimationFrameIndex,x

	STZ !Scratch1
	LDA !AnimationIndex,x
	STA !Scratch0					;$00 = Animation index in 16 bits

	STZ !Scratch3
	LDA !AnimationFrameIndex,x
	STA !Scratch2					;$02 = Animation Frame index in 16 bits

	STZ !Scratch5
	STX !Scratch4					;$04 = sprite index in 16 bits

	REP #$30						;A7X/Y of 16 bits
	LDX !Scratch4					;X = sprite index in 16 bits

	LDA !Scratch0
	ASL
	TAY								;Y = 2*Animation index

	LDA !Scratch2
	CLC
	ADC AnimationIndexer,y
	TAY								;Y = Position of the first frame of the animation + animation frame index

	SEP #$20						;A of 8 bits

	LDA Frames,y
	STA !FrameIndex,x				;New Frame = Frames[New Animation Frame Index]

	LDA Times,y
	STA !AnimationTimer,x			;Time = Times[New Animation Frame Index]

	LDA Flips,y
	STA !LocalFlip,x				;Flip = Flips[New Animation Frame Index]

	LDA !Scratch2
	STA !AnimationFrameIndex,x

	SEP #$10						;X/Y of 8 bits
	LDX !Scratch4					;X = sprite index in 8 bits
RTS
	

;>Routine: AnimationRoutine
;>Description: Decides what will be the next frame.
;>RoutineLength: Short
AnimationRoutine:
	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BNE +
RTS
+

    LDA !AnimationTimer,x
    BEQ +

	DEC A
	DEC A
	STA !AnimationTimer,x
	RTS

+
	STZ !Scratch1
	LDA !AnimationIndex,x
	STA !Scratch0					;$00 = Animation index in 16 bits

	STZ !Scratch3
	LDA !AnimationFrameIndex,x
	STA !Scratch2					;$02 = Animation Frame index in 16 bits

	STZ !Scratch5
	STX !Scratch4					;$04 = sprite index in 16 bits

	REP #$30						;A7X/Y of 16 bits
	LDX !Scratch4					;X = sprite index in 16 bits

	LDA !Scratch0
	ASL
	TAY								;Y = 2*Animation index

	INC !Scratch2					;New Animation Frame Index = Animation Frame Index + 1

	LDA !Scratch2			        ;if Animation Frame index < Animation Lenght then Animation Frame index++
	CMP AnimationLenght,y			;else go to the frame where start the loop.
	BCC +							

	LDA AnimationLastTransition,y
	STA !Scratch2					;New Animation Frame Index = first frame of the loop.

+
	LDA !Scratch2
	CLC
	ADC AnimationIndexer,y
	TAY								;Y = Position of the first frame of the animation + animation frame index

	SEP #$20						;A of 8 bits

	LDA Frames,y
	STA !FrameIndex,x				;New Frame = Frames[New Animation Frame Index]

	LDA Times,y
	STA !AnimationTimer,x			;Time = Times[New Animation Frame Index]

	LDA Flips,y
	STA !LocalFlip,x				;Flip = Flips[New Animation Frame Index]

	LDA !Scratch2
	STA !AnimationFrameIndex,x

	SEP #$10						;X/Y of 8 bits
	LDX !Scratch4					;X = sprite index in 8 bits
RTS
;>EndRoutine

;All words that starts with '>' and finish with '.' will be replaced by Dyzen

AnimationLenght:
	dw $0008,$0002,$0001,$0002,$0005

AnimationLastTransition:
	dw $0000,$0001,$0000,$0001,$0004

AnimationIndexer:
	dw $0000,$0008,$000A,$000B,$000D

Frames:
	
Animation0_Walk_Frames:
	db $00,$01,$02,$03,$04,$05,$06,$07
Animation1_Flip_Frames:
	db $08,$08
Animation2_Resist_Frames:
	db $09
Animation3_DeathLoop_Frames:
	db $0A,$0B
Animation4_Death_Frames:
	db $0C,$0D,$0E,$0F,$10

Times:
	
Animation0_Walk_Times:
	db $04,$04,$04,$04,$04,$04,$04,$04
Animation1_Flip_Times:
	db $02,$02
Animation2_Resist_Times:
	db $04
Animation3_DeathLoop_Times:
	db $04,$04
Animation4_Death_Times:
	db $02,$04,$04,$04,$04

Flips:
	
Animation0_Walk_Flips:
	db $00,$00,$00,$00,$00,$00,$00,$00
Animation1_Flip_Flips:
	db $00,$01
Animation2_Resist_Flips:
	db $00
Animation3_DeathLoop_Flips:
	db $00,$00
Animation4_Death_Flips:
	db $00,$00,$00,$00,$00

;>End Animations Section

;Don't Delete or write another >Section Hitbox Interaction or >End Section
;All code between >Section Hitboxes Interaction and >End Hitboxes Interaction Section will be changed by Dyzen : Sprite Maker
;>Section Hitboxes Interaction
;######################################
;######## Interaction Space ###########
;######################################

InteractMarioSprite:
	LDA !SpriteTweaker167A_DPMKSPIS,x
	AND #$20
	BNE ProcessInteract      
	TXA                       
	EOR !TrueFrameCounter      			
	AND #$01                	
	ORA !SpriteHOffScreenFlag,x 				
	BEQ ProcessInteract       
ReturnNoContact:
	CLC                       
	RTS
ProcessInteract:
	%SubHorzPos()
	LDA !ScratchF                  
	CLC                       
	ADC #$50                
	CMP #$A0                
	BCS ReturnNoContact       ; No contact, return 
	%SubVertPos()         
	LDA !ScratchF                   
	CLC                       
	ADC #$60                
	CMP #$C0                
	BCS ReturnNoContact       ; No contact, return 
	LDA $71    ; \ If animation sequence activated... 
	CMP #$01                ;  | 
	BCS ReturnNoContact       ; / ...no contact, return 
	LDA #$00                ; \ Branch if bit 6 of $0D9B set? 
	BIT $0D9B|!addr               ;  | 
	BVS +           ; / 
	LDA $13F9|!addr ; \ If Mario and Sprite not on same side of scenery... 
	EOR !SpriteBehindEscenaryFlag,x ;  |
+
	BNE ReturnNoContact2
	JSL $03B664|!rom				; MarioClipping
	JSR Interaction

	BCC ReturnNoContact2
	LDA !ScratchE
	CMP #$01
	BNE +
	JSR DefaultAction
+
	SEC
	RTS
ReturnNoContact2:
	CLC
	RTS

Interaction:
    STZ !ScratchE
	LDA !GlobalFlip,x
    EOR !LocalFlip,x
    ASL
	TAY                     ;Y = Flip Adder, used to jump to the frame with the current flip

    LDA !FrameIndex,x
	STA !Scratch4
	STZ !Scratch5

    REP #$20
	LDA !Scratch4
	ASL
	CLC
	ADC HitboxAdder,y
	REP #$10
	TAY

    LDA FrameHitboxesIndexer,y
    TAY
    SEP #$20

-
    LDA FrameHitBoxes,y
    CMP #$FF
    BNE +
    LDA !ScratchE
    BNE ++
	SEP #$10
	LDX !SpriteIndex
    CLC
    RTS
++
	SEP #$10
	LDX !SpriteIndex
    SEC
    RTS
+
    STA !Scratch4
    STZ !Scratch5
    PHY

    REP #$20
    LDA !Scratch4
    ASL
    TAY

    LDA HitboxesStart,y
    TAY
    SEP #$20
+

	STZ !ScratchA
    LDA Hitboxes+1,y
    STA !Scratch4           ;$04 = Low X Offset
    BPL +
    LDA #$FF
    STA !ScratchA           ;$0A = High X offset
+

	STZ !ScratchB
    LDA Hitboxes+2,y
    STA !Scratch5           ;$05 = Low Y Offset
    BPL +
    LDA #$FF
    STA !ScratchB           ;$0B = High Y Offset
+

    LDA Hitboxes+3,y
    STA !Scratch6           ;$06 = Width

    LDA Hitboxes+4,y
    STA !Scratch7           ;$07 = Height

	PHY
	SEP #$10
	LDX !SpriteIndex

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	PHA
	SEP #$20

	LDA !ScratchA
	XBA
	LDA !Scratch4
	REP #$20
	CLC
	ADC $01,s
	PHA
	SEP #$20
	PLA 
	STA !Scratch4
	PLA
	STA !ScratchA
	PLA
	PLA

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	PHA
	SEP #$20

	LDA !ScratchB
	XBA
	LDA !Scratch5
	REP #$20
	CLC
	ADC $01,s
	PHA
	SEP #$20
	PLA 
	STA !Scratch5
	PLA
	STA !ScratchB
	PLA
	PLA

    JSL $03B72B|!rom
	REP #$10
	BCS ++
	PLY
	PLY
	INY
	JMP -
++
	PLY
	PLY
	LDA !ScratchE
	ORA #$01
	STA !ScratchE
	SEP #$10
	LDX !SpriteIndex
	SEC
	RTS

HitboxAdder:
    dw $0000,$0022

FrameHitboxesIndexer:
    dw $0000,$0002,$0005,$0007,$0009,$000B,$000D,$000F,$0011,$0013,$0015,$0016,$0017,$0018,$0019,$001A
	dw $001B
	dw $001C,$001E,$0021,$0023,$0025,$0027,$0029,$002B,$002D,$002F,$0031,$0032,$0033,$0034,$0035,$0036
	dw $0037

FrameHitBoxes:
    db $00,$FF
	db $01,$02,$FF
	db $03,$FF
	db $04,$FF
	db $05,$FF
	db $06,$FF
	db $07,$FF
	db $08,$FF
	db $09,$FF
	db $0A,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	
	db $0B,$FF
	db $0C,$0D,$FF
	db $0E,$FF
	db $0F,$FF
	db $10,$FF
	db $11,$FF
	db $12,$FF
	db $13,$FF
	db $14,$FF
	db $15,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	

HitboxesStart:
    dw $0000,$0006,$000C,$0012,$0018,$001E,$0024,$002A,$0030,$0036,$003C,$0042,$0048,$004E,$0054,$005A
	dw $0060,$0066,$006C,$0072,$0078,$007E

Hitboxes:
    db $01,$01,$E8,$0F,$37,$00
	db $01,$01,$E8,$0F,$29,$00
	db $01,$00,$11,$0E,$0F,$00
	db $01,$FF,$E7,$0F,$39,$00
	db $01,$FF,$E8,$0F,$37,$00
	db $01,$FE,$E8,$0F,$37,$00
	db $01,$FD,$EA,$0F,$35,$00
	db $01,$FE,$EA,$0F,$36,$00
	db $01,$FF,$E9,$0F,$37,$00
	db $01,$FB,$EC,$0F,$35,$00
	db $01,$09,$ED,$0F,$33,$00
	db $01,$00,$E8,$0F,$37,$00
	db $01,$00,$E8,$0F,$29,$00
	db $01,$02,$11,$0E,$0F,$00
	db $01,$02,$E7,$0F,$39,$00
	db $01,$02,$E8,$0F,$37,$00
	db $01,$03,$E8,$0F,$37,$00
	db $01,$04,$EA,$0F,$35,$00
	db $01,$03,$EA,$0F,$36,$00
	db $01,$02,$E9,$0F,$37,$00
	db $01,$06,$EC,$0F,$35,$00
	db $01,$F8,$ED,$0F,$33,$00
	

;This routine will be executed when mario interact with a standar hitbox.
;It will be excecuted if $0E is 1 after execute Interaction routine
DefaultAction:
	LDX !SpriteIndex
	JSR SpikyInteraction
RTS
    
;>End Hitboxes Interaction Section
SpikyInteraction:
    LDA $1490|!addr ;if player is using the star
    BEQ +           ;kill the sprite
    %Star()
    RTS
+
    LDA !PlayerYSpeed   ;\
    ;SEC                 ;|Get relative speed between player and the sprite, if it is negative then damage the player
    ;SBC !SpriteYSpeed,x ;/
    BMI +++             ;other wise check the position of the player
 
    STZ !ScratchD
    LDA !Scratch3
    STA !ScratchC       ;Loads height of the player hitbox on Scratch C
 
    LDA !Scratch9
    XBA
    LDA !Scratch1       ;Loads player hitbox Y position
    REP #$20
    CLC
    ADC !ScratchC       ;A =Player hitbox Y position + hitbox height = Bottom of the hitbox
    SEC
    SBC #$0008
    STA !ScratchC       ;!Scratch C = Bottom of player hitbox - 8 (to detects a range)
    SEP #$20
 
    LDA !ScratchB       ;A = top of Sprite hitbox
    XBA
    LDA !Scratch5
    REP #$20
    CMP !ScratchC       ;compare Top of the sprite hitbox with the Bottom of player hitbox - 8 (to detects a range)
    BCC +++             ;If the top of the sprite hitbox is on a position Higher than bottom of player hitbox then do spin jump
 
 
    PHA                 ;\
    LDA !ScratchC       ;|
    SEC                 ;|
    SBC $01,s           ;|
	CLC
    ADC #$0008          ;|Moves the player to the top of the sprite hitbox
    STA !ScratchC       ;|
    PLA                 ;|
                        ;|
    LDA !PlayerY        ;|
    SEC                 ;|
    SBC !ScratchC       ;|
    STA !PlayerY        ;|
                        ;|
    SEP #$20            ;/
 
    JSL $01AB99|!rom    ;Display White Star                
    JSL $01AA33|!rom    ;Do the player boost its Y Speed   
 
    LDA #$02
    STA $1DF9|!addr     ;Play Spin Jump Sound
 
    JSR StartResist
 
    RTS                 ;Return
+++
    SEP #$20
 
    ;###########################################################################
    ;Here you can add code that happend when the player is damaged by the sprite
    ;##########################################################################
 
    PHX
 
    LDA $187A|!addr     ;if the player is not riding yoshi then damage the player
    BEQ +               ;otherwise dismount yoshi
    JSR FindYoshi
    BCC +
    JSR DismountYoshi
    PLX
RTS
+
    JSL $00F5B7|!rom
    PLX
RTS
 
FindYoshi:
    LDX $18DF|!addr
    BEQ .crawlForYoshi
    DEX
    BRA .found
.crawlForYoshi:
    LDX.w $1692|!addr
    ; Start Slot according to sprite data
    LDA.l $02A773|!rom,x
    SEC
    SBC #$FE ; spaces 2 reserved slots, have to interact with them too
    TAX
.loop:
    LDA !SpriteNumber,x
    CMP #$35
    BNE .continueLoop
   
    LDA !SpriteStatus,x
    BNE .found
.continueLoop
    DEX
    BPL .loop
.returnClear:
    CLC
    RTS
.found
    SEC
    RTS
 
DismountYoshi:
    LDA #$10                
    STA !SpriteDecTimer6,x            
    LDA #$03                ; \ Play sound effect
    STA $1DFA|!addr         ; /
    LDA #$13                ; \ Play sound effect
    STA $1DFC|!addr         ; /
    LDA #$02                
    STA !SpriteMiscTable3,x    
    STZ $187A|!addr        
    LDA #$C0                
    STA !PlayerYSpeed      
    STZ !PlayerXSpeed      
    %SubHorzPos()      
    LDA XSpeedDismountTable,y      
    STA !SpriteXSpeed,X    
    STZ !SpriteMiscTable10,x            
    STZ !SpriteMiscTable6,X            
    STZ $18AE|!addr              
    STZ $0DC1|!addr      
    LDA #$30                ; \ Mario invincible timer = #$30
    STA $1497|!addr         ; /
    JSR CODE_01EDCC        
RTS                       ; Return
 
XSpeedDismountTable:
    db $E8,$18
 
CODE_01EDCC:
    LDY.B #$00                
    LDA !SpriteYLow,X      
    SEC                      
    SBC YoshiOffset,Y      
    STA !PlayerY        
    STA $D3                  
    LDA !SpriteYHigh,X    
    SBC #$00                
    STA !PlayerY+$01      
    STA $D4                  
RTS                       ; Return
 
YoshiOffset:
    db $04,$10
;>End Hitboxes Interaction Section