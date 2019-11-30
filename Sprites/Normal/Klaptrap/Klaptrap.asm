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
!ExtraByte1 = $400099
!ExtraByte2 = $4000AF
!ExtraByte3 = $4000C5
!ExtraByte4 = $4000DB
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
!State = !SpriteMiscTable8
!FlashTimer = !SpriteDecTimer1
!XSpeed = !ExtraByte1
!Hitpoints = !ExtraByte2
!FlashMaxTime = !ExtraByte3
!JumpSpeed = !ExtraByte4
!WalkSpeed = !SpriteMiscTable9
!OneUpFlag = !SpriteMiscTable10

;######################################
;########### Init Routine #############
;######################################
print "INIT ",pc
	LDA #$00
	STA !GlobalFlip,x
	STA !State,x 
	STA !FlashTimer,x
	LDA #$FF
	STA !LastFrameIndex,x
	JSL InitWrapperChangeAnimationFromStart
    ;Here you can write your Init Code
    ;This will be excecuted when the sprite is spawned 
	JSL !Reserve32x32NormalSpriteOf30FPS
	BCS +
	RTL
+
	JSL !SendSignal32x32Normal

	LDA !Hitpoints,x
	BEQ +

	LDA #$01
	STA !OneUpFlag,x

+
	JSR SetWalkAnimationSpeed
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
	CMP #$02
	BEQ +	        
	CMP #$08                            ;if sprite dead return
	BNE Return	
+
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
    ;JSR changeframe

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
	dw Walk
	dw Flip
	dw Damage
	dw Dead

SetWalkAnimationSpeed:
	LDA #$06
	STA !WalkSpeed,x
	LDA !XSpeed,x
	CMP #$20
	BCC +
	LDA #$04
	STA !WalkSpeed,x
	CMP #$30
	BCC +
	LDA #$02
	STA !WalkSpeed,x
+
RTS

Movement:

	LDA !ExtraBits,x
	AND #$04
	BEQ +

	LDA !ButtonDown_AXLR0000
	AND #$80
	BNE ++

	LDA !ButtonDown_BYETUDLR
	AND #$80
	BEQ +
++
	LDA !SpriteBlockedStatus_ASB0UDLR,x
	AND #$04
	BEQ +

	LDA !JumpSpeed,x
	STA !SpriteYSpeed,x

+

	LDA !XSpeed,x
	STA !SpriteXSpeed,x

	LDA !GlobalFlip,x
	BEQ +
	LDA #$00
	SEC
	SBC !SpriteXSpeed,x
	STA !SpriteXSpeed,x
+

	LDA !SpriteBlockedStatus_ASB0UDLR,x
	AND #$03
	BEQ +

	JSR StartFlip

+
	JSL $01802A|!rom
RTS

StartWalk:
	STZ !State,x
RTS

Walk:
	LDX !SpriteIndex

	LDA !AnimationIndex,x
	BEQ +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA !Scratch0

	LDA !DynamicTimer
	AND #$01
	CMP !Scratch0
	BEQ +

	JSR ChangeAnimationFromStart_walk

+
	JSR Movement
RTS

FlipMovement:
	LDA !LocalFlip,x
	BEQ +
	LDA !XSpeed,x
	STA !SpriteXSpeed,x

	LDA !GlobalFlip,x
	BNE +
	LDA #$00
	SEC
	SBC !SpriteXSpeed,x
	STA !SpriteXSpeed,x
+
	JSL $01802A|!rom
RTS

StartFlip:
	LDA #$01
	STA !State,x
	STZ !SpriteXSpeed,x
RTS

TransitionTable: db $00,$01,$02,$03,$04,$05,$05,$04,$03
Flip:
	LDX !SpriteIndex
	LDA !AnimationIndex,x
	CMP #$01
	BEQ +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BEQ +

	LDA !AnimationIndex,x
	BNE ++

	LDA !AnimationFrameIndex,x
	TAY

	LDA #$01
	STA !AnimationIndex,x

	LDA TransitionTable,y
	STA !AnimationFrameIndex,x
	TAY

	LDA Animation1_flip_Frames,y
	STA !FrameIndex,x
	BRA +

++
	JSR ChangeAnimationFromStart_flip
+
	JSR FlipMovement

	LDA !AnimationIndex,x
	CMP #$01
	BNE +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BEQ +

	LDA !AnimationTimer,x
	BNE +

	LDA !AnimationFrameIndex,x
	CMP #$09
	BCC +

	LDA !GlobalFlip,x
	EOR #$01
	STA !GlobalFlip,x
	JSR StartWalk
	JSR ChangeAnimationFromStart_walk

+
RTS

StartDamage:
	LDA #$02
	STA !State,x
	STZ !SpriteXSpeed,x
	LDA !FlashMaxTime,x
	STA !FlashTimer,x 
	LDA !GlobalFlip,x
	EOR !LocalFlip,x
	STA !GlobalFlip,x
RTS

Damage:
	LDX !SpriteIndex

	LDX !SpriteIndex
	LDA !AnimationIndex,x
	CMP #$02
	BEQ +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BEQ +

	JSR ChangeAnimationFromStart_death

+	
	JSL $01802A|!rom

	LDA !AnimationIndex,x
	CMP #$02
	BNE +

	LDA !AnimationTimer,x
	BNE +

	LDA !AnimationFrameIndex,x
	CMP #$0A
	BCC +

	JSR StartWalk
+
RTS

StartDead:
	LDA #$03
	STA !State,x
	JSR SpawnPowerUp
	LDA #$C0
	STA !SpriteYSpeed,x
	LDA #$02
	STA !SpriteStatus,x
	LDA !GlobalFlip,x
	EOR !LocalFlip,x
	STA !GlobalFlip,x
RTS

Dead:
	LDX !SpriteIndex
	LDA !AnimationIndex,x
	CMP #$03
	BEQ +

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BEQ +

	JSR ChangeAnimationFromStart_damage

+
RTS

SpawnPowerUp:
	LDA !ExtraBits,x
	AND #$04
	BNE +

	LDA !OneUpFlag,x
	BEQ +

	STZ !Scratch0
	STZ !Scratch1
	LDA !SpriteXSpeed,x
	STA !Scratch2
	LDA #$C0
	STA !Scratch3

	LDA #$78
	CLC
	%SpawnSpriteBehind()

+
RTS


;######################################
;######### Dynamic Routine ############
;######################################
ResourceOffset:
Frame0_ResourceOffset:
	dw $0000,$00A0
Frame1_ResourceOffset:
	dw $0120,$0200
Frame2_ResourceOffset:
	dw $02C0,$03A0
Frame3_ResourceOffset:
	dw $0460,$0520
Frame4_ResourceOffset:
	dw $05E0,$06A0
Frame5_ResourceOffset:
	dw $0740,$0820
Frame6_ResourceOffset:
	dw $0900,$09E0
Frame7_ResourceOffset:
	dw $0AC0,$0BA0
Frame8_ResourceOffset:
	dw $0C80,$0D60
Frame9_ResourceOffset:
	dw $0E20,$0EE0
Frame10_ResourceOffset:
	dw $0F80,$1020
Frame11_ResourceOffset:
	dw $10C0,$1160
Frame12_ResourceOffset:
	dw $1200,$12A0
Frame13_ResourceOffset:
	dw $1340,$13E0
Frame14_ResourceOffset:
	dw $1480,$1520
Frame15_ResourceOffset:
	dw $15C0,$16A0
Frame16_ResourceOffset:
	dw $1760,$1800


ResourceSize:
Frame0_ResourceSize:
	dw $00A0,$0080
Frame1_ResourceSize:
	dw $00E0,$00C0
Frame2_ResourceSize:
	dw $00E0,$00C0
Frame3_ResourceSize:
	dw $00C0,$00C0
Frame4_ResourceSize:
	dw $00C0,$00A0
Frame5_ResourceSize:
	dw $00E0,$00E0
Frame6_ResourceSize:
	dw $00E0,$00E0
Frame7_ResourceSize:
	dw $00E0,$00E0
Frame8_ResourceSize:
	dw $00E0,$00C0
Frame9_ResourceSize:
	dw $00C0,$00A0
Frame10_ResourceSize:
	dw $00A0,$00A0
Frame11_ResourceSize:
	dw $00A0,$00A0
Frame12_ResourceSize:
	dw $00A0,$00A0
Frame13_ResourceSize:
	dw $00A0,$00A0
Frame14_ResourceSize:
	dw $00A0,$00A0
Frame15_ResourceSize:
	dw $00E0,$00C0
Frame16_ResourceSize:
	dw $00A0,$00A0
	
DynamicRoutine:
	PHB
	PLA
	STA $53
	%DynamicRoutine(1, !SendSignal32x32Normal, !TransferFrameNormalSprite, !FrameIndex, !LastFrameIndex, !VRAMDispNormalSprite, $53, !DynamicRoutine32x32, GFXPointer, ResourceOffset, ResourceSize)
RTS

GFXPointer:
dw resource

;fill this with the name of your exgfx (replace "resource.bin" for the name of your graphic.bin)
resource:
incbin "sprites\Klaptrap.bin"

;Here you can write routines or tables

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
	db $40,$48,$60,$68
	db $80,$88,$A0,$A8
	db $C0,$C8,$E0,$E8

GraphicRoutine:
	LDA !LastFrameIndex,x
	CMP #$FF
	BNE +
	RTS
+
	LDA !FlashTimer,x
	BEQ +
	AND #$01
	BEQ +
	RTS
+

    %GetDrawInfo()                     ;Calls GetDrawInfo to get the free slot and the XDisp and YDisp

	LDA #$08
	STA !ScratchD
	LDA !ExtraBits,x
	AND #$04
	BEQ +

	LDA #$0C
	STA !ScratchD
+

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

	LDA #$29
    EOR !ScratchF
	AND #$F1
	ORA !ScratchD
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
    dw $0002,$0003,$0003,$0002,$0004,$0004,$0004,$0004,$0003,$0003,$0003,$0003,$0003,$0003,$0003,$0003
	dw $0003
	dw $0002,$0003,$0003,$0002,$0004,$0004,$0004,$0004,$0003,$0003,$0003,$0003,$0003,$0003,$0003,$0003
	dw $0003
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
    dw $0002,$0006,$000A,$000D,$0012,$0017,$001C,$0021,$0025,$0029,$002D,$0031,$0035,$0039,$003D,$0041
	dw $0045
	dw $0048,$004C,$0050,$0053,$0058,$005D,$0062,$0067,$006B,$006F,$0073,$0077,$007B,$007F,$0083,$0087
	dw $008B
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0003,$0007,$000B,$000E,$0013,$0018,$001D,$0022,$0026,$002A,$002E,$0032,$0036,$003A,$003E
	dw $0042
	dw $0046,$0049,$004D,$0051,$0054,$0059,$005E,$0063,$0068,$006C,$0070,$0074,$0078,$007C,$0080,$0084
	dw $0088
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Frame0_Tiles:
	db $04,$02,$00
Frame1_Frame1_Tiles:
	db $04,$02,$06,$00
Frame2_Frame2_Tiles:
	db $04,$02,$06,$00
Frame3_Frame3_Tiles:
	db $04,$02,$00
Frame4_Frame4_Tiles:
	db $05,$02,$14,$00,$04
Frame5_Frame5_Tiles:
	db $16,$04,$06,$00,$02
Frame6_Frame6_Tiles:
	db $16,$04,$06,$02,$00
Frame7_Frame7_Tiles:
	db $16,$04,$06,$02,$00
Frame8_Frame8_Tiles:
	db $04,$02,$06,$00
Frame9_Frame9_Tiles:
	db $03,$00,$05,$01
Frame10_Frame10_Tiles:
	db $14,$02,$00,$04
Frame11_Frame11_Tiles:
	db $14,$02,$00,$04
Frame12_Frame12_Tiles:
	db $14,$02,$00,$04
Frame13_Frame13_Tiles:
	db $14,$02,$00,$04
Frame14_Frame14_Tiles:
	db $14,$02,$00,$04
Frame15_Frame15_Tiles:
	db $04,$02,$06,$00
Frame16_Frame16_Tiles:
	db $02,$14,$00,$04
Frame0_Frame0_TilesFlipX:
	db $04,$02,$00
Frame1_Frame1_TilesFlipX:
	db $04,$02,$06,$00
Frame2_Frame2_TilesFlipX:
	db $04,$02,$06,$00
Frame3_Frame3_TilesFlipX:
	db $04,$02,$00
Frame4_Frame4_TilesFlipX:
	db $05,$02,$14,$00,$04
Frame5_Frame5_TilesFlipX:
	db $16,$04,$06,$00,$02
Frame6_Frame6_TilesFlipX:
	db $16,$04,$06,$02,$00
Frame7_Frame7_TilesFlipX:
	db $16,$04,$06,$02,$00
Frame8_Frame8_TilesFlipX:
	db $04,$02,$06,$00
Frame9_Frame9_TilesFlipX:
	db $03,$00,$05,$01
Frame10_Frame10_TilesFlipX:
	db $14,$02,$00,$04
Frame11_Frame11_TilesFlipX:
	db $14,$02,$00,$04
Frame12_Frame12_TilesFlipX:
	db $14,$02,$00,$04
Frame13_Frame13_TilesFlipX:
	db $14,$02,$00,$04
Frame14_Frame14_TilesFlipX:
	db $14,$02,$00,$04
Frame15_Frame15_TilesFlipX:
	db $04,$02,$06,$00
Frame16_Frame16_TilesFlipX:
	db $02,$14,$00,$04
;>EndTable

;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Frame0_XDisp:
	db $FE,$03,$04
Frame1_Frame1_XDisp:
	db $F3,$03,$05,$0D
Frame2_Frame2_XDisp:
	db $F2,$02,$08,$0D
Frame3_Frame3_XDisp:
	db $F2,$02,$0D
Frame4_Frame4_XDisp:
	db $F5,$FB,$07,$0B,$15
Frame5_Frame5_XDisp:
	db $F6,$FB,$04,$0B,$0B
Frame6_Frame6_XDisp:
	db $F8,$FC,$04,$0A,$0A
Frame7_Frame7_XDisp:
	db $F6,$FA,$05,$0A,$0C
Frame8_Frame8_XDisp:
	db $F5,$05,$08,$0D
Frame9_Frame9_XDisp:
	db $F5,$05,$05,$0D
Frame10_Frame10_XDisp:
	db $F3,$F9,$08,$16
Frame11_Frame11_XDisp:
	db $F2,$F9,$08,$16
Frame12_Frame12_XDisp:
	db $F1,$F6,$06,$14
Frame13_Frame13_XDisp:
	db $F2,$F5,$05,$14
Frame14_Frame14_XDisp:
	db $F3,$F4,$04,$12
Frame15_Frame15_XDisp:
	db $F0,$00,$0D,$0D
Frame16_Frame16_XDisp:
	db $F6,$05,$06,$15
Frame0_Frame0_XDispFlipX:
	db $0A,$FD,$FC
Frame1_Frame1_XDispFlipX:
	db $0D,$FD,$03,$F3
Frame2_Frame2_XDispFlipX:
	db $0E,$FE,$00,$F3
Frame3_Frame3_XDispFlipX:
	db $0E,$FE,$F3
Frame4_Frame4_XDispFlipX:
	db $13,$05,$01,$F5,$F3
Frame5_Frame5_XDispFlipX:
	db $12,$05,$04,$F5,$F5
Frame6_Frame6_XDispFlipX:
	db $10,$04,$04,$F6,$F6
Frame7_Frame7_XDispFlipX:
	db $12,$06,$03,$F6,$F4
Frame8_Frame8_XDispFlipX:
	db $0B,$FB,$00,$F3
Frame9_Frame9_XDispFlipX:
	db $0B,$FB,$03,$F3
Frame10_Frame10_XDispFlipX:
	db $15,$07,$F8,$F2
Frame11_Frame11_XDispFlipX:
	db $16,$07,$F8,$F2
Frame12_Frame12_XDispFlipX:
	db $17,$0A,$FA,$F4
Frame13_Frame13_XDispFlipX:
	db $16,$0B,$FB,$F4
Frame14_Frame14_XDispFlipX:
	db $15,$0C,$FC,$F6
Frame15_Frame15_XDispFlipX:
	db $10,$00,$FB,$F3
Frame16_Frame16_XDispFlipX:
	db $0A,$03,$FA,$F3
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Frame0_YDisp:
	db $07,$F9,$09
Frame1_Frame1_YDisp:
	db $05,$00,$0B,$FF
Frame2_Frame2_YDisp:
	db $06,$06,$00,$00
Frame3_Frame3_YDisp:
	db $05,$00,$FE
Frame4_Frame4_YDisp:
	db $08,$02,$FD,$02,$01
Frame5_Frame5_YDisp:
	db $08,$02,$FC,$F8,$03
Frame6_Frame6_YDisp:
	db $07,$02,$FC,$F8,$08
Frame7_Frame7_YDisp:
	db $08,$04,$FD,$05,$F8
Frame8_Frame8_YDisp:
	db $05,$FE,$0E,$01
Frame9_Frame9_YDisp:
	db $04,$FF,$0D,$FF
Frame10_Frame10_YDisp:
	db $0A,$05,$00,$06
Frame11_Frame11_YDisp:
	db $07,$06,$01,$05
Frame12_Frame12_YDisp:
	db $02,$05,$01,$04
Frame13_Frame13_YDisp:
	db $00,$07,$03,$05
Frame14_Frame14_YDisp:
	db $FE,$05,$04,$04
Frame15_Frame15_YDisp:
	db $06,$07,$05,$08
Frame16_Frame16_YDisp:
	db $05,$04,$08,$0C
Frame0_Frame0_YDispFlipX:
	db $07,$F9,$09
Frame1_Frame1_YDispFlipX:
	db $05,$00,$0B,$FF
Frame2_Frame2_YDispFlipX:
	db $06,$06,$00,$00
Frame3_Frame3_YDispFlipX:
	db $05,$00,$FE
Frame4_Frame4_YDispFlipX:
	db $08,$02,$FD,$02,$01
Frame5_Frame5_YDispFlipX:
	db $08,$02,$FC,$F8,$03
Frame6_Frame6_YDispFlipX:
	db $07,$02,$FC,$F8,$08
Frame7_Frame7_YDispFlipX:
	db $08,$04,$FD,$05,$F8
Frame8_Frame8_YDispFlipX:
	db $05,$FE,$0E,$01
Frame9_Frame9_YDispFlipX:
	db $04,$FF,$0D,$FF
Frame10_Frame10_YDispFlipX:
	db $0A,$05,$00,$06
Frame11_Frame11_YDispFlipX:
	db $07,$06,$01,$05
Frame12_Frame12_YDispFlipX:
	db $02,$05,$01,$04
Frame13_Frame13_YDispFlipX:
	db $00,$07,$03,$05
Frame14_Frame14_YDispFlipX:
	db $FE,$05,$04,$04
Frame15_Frame15_YDispFlipX:
	db $06,$07,$05,$08
Frame16_Frame16_YDispFlipX:
	db $05,$04,$08,$0C
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Frame0_Sizes:
	db $00,$02,$02
Frame1_Frame1_Sizes:
	db $02,$02,$00,$02
Frame2_Frame2_Sizes:
	db $02,$02,$00,$02
Frame3_Frame3_Sizes:
	db $02,$02,$02
Frame4_Frame4_Sizes:
	db $00,$02,$00,$02,$00
Frame5_Frame5_Sizes:
	db $00,$02,$00,$02,$02
Frame6_Frame6_Sizes:
	db $00,$02,$00,$02,$02
Frame7_Frame7_Sizes:
	db $00,$02,$00,$02,$02
Frame8_Frame8_Sizes:
	db $02,$02,$00,$02
Frame9_Frame9_Sizes:
	db $02,$02,$00,$02
Frame10_Frame10_Sizes:
	db $00,$02,$02,$00
Frame11_Frame11_Sizes:
	db $00,$02,$02,$00
Frame12_Frame12_Sizes:
	db $00,$02,$02,$00
Frame13_Frame13_Sizes:
	db $00,$02,$02,$00
Frame14_Frame14_Sizes:
	db $00,$02,$02,$00
Frame15_Frame15_Sizes:
	db $02,$02,$00,$02
Frame16_Frame16_Sizes:
	db $02,$00,$02,$00
Frame0_Frame0_SizesFlipX:
	db $00,$02,$02
Frame1_Frame1_SizesFlipX:
	db $02,$02,$00,$02
Frame2_Frame2_SizesFlipX:
	db $02,$02,$00,$02
Frame3_Frame3_SizesFlipX:
	db $02,$02,$02
Frame4_Frame4_SizesFlipX:
	db $00,$02,$00,$02,$00
Frame5_Frame5_SizesFlipX:
	db $00,$02,$00,$02,$02
Frame6_Frame6_SizesFlipX:
	db $00,$02,$00,$02,$02
Frame7_Frame7_SizesFlipX:
	db $00,$02,$00,$02,$02
Frame8_Frame8_SizesFlipX:
	db $02,$02,$00,$02
Frame9_Frame9_SizesFlipX:
	db $02,$02,$00,$02
Frame10_Frame10_SizesFlipX:
	db $00,$02,$02,$00
Frame11_Frame11_SizesFlipX:
	db $00,$02,$02,$00
Frame12_Frame12_SizesFlipX:
	db $00,$02,$02,$00
Frame13_Frame13_SizesFlipX:
	db $00,$02,$02,$00
Frame14_Frame14_SizesFlipX:
	db $00,$02,$02,$00
Frame15_Frame15_SizesFlipX:
	db $02,$02,$00,$02
Frame16_Frame16_SizesFlipX:
	db $02,$00,$02,$00
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

ChangeAnimationFromStart_walk:
	STZ !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_flip:
	LDA #$01
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_death:
	LDA #$02
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_damage:
	LDA #$03
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

	LDA !AnimationIndex,x
	BNE +
	LDA !WalkSpeed,x
	BRA ++
+
	LDA Times,y
++
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
	dw $0008,$000A,$000B,$0002

AnimationLastTransition:
	dw $0000,$0009,$000A,$0001

AnimationIndexer:
	dw $0000,$0008,$0012,$001D

Frames:
	
Animation0_walk_Frames:
	db $01,$02,$03,$04,$05,$06,$07,$08
Animation1_flip_Frames:
	db $01,$02,$03,$04,$05,$00,$00,$06,$07,$08
Animation2_damage_Frames:
	db $09,$0A,$0B,$0C,$0D,$0E,$0D,$0C,$0B,$0A,$09
Animation3_death_Frames:
	db $0F,$10

Times:
	
Animation0_walk_Times:
	db $04,$04,$04,$04,$04,$04,$04,$04
Animation1_flip_Times:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Animation2_damage_Times:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Animation3_death_Times:
	db $0C,$04

Flips:
	
Animation0_walk_Flips:
	db $00,$00,$00,$00,$00,$00,$00,$00
Animation1_flip_Flips:
	db $00,$00,$00,$00,$00,$00,$01,$01,$01,$01
Animation2_damage_Flips:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
Animation3_death_Flips:
	db $00,$00

;>End Animations Section

;Don't Delete or write another >Section Hitbox Interaction or >End Section
;All code between >Section Hitboxes Interaction and >End Hitboxes Interaction Section will be changed by Dyzen : Sprite Maker
;>Section Hitboxes Interaction
InteractMarioSprite:
	LDA !State,x
	CMP #$02
	BCC +
	RTS
+
	LDA !FlashTimer,x
	BEQ +
	RTS
+
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
    dw $0000,$0002,$0004,$0006,$0008,$000A,$000D,$0010,$0013,$0015,$0016,$0017,$0018,$0019,$001A,$001B
	dw $001C
	dw $001D,$001F,$0021,$0023,$0025,$0027,$002A,$002D,$0030,$0032,$0033,$0034,$0035,$0036,$0037,$0038
	dw $0039

FrameHitBoxes:
    db $00,$FF
	db $01,$FF
	db $02,$FF
	db $03,$FF
	db $04,$FF
	db $05,$06,$FF
	db $07,$08,$FF
	db $09,$0A,$FF
	db $0B,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	
	db $0C,$FF
	db $0D,$FF
	db $0E,$FF
	db $0F,$FF
	db $10,$FF
	db $11,$12,$FF
	db $13,$14,$FF
	db $15,$16,$FF
	db $17,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	

HitboxesStart:
    dw $0000,$0006,$000C,$0012,$0018,$001E,$0024,$002A,$0030,$0036,$003C,$0042,$0048,$004E,$0054,$005A
	dw $0060,$0066,$006C,$0072,$0078,$007E,$0084,$008A

Hitboxes:
    db $01,$03,$00,$0E,$0F,$00
	db $01,$FB,$07,$1F,$09,$00
	db $01,$FB,$07,$1D,$0A,$00
	db $01,$FB,$06,$21,$0B,$00
	db $01,$FB,$04,$1F,$0C,$00
	db $01,$06,$FD,$10,$13,$00
	db $01,$FC,$03,$1A,$0D,$00
	db $01,$07,$FE,$10,$12,$00
	db $01,$FC,$04,$1B,$0C,$00
	db $01,$06,$00,$13,$10,$00
	db $01,$FB,$04,$1E,$0C,$00
	db $01,$FB,$05,$20,$0C,$00
	db $01,$FF,$00,$0E,$0F,$00
	db $01,$F6,$07,$1F,$09,$00
	db $01,$F8,$07,$1D,$0A,$00
	db $01,$F4,$06,$21,$0B,$00
	db $01,$F6,$04,$1F,$0C,$00
	db $01,$FA,$FD,$10,$13,$00
	db $01,$FA,$03,$1A,$0D,$00
	db $01,$F9,$FE,$10,$12,$00
	db $01,$F9,$04,$1B,$0C,$00
	db $01,$F7,$00,$13,$10,$00
	db $01,$F7,$04,$1E,$0C,$00
	db $01,$F5,$05,$20,$0C,$00
	

;This routine will be executed when mario interact with a standar hitbox.
;It will be excecuted if $0E is 1 after execute Interaction routine
DefaultAction:
	JSR NormalInteraction
RTS
    
;>End Hitboxes Interaction Section
NormalInteraction:
	LDA $1490|!addr	;if player is using the star
	BEQ +			;kill the sprite
	%Star()
	RTS
+

	LDA !PlayerYSpeed	;\
	;SEC					;|Get relative speed between player and the sprite, if it is negative then damage the player
	;SBC !SpriteYSpeed,x	;/
	BMI +++				;other wise check the position of the player

	STZ !ScratchD
	LDA !Scratch3
	STA !ScratchC		;Loads height of the player hitbox on Scratch C

	LDA !Scratch9
	XBA
	LDA !Scratch1		;Loads player hitbox Y position 
	REP #$20
	CLC
	ADC !ScratchC		;A =Player hitbox Y position + hitbox height = Bottom of the hitbox
	SEC 
	SBC #$0008
	STA !ScratchC		;!Scratch C = Bottom of player hitbox - 8 (to detects a range)
	SEP #$20

	LDA !ScratchB		;A = top of Sprite hitbox 
	XBA
	LDA !Scratch5
	REP #$20
	CMP !ScratchC		;compare Top of the sprite hitbox with the Bottom of player hitbox - 8 (to detects a range)
	BCC +++				;If the top of the sprite hitbox is on a position Higher than bottom of player hitbox then do spin jump


	PHA					;\
	LDA !ScratchC		;|
	SEC					;|
	SBC $01,s			;|
	ADC #$0008			;|Moves the player to the top of the sprite hitbox
	STA !ScratchC		;|
	PLA					;|
						;|
	LDA !PlayerY		;|
	SEC					;|
	SBC !ScratchC		;|
	STA !PlayerY		;|
						;|
	SEP #$20			;/

	JSL $01AB99|!rom	;Display White Star					
	JSL $01AA33|!rom	;Do the player boost its Y Speed	

	JSR JumpSound

	LDA !Hitpoints,x
	BEQ +

	DEC A
	STA !Hitpoints,x
	JSR StartDamage
	LDA #$28
	STA $1DFC|!addr
	LDA !XSpeed,x
	CLC
	ADC #$08
	STA !XSpeed,x
	CMP #$40
	BCC ++
	LDA #$40
	STA !XSpeed,x
++
	JSR SetWalkAnimationSpeed
	RTS

+
	JSR StartDead

	RTS					;Return
+++
	SEP #$20

	;###########################################################################
	;Here you can add code that happend when the player is damaged by the sprite
	;##########################################################################

	PHX

	LDA $187A|!addr		;if the player is not riding yoshi then damage the player
	BEQ +				;otherwise dismount yoshi
	JSR FindYoshi
	BCC +
	JSR DismountYoshi
	PLX
RTS
+
	JSL $00F5B7|!rom
	PLX
RTS

JumpSound:
    PHY                      
    LDA $1697|!addr              
    CLC                      
    ADC !SpriteMiscTable13,x            
    INC $1697|!addr                
    TAY                      
    INY                      
    CPY.B #$08                
    BCS +          
    LDA Return01A61D,y      
    STA $1DF9|!addr               ; / Play sound effect
+
    TYA                      
    CMP #$08                
    BCC +          
    LDA #$08                
+
    JSL $02ACE5|!rom      
    PLY                      
    RTS                       ; Return
 
Return01A61D:
    RTS                       ; Return
 
 
DATA_01A61E:
    db $13,$14,$15,$16,$17,$18,$19 
;>End Hitboxes Interaction Section

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