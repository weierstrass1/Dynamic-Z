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
	!FreeRams = $7FB700

if read1($00FFD6) == $15
	sfxrom
	!dp = $6000
	!addr = !dp
	!gsu = 1
elseif read1($00FFD5) == $23
	sa1rom
	!MaxSprites = $16
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
	!FreeRams = $418800
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
!MovementType = !ExtraByte1					;0 = Constant
											;1 = R*Sin(RT2*t)
											;2 = R*Cos(RT2*t)
											;3 = R*Sin(RT*Sin(RT2*t))
											;4 = R*Cos(RT*Sin(RT2*t))
											;5 = t*Sin(RT2*t)
											;6 = t*Cos(RT2*t)
											;7 = t + R*Sin(RT2*t)
											;8 = t + R*Cos(RT2*t)
											;9 = t + R*Sin(RT1*Sin(RT2*t))
											;A = t + R*Cos(RT1*Sin(RT2*t))
											;B = t + t*Sin(RT2*t)
											;C = t + t*Cos(RT2*t)
											;D = LineGuided
!AngularSpeed = !ExtraByte2			
!AngleLow = !ExtraByte3
!AngleHigh = !ExtraByte4
!State = !SpriteMiscTable8
!InitialXLow = !SpriteMiscTable9
!InitialXHigh = !SpriteMiscTable10		
!RatioX = !SpriteMiscTable11		
!RatioY = !SpriteMiscTable12	
!RatioT1X = !SpriteMiscTable13
!RatioT1Y = !SpriteMiscTable14
!HitPoints = !SpriteMiscTable15			
!InitialYLow = !FreeRams
!InitialYHigh = !InitialYLow+!MaxSprites
!RatioT2X = !InitialYHigh+!MaxSprites	
!RatioT2Y = !RatioT2X+!MaxSprites
!PhaseLow = !RatioT2Y+!MaxSprites
!PhaseHigh = !PhaseLow+!MaxSprites

;######################################
;########### Init Routine #############
;######################################
print "INIT ",pc
	LDA #$00
	STA !GlobalFlip,x
	JSL InitWrapperChangeAnimationFromStart
	LDA #$FF
	STA !LastFrameIndex,x
    ;Here you can write your Init Code
    ;This will be excecuted when the sprite is spawned 
	JSL !Reserve48x48NormalSpriteOf30FPS
	BCS +
	RTL
+
	JSL !SendSignal48x48Normal

	JSR RecievesExtraBytes
	LDA #$00
	STA !AngleLow,x
	STA !AngleHigh,x

	LDA !SpriteXHigh,x
	STA !InitialXHigh,x
	LDA !SpriteXLow,x
	STA !InitialXLow,x
	
	LDA !SpriteYHigh,x
	STA !InitialYHigh,x
	LDA !SpriteYLow,x
	STA !InitialYLow,x
RTL

RecievesExtraBytes:
	LDA !ExtraByte1,x
	STA $00
	LDA !ExtraByte2,x
	STA $01
	LDA !ExtraByte3,x
	STA $02
	LDY #$00
	LDA [$00],y
	STA !MovementType,x	;EB1
	INY
	LDA	[$00],y
	STA !AngularSpeed,x ;EB2
	INY
	LDA	[$00],y
	STA !PhaseLow,x		;EB3
	STA !AngleLow,x
	INY
	LDA	[$00],y
	STA !PhaseHigh,x	;EB4
	STA !AngleHigh,x
	INY
	LDA	[$00],y
	STA !RatioX,x		;EB5
	INY
	LDA	[$00],y
	STA !RatioY,x		;EB6
	INY
	LDA	[$00],y
	STA !RatioT1X,x		;EB7
	INY
	LDA	[$00],y
	STA !RatioT1Y,x		;EB8
	INY
	LDA	[$00],y
	STA !RatioT2X,x		;EB9
	INY
	LDA	[$00],y
	STA !RatioT2Y,x		;EBA
	INY
	LDA	[$00],y
	STA !HitPoints,x	;EBB	

RTS

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
	dw Damage
	dw Dead

StartIdle:
RTS

Idle:
	LDX !SpriteIndex
	JSR UpdateAngle
	JSR MovementX
	JSR MovementY
RTS

StartFlip:
RTS

Flip:
	LDX !SpriteIndex
	JSR UpdateAngle
	JSR MovementX
	JSR MovementY
RTS


StartDamage:
RTS

Damage:
	LDX !SpriteIndex
RTS


StartDead:
RTS

Dead:
	LDX !SpriteIndex
RTS

UpdateAngle:
	STZ !Scratch1
	LDA !AngularSpeed,x
	STA !Scratch0
	LDA !AngleHigh,x
	XBA
	LDA !AngleLow,x
	REP #$20
	CLC
	ADC !Scratch0
	STA !Scratch2
	SEP #$20
	LDA !Scratch2
	STA !AngleLow,x
	LDA !Scratch3
	STA !AngleHigh,x

RTS

MovementX:
	LDA !MovementType,x
	AND #$0F
	ASL
	TAY

	REP #$20
	LDA MovementXType,y
	STA !Scratch0
	SEP #$20

	LDX #$00
	JSR ($0000|!dp,x)
RTS

MovementXType:
	dw Static
	dw XRSint
	dw XRCost
	dw XRSinRT1SinRT2t
	dw XRCosRT1SinRT2t
	dw XtSint
	dw XtCost
	dw XtplusRSint
	dw XtplusRCost
	dw XtplusRSinRT1SinRT2t
	dw XtplusRCosRT1SinRT2t
	dw XtplustSint
	dw XtplustCost	
	dw XLineGuided

MovementY:
	LDA !MovementType,x
	CLC
	LSR
	LSR
	LSR
	TAY

	REP #$20
	LDA MovementYType,y
	STA !Scratch0
	SEP #$20

	LDX #$00
	JSR ($0000|!dp,x)
RTS

MovementYType:
	dw Static
	dw YRSint
	dw YRCost
	dw YRSinRT1SinRT2t
	dw YRCosRT1SinRT2t
	dw YtSint
	dw YtCost
	dw YtplusRSint
	dw YtplusRCost
	dw YtplusRSinRT1SinRT2t
	dw YtplusRCosRT1SinRT2t
	dw YtplustSint
	dw YtplustCost	
	dw YLineGuided

Static:
	LDX !SpriteIndex
RTS
XRSint:
	LDX !SpriteIndex

	LDA !RatioT2X,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioX,x
	STA !Scratch2

	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialXHigh,x
	XBA
	LDA !InitialXLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteXLow,x
	LDA !Scratch4
	STA !SpriteXHigh,x
RTS
XRCost:
	LDX !SpriteIndex

	LDA !RatioT2X,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioX,x
	STA !Scratch2

	JSL Cos

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialXHigh,x
	XBA
	LDA !InitialXLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteXLow,x
	LDA !Scratch4
	STA !SpriteXHigh,x
RTS
XRSinRT1SinRT2t:
	LDX !SpriteIndex

	LDA !RatioT2X,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioT1X,x
	STA !Scratch2

	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !PhaseHigh,x
	XBA
	LDA !PhaseLow,x
	REP #$20
	ADC !Scratch3
	ADC !Scratch3
	ADC !Scratch3
	STA !Scratch0
	SEP #$20

	LDA !RatioX,x
	STA !Scratch2
	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialXHigh,x
	XBA
	LDA !InitialXLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteXLow,x
	LDA !Scratch4
	STA !SpriteXHigh,x
RTS
XRCosRT1SinRT2t:
	LDX !SpriteIndex

	LDA !RatioT2X,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioT1X,x
	STA !Scratch2

	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !PhaseHigh,x
	XBA
	LDA !PhaseLow,x
	REP #$20
	CLC
	ADC !Scratch3
	ADC !Scratch3
	ADC !Scratch3
	STA !Scratch0
	SEP #$20

	LDA !RatioX,x
	STA !Scratch2
	JSL Cos

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialXHigh,x
	XBA
	LDA !InitialXLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteXLow,x
	LDA !Scratch4
	STA !SpriteXHigh,x
RTS
XtSint:
	LDX !SpriteIndex
RTS
XtCost:
	LDX !SpriteIndex
RTS
XtplusRSint:
	LDX !SpriteIndex
RTS
XtplusRCost:
	LDX !SpriteIndex
RTS
XtplusRSinRT1SinRT2t:
	LDX !SpriteIndex
RTS
XtplusRCosRT1SinRT2t:
	LDX !SpriteIndex
RTS
XtplustSint:
	LDX !SpriteIndex
RTS
XtplustCost:
	LDX !SpriteIndex
RTS
XLineGuided:
	LDX !SpriteIndex
RTS

YRSint:
	LDX !SpriteIndex

	LDA !RatioT2Y,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioY,x
	STA !Scratch2

	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialYHigh,x
	XBA
	LDA !InitialYLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteYLow,x
	LDA !Scratch4
	STA !SpriteYHigh,x
RTS
YRCost:
	LDX !SpriteIndex

	LDA !RatioT2Y,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioY,x
	STA !Scratch2

	JSL Cos

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialYHigh,x
	XBA
	LDA !InitialYLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteYLow,x
	LDA !Scratch4
	STA !SpriteYHigh,x
RTS
YRSinRT1SinRT2t:
	LDX !SpriteIndex

	LDA !RatioT2Y,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioT1Y,x
	STA !Scratch2

	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !PhaseHigh,x
	XBA
	LDA !PhaseLow,x
	REP #$20
	CLC
	ADC !Scratch3
	ADC !Scratch3
	ADC !Scratch3
	STA !Scratch0
	SEP #$20

	LDA !RatioY,x
	STA !Scratch2
	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialYHigh,x
	XBA
	LDA !InitialYLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteYLow,x
	LDA !Scratch4
	STA !SpriteYHigh,x
RTS
YRCosRT1SinRT2t:
	LDX !SpriteIndex

	LDA !RatioT2Y,x
	STA !Scratch8
	JSR AngleDegrees

	LDA !RatioT1Y,x
	STA !Scratch2

	JSL Sin

	STZ !Scratch4
	LDA !Scratch3
	
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !PhaseHigh,x
	XBA
	LDA !PhaseLow,x
	REP #$20
	CLC
	ADC !Scratch3
	ADC !Scratch3
	ADC !Scratch3
	STA !Scratch0
	SEP #$20

	LDA !RatioY,x
	STA !Scratch2
	JSL Cos

	STZ !Scratch4
	LDA !Scratch3
	BPL +
	LDA #$FF
	STA !Scratch4
+
	LDA !InitialYHigh,x
	XBA
	LDA !InitialYLow,x
	REP #$20
	CLC
	ADC !Scratch3
	STA !Scratch3
	SEP #$20
	LDA !Scratch3
	STA !SpriteYLow,x
	LDA !Scratch4
	STA !SpriteYHigh,x
RTS
YtSint:
	LDX !SpriteIndex
RTS
YtCost:
	LDX !SpriteIndex
RTS
YtplusRSint:
	LDX !SpriteIndex
RTS
YtplusRCost:
	LDX !SpriteIndex
RTS
YtplusRSinRT1SinRT2t:
	LDX !SpriteIndex
RTS
YtplusRCosRT1SinRT2t:
	LDX !SpriteIndex
RTS
YtplustSint:
	LDX !SpriteIndex
RTS
YtplustCost:
	LDX !SpriteIndex
RTS
YLineGuided:
	LDX !SpriteIndex
RTS

AngleDegrees:
	STA !Scratch8
	LDA !AngleHigh,x
	STA !Scratch1
	LDA !AngleLow,x
	STA !Scratch0

	JSR Multiply

RTS

Multiply:
	REP #$20
	LDA !Scratch0
	LDY !Scratch8
-
	BMI +
	BEQ +
	ASL
	DEY
	BRA -
+
	STA !Scratch0
	SEP #$20
RTS

;########################################
;Input:
;   $00 = Angle (a number between 0 and $2CF) must be of 16 bits
;   $02 = Ratio (a number between 0 and FF) must be of 8 bits
;Output:
;   $03 = Sin(Angle/2)*Ratio
Sin:
    PHX
    PHB
    PHK
    PLB
	JSR CalculateMod720
    REP #$10                ;Y of 16 bits
    LDY $00
    LDA SinTable,y          ;A = Sin($00/2)*127
    JSR SinCosExcecute
    PLB
    PLX
    RTL

Cos:
    PHX
    PHB
    PHK
    PLB
	JSR CalculateMod720
    REP #$10                ;Y of 16 bits
    LDY $00
    LDA CosTable,y          ;A = Sin($00/2)*127
    JSR SinCosExcecute
    PLB
    PLX
    RTL
 
SinCosExcecute:
    SEP #$10                ;Y of 8 bits
    BPL +                   ;if negative then do A = -A
    PHA                     ;s = A
    LDA #$00                
    SEC
    SBC $01,s               ;A = -A
    PLY                     ;
    LDY #$01                ;Y = 1
    BRA ++
+
    LDY #$00                ;Y = 0
++
if !sa1
    STZ $2250
    STA $2251
    STZ $2252
    LDA $02
    INC
    STA $2253
    STZ $2254
    NOP
    BRA $00
 
    LDA #$01
    STA $2250
    REP #$20
    LDA $2306               ;A = Result of Sin($00/2)*127*Ratio
    STA $2251
    SEP #$20
    LDA #$7F
    STA $2253
    STZ $2254
 
    NOP
    BRA $00
    LDA $2306
else
    STA $4202
    LDA $02
    CLC
    ADC #$01
    STA $4203               ;A*Ratio = Sin($00/2)*127*Ratio
 
    NOP #$03                ;Wait Mul
    REP #$20
    LDA $4216               ;A = Result of Sin($00/2)*127*Ratio
    STA $4204
    SEP #$20
 
    LDA #$7F
    STA $4206               ;
 
    NOP #$08                ;Wait Division
    LDA $4214               ;A = Sin($00/2)*Ratio
endif
    CPY #$00
    BEQ +
    PHA
    LDA #$00
    SEC
    SBC $01,s
    PLY                     ;If at the start Sin($00/2)*127 was negative then now is A=-A
+
    STA $03
 
    RTS
 
SinTable:
	db $00,$01,$02,$03,$04,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$11
	db $12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1D,$1E,$1F,$20,$21,$22
	db $23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2E,$2F,$30,$31,$32,$33
	db $34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$40,$41,$42
	db $43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4C,$4D,$4E,$4F,$50,$51
	db $52,$52,$53,$54,$55,$56,$57,$57,$58,$59,$5A,$5B,$5B,$5C,$5D,$5E
	db $5E,$5F,$60,$61,$61,$62,$63,$63,$64,$65,$65,$66,$67,$67,$68,$69
	db $69,$6A,$6B,$6B,$6C,$6C,$6D,$6D,$6E,$6F,$6F,$70,$70,$71,$71,$72
	db $72,$73,$73,$74,$74,$74,$75,$75,$76,$76,$77,$77,$77,$78,$78,$78
	db $79,$79,$79,$7A,$7A,$7A,$7B,$7B,$7B,$7B,$7C,$7C,$7C,$7C,$7D,$7D
	db $7D,$7D,$7D,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7F,$7F,$7F,$7F,$7F,$7F
	db $7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7E
	db $7E,$7E,$7E,$7E,$7E,$7E,$7D,$7D,$7D,$7D,$7D,$7C,$7C,$7C,$7C,$7B
	db $7B,$7B,$7B,$7A,$7A,$7A,$79,$79,$79,$78,$78,$78,$77,$77,$77,$76
	db $76,$75,$75,$74,$74,$74,$73,$73,$72,$72,$71,$71,$70,$70,$6F,$6F
	db $6E,$6D,$6D,$6C,$6C,$6B,$6B,$6A,$69,$69,$68,$67,$67,$66,$65,$65
	db $64,$63,$63,$62,$61,$61,$60,$5F,$5E,$5E,$5D,$5C,$5B,$5B,$5A,$59
	db $58,$57,$57,$56,$55,$54,$53,$52,$52,$51,$50,$4F,$4E,$4D,$4C,$4C
	db $4B,$4A,$49,$48,$47,$46,$45,$44,$43,$42,$41,$40,$40,$3F,$3E,$3D
	db $3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30,$2F,$2E,$2C
	db $2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21,$20,$1F,$1E,$1D,$1B
	db $1A,$19,$18,$17,$16,$15,$14,$13,$12,$11,$0F,$0E,$0D,$0C,$0B,$0A
	db $09,$08,$07,$06,$04,$03,$02,$01,$00,$FF,$FE,$FD,$FC,$FA,$F9,$F8
	db $F7,$F6,$F5,$F4,$F3,$F2,$F1,$EF,$EE,$ED,$EC,$EB,$EA,$E9,$E8,$E7
	db $E6,$E5,$E3,$E2,$E1,$E0,$DF,$DE,$DD,$DC,$DB,$DA,$D9,$D8,$D7,$D6
	db $D5,$D4,$D2,$D1,$D0,$CF,$CE,$CD,$CC,$CB,$CA,$C9,$C8,$C7,$C6,$C5
	db $C4,$C3,$C2,$C1,$C0,$C0,$BF,$BE,$BD,$BC,$BB,$BA,$B9,$B8,$B7,$B6
	db $B5,$B4,$B4,$B3,$B2,$B1,$B0,$AF,$AE,$AE,$AD,$AC,$AB,$AA,$A9,$A9
	db $A8,$A7,$A6,$A5,$A5,$A4,$A3,$A2,$A2,$A1,$A0,$9F,$9F,$9E,$9D,$9D
	db $9C,$9B,$9B,$9A,$99,$99,$98,$97,$97,$96,$95,$95,$94,$94,$93,$93
	db $92,$91,$91,$90,$90,$8F,$8F,$8E,$8E,$8D,$8D,$8C,$8C,$8C,$8B,$8B
	db $8A,$8A,$89,$89,$89,$88,$88,$88,$87,$87,$87,$86,$86,$86,$85,$85
	db $85,$85,$84,$84,$84,$84,$83,$83,$83,$83,$83,$82,$82,$82,$82,$82
	db $82,$82,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81
	db $81,$81,$81,$81,$81,$81,$81,$82,$82,$82,$82,$82,$82,$82,$83,$83
	db $83,$83,$83,$84,$84,$84,$84,$85,$85,$85,$85,$86,$86,$86,$87,$87
	db $87,$88,$88,$88,$89,$89,$89,$8A,$8A,$8B,$8B,$8C,$8C,$8C,$8D,$8D
	db $8E,$8E,$8F,$8F,$90,$90,$91,$91,$92,$93,$93,$94,$94,$95,$95,$96
	db $97,$97,$98,$99,$99,$9A,$9B,$9B,$9C,$9D,$9D,$9E,$9F,$9F,$A0,$A1
	db $A2,$A2,$A3,$A4,$A5,$A5,$A6,$A7,$A8,$A9,$A9,$AA,$AB,$AC,$AD,$AE
	db $AE,$AF,$B0,$B1,$B2,$B3,$B4,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC
	db $BD,$BE,$BF,$C0,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB
	db $CC,$CD,$CE,$CF,$D0,$D1,$D2,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC
	db $DD,$DE,$DF,$E0,$E1,$E2,$E3,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED
	db $EE,$EF,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FC,$FD,$FE,$FF

;Here you can write routines or tables

CosTable:
	db $7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7E,$7E,$7E,$7E,$7E
	db $7E,$7E,$7D,$7D,$7D,$7D,$7D,$7C,$7C,$7C,$7C,$7B,$7B,$7B,$7B,$7A
	db $7A,$7A,$79,$79,$79,$78,$78,$78,$77,$77,$77,$76,$76,$75,$75,$74
	db $74,$74,$73,$73,$72,$72,$71,$71,$70,$70,$6F,$6F,$6E,$6D,$6D,$6C
	db $6C,$6B,$6B,$6A,$69,$69,$68,$67,$67,$66,$65,$65,$64,$63,$63,$62
	db $61,$61,$60,$5F,$5E,$5E,$5D,$5C,$5B,$5B,$5A,$59,$58,$57,$57,$56
	db $55,$54,$53,$52,$52,$51,$50,$4F,$4E,$4D,$4C,$4C,$4B,$4A,$49,$48
	db $47,$46,$45,$44,$43,$42,$41,$40,$40,$3F,$3E,$3D,$3C,$3B,$3A,$39
	db $38,$37,$36,$35,$34,$33,$32,$31,$30,$2F,$2E,$2C,$2B,$2A,$29,$28
	db $27,$26,$25,$24,$23,$22,$21,$20,$1F,$1E,$1D,$1B,$1A,$19,$18,$17
	db $16,$15,$14,$13,$12,$11,$0F,$0E,$0D,$0C,$0B,$0A,$09,$08,$07,$06
	db $04,$03,$02,$01,$00,$FF,$FE,$FD,$FC,$FA,$F9,$F8,$F7,$F6,$F5,$F4
	db $F3,$F2,$F1,$EF,$EE,$ED,$EC,$EB,$EA,$E9,$E8,$E7,$E6,$E5,$E3,$E2
	db $E1,$E0,$DF,$DE,$DD,$DC,$DB,$DA,$D9,$D8,$D7,$D6,$D5,$D4,$D2,$D1
	db $D0,$CF,$CE,$CD,$CC,$CB,$CA,$C9,$C8,$C7,$C6,$C5,$C4,$C3,$C2,$C1
	db $C0,$C0,$BF,$BE,$BD,$BC,$BB,$BA,$B9,$B8,$B7,$B6,$B5,$B4,$B4,$B3
	db $B2,$B1,$B0,$AF,$AE,$AE,$AD,$AC,$AB,$AA,$A9,$A9,$A8,$A7,$A6,$A5
	db $A5,$A4,$A3,$A2,$A2,$A1,$A0,$9F,$9F,$9E,$9D,$9D,$9C,$9B,$9B,$9A
	db $99,$99,$98,$97,$97,$96,$95,$95,$94,$94,$93,$93,$92,$91,$91,$90
	db $90,$8F,$8F,$8E,$8E,$8D,$8D,$8C,$8C,$8C,$8B,$8B,$8A,$8A,$89,$89
	db $89,$88,$88,$88,$87,$87,$87,$86,$86,$86,$85,$85,$85,$85,$84,$84
	db $84,$84,$83,$83,$83,$83,$83,$82,$82,$82,$82,$82,$82,$82,$81,$81
	db $81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81,$81
	db $81,$81,$81,$82,$82,$82,$82,$82,$82,$82,$83,$83,$83,$83,$83,$84
	db $84,$84,$84,$85,$85,$85,$85,$86,$86,$86,$87,$87,$87,$88,$88,$88
	db $89,$89,$89,$8A,$8A,$8B,$8B,$8C,$8C,$8C,$8D,$8D,$8E,$8E,$8F,$8F
	db $90,$90,$91,$91,$92,$93,$93,$94,$94,$95,$95,$96,$97,$97,$98,$99
	db $99,$9A,$9B,$9B,$9C,$9D,$9D,$9E,$9F,$9F,$A0,$A1,$A2,$A2,$A3,$A4
	db $A5,$A5,$A6,$A7,$A8,$A9,$A9,$AA,$AB,$AC,$AD,$AE,$AE,$AF,$B0,$B1
	db $B2,$B3,$B4,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$C0
	db $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF
	db $D0,$D1,$D2,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$E0
	db $E1,$E2,$E3,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F1,$F2
	db $F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FC,$FD,$FE,$FF,$00,$01,$02,$03
	db $04,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$11,$12,$13,$14,$15
	db $16,$17,$18,$19,$1A,$1B,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26
	db $27,$28,$29,$2A,$2B,$2C,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37
	db $38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$40,$41,$42,$43,$44,$45,$46
	db $47,$48,$49,$4A,$4B,$4C,$4C,$4D,$4E,$4F,$50,$51,$52,$52,$53,$54
	db $55,$56,$57,$57,$58,$59,$5A,$5B,$5B,$5C,$5D,$5E,$5E,$5F,$60,$61
	db $61,$62,$63,$63,$64,$65,$65,$66,$67,$67,$68,$69,$69,$6A,$6B,$6B
	db $6C,$6C,$6D,$6D,$6E,$6F,$6F,$70,$70,$71,$71,$72,$72,$73,$73,$74
	db $74,$74,$75,$75,$76,$76,$77,$77,$77,$78,$78,$78,$79,$79,$79,$7A
	db $7A,$7A,$7B,$7B,$7B,$7B,$7C,$7C,$7C,$7C,$7D,$7D,$7D,$7D,$7D,$7E
	db $7E,$7E,$7E,$7E,$7E,$7E,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F

CalculateMod720:
	REP #$20
	LDA !Scratch0
	STA !Scratch4
	LDA #$02D0
	STA !Scratch6
	SEP #$20

	JSR MathDiv

	LDA !Scratch6
	STA !Scratch0

	LDA !Scratch7
	STA !Scratch1

RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 16bit / 16bit Division
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Arguments
; $00-$01 : Dividend
; $02-$03 : Divisor
; Return values
; $00-$01 : Quotient
; $02-$03 : Remainder
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathDiv:	
	REP #$20
	ASL !Scratch4
	LDY #$0F
	LDA.w #$0000
-		
	ROL A
	CMP !Scratch6
	BCC +
	SBC !Scratch6
+		
	ROL !Scratch4
	DEY
	BPL -
	STA !Scratch6
	SEP #$20
RTS

;>Section Dynamic
;######################################
;########## Animation Space ###########
;######################################
ResourceOffset:
Frame0_ResourceOffset:
	dw $0000,$0160
Frame1_ResourceOffset:
	dw $02A0,$0460
Frame2_ResourceOffset:
	dw $0600,$07E0
Frame3_ResourceOffset:
	dw $09A0,$0BA0
Frame4_ResourceOffset:
	dw $0D60,$0F00
Frame5_ResourceOffset:
	dw $1080,$1280
Frame6_ResourceOffset:
	dw $1440,$1600
Frame7_ResourceOffset:
	dw $1780,$1960
Frame8_ResourceOffset:
	dw $1B40,$1D00
Frame9_ResourceOffset:
	dw $1EC0,$2020
Frame10_ResourceOffset:
	dw $2160,$2300
Frame11_ResourceOffset:
	dw $2480,$2640
Frame12_ResourceOffset:
	dw $2800,$29E0
Frame13_ResourceOffset:
	dw $2B60,$2D20
Frame14_ResourceOffset:
	dw $2EE0,$3060


ResourceSize:
Frame0_ResourceSize:
	dw $0160,$0140
Frame1_ResourceSize:
	dw $01C0,$01A0
Frame2_ResourceSize:
	dw $01E0,$01C0
Frame3_ResourceSize:
	dw $03C0,$0000
Frame4_ResourceSize:
	dw $01A0,$0180
Frame5_ResourceSize:
	dw $03C0,$0000
Frame6_ResourceSize:
	dw $01C0,$0180
Frame7_ResourceSize:
	dw $01E0,$01E0
Frame8_ResourceSize:
	dw $01C0,$01C0
Frame9_ResourceSize:
	dw $0160,$0140
Frame10_ResourceSize:
	dw $01A0,$0180
Frame11_ResourceSize:
	dw $01C0,$01C0
Frame12_ResourceSize:
	dw $01E0,$0180
Frame13_ResourceSize:
	dw $01C0,$01C0
Frame14_ResourceSize:
	dw $0180,$0180

DynamicRoutine:
	PHB
	PLA
	STA $53
	%DynamicRoutine(1, !SendSignal48x48Normal, !TransferFrameNormalSprite, !FrameIndex, !LastFrameIndex, !VRAMDispNormalSprite, $53, !DynamicRoutine48x48, GFXPointer, ResourceOffset, ResourceSize)
RTS

GFXPointer:
dw resource

;fill this with the name of your exgfx (replace "resource.bin" for the name of your graphic.bin)
resource:
incbin "sprites\Zinger.bin"

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
	db $C0,$E0
GraphicRoutine:

	LDA !LastFrameIndex,x
	CMP #$FF
	BNE +
	RTS
+

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

	LDA #$2F

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
    dw $0005,$0007,$0007,$0008,$0006,$0008,$0007,$0007,$0006,$0005,$0006,$0006,$0008,$0006,$0005
	dw $0005,$0007,$0007,$0008,$0006,$0008,$0007,$0007,$0006,$0005,$0006,$0006,$0008,$0006,$0005
;>EndTable


;>Table: FramesFlippers
;>Description: Values used to add values to FramesStartPosition and FramesEndPosition
;To use a flipped version of the frames.
;>ValuesSize: 16
FramesFlippers:
    dw $0000,$001E
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0005,$000D,$0015,$001E,$0025,$002E,$0036,$003E,$0045,$004B,$0052,$0059,$0062,$0069,$006F
	dw $0075,$007D,$0085,$008E,$0095,$009E,$00A6,$00AE,$00B5,$00BB,$00C2,$00C9,$00D2,$00D9,$00DF
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0006,$000E,$0016,$001F,$0026,$002F,$0037,$003F,$0046,$004C,$0053,$005A,$0063,$006A
	dw $0070,$0076,$007E,$0086,$008F,$0096,$009F,$00A7,$00AF,$00B6,$00BC,$00C3,$00CA,$00D3,$00DA
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Frame0_Tiles:
	db $08,$06,$04,$02,$00,$0A
Frame1_Frame1_Tiles:
	db $0B,$0D,$09,$07,$05,$00,$03,$01
Frame2_Frame2_Tiles:
	db $0C,$0A,$08,$06,$04,$02,$00,$0E
Frame3_Frame3_Tiles:
	db $0C,$0A,$0F,$08,$06,$04,$02,$00,$0E
Frame4_Frame4_Tiles:
	db $0A,$08,$06,$04,$02,$0C,$00
Frame5_Frame5_Tiles:
	db $0C,$0F,$0A,$08,$06,$04,$02,$00,$0E
Frame6_Frame6_Tiles:
	db $0D,$0A,$08,$06,$04,$02,$00,$0C
Frame7_Frame7_Tiles:
	db $0D,$0B,$09,$07,$05,$00,$03,$01
Frame8_Frame8_Tiles:
	db $0C,$0A,$08,$06,$04,$02,$00
Frame9_Frame9_Tiles:
	db $08,$06,$0A,$04,$02,$00
Frame10_Frame10_Tiles:
	db $0A,$08,$06,$04,$02,$00,$0C
Frame11_Frame11_Tiles:
	db $0C,$0A,$08,$06,$02,$00,$04
Frame12_Frame12_Tiles:
	db $0E,$0A,$0D,$08,$0C,$06,$04,$02,$00
Frame13_Frame13_Tiles:
	db $0C,$0A,$08,$06,$04,$02,$00
Frame14_Frame14_Tiles:
	db $0A,$08,$06,$04,$02,$00
Frame0_Frame0_TilesFlipX:
	db $08,$06,$04,$02,$00,$0A
Frame1_Frame1_TilesFlipX:
	db $0B,$0D,$09,$07,$05,$00,$03,$01
Frame2_Frame2_TilesFlipX:
	db $0C,$0A,$08,$06,$04,$02,$00,$0E
Frame3_Frame3_TilesFlipX:
	db $0C,$0A,$0F,$08,$06,$04,$02,$00,$0E
Frame4_Frame4_TilesFlipX:
	db $0A,$08,$06,$04,$02,$0C,$00
Frame5_Frame5_TilesFlipX:
	db $0C,$0F,$0A,$08,$06,$04,$02,$00,$0E
Frame6_Frame6_TilesFlipX:
	db $0D,$0A,$08,$06,$04,$02,$00,$0C
Frame7_Frame7_TilesFlipX:
	db $0D,$0B,$09,$07,$05,$00,$03,$01
Frame8_Frame8_TilesFlipX:
	db $0C,$0A,$08,$06,$04,$02,$00
Frame9_Frame9_TilesFlipX:
	db $08,$06,$0A,$04,$02,$00
Frame10_Frame10_TilesFlipX:
	db $0A,$08,$06,$04,$02,$00,$0C
Frame11_Frame11_TilesFlipX:
	db $0C,$0A,$08,$06,$02,$00,$04
Frame12_Frame12_TilesFlipX:
	db $0E,$0A,$0D,$08,$0C,$06,$04,$02,$00
Frame13_Frame13_TilesFlipX:
	db $0C,$0A,$08,$06,$04,$02,$00
Frame14_Frame14_TilesFlipX:
	db $0A,$08,$06,$04,$02,$00
;>EndTable

;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Frame0_XDisp:
	db $E9,$F5,$F9,$05,$08,$09
Frame1_Frame1_XDisp:
	db $E8,$F6,$F6,$F6,$05,$05,$06,$0D
Frame2_Frame2_XDisp:
	db $E8,$F6,$F8,$FA,$06,$06,$08,$08
Frame3_Frame3_XDisp:
	db $E9,$F5,$F6,$F6,$FE,$FE,$08,$09,$0E
Frame4_Frame4_XDisp:
	db $E9,$F6,$F9,$06,$07,$07,$09
Frame5_Frame5_XDisp:
	db $E9,$F5,$F5,$F6,$05,$05,$06,$09,$11
Frame6_Frame6_XDisp:
	db $E9,$F1,$F6,$FA,$FA,$06,$08,$0D
Frame7_Frame7_XDisp:
	db $E8,$F5,$F5,$F5,$05,$05,$06,$0D
Frame8_Frame8_XDisp:
	db $ED,$F7,$F7,$FD,$05,$05,$05
Frame9_Frame9_XDisp:
	db $F5,$FF,$FF,$01,$01,$08
Frame10_Frame10_XDisp:
	db $F7,$FB,$FB,$09,$0B,$0B,$14
Frame11_Frame11_XDisp:
	db $F5,$03,$03,$03,$0D,$0D,$13
Frame12_Frame12_XDisp:
	db $FC,$00,$03,$03,$0B,$10,$10,$13,$1D
Frame13_Frame13_XDisp:
	db $03,$08,$11,$11,$18,$20,$20
Frame14_Frame14_XDisp:
	db $04,$05,$14,$14,$20,$20
Frame0_Frame0_XDispFlipX:
	db $17,$0B,$07,$FB,$F8,$FF
Frame1_Frame1_XDispFlipX:
	db $18,$12,$0A,$0A,$FB,$FB,$FA,$F3
Frame2_Frame2_XDispFlipX:
	db $18,$0A,$08,$06,$FA,$FA,$F8,$00
Frame3_Frame3_XDispFlipX:
	db $17,$0B,$12,$0A,$02,$02,$F8,$F7,$FA
Frame4_Frame4_XDispFlipX:
	db $17,$0A,$07,$FA,$F9,$01,$F7
Frame5_Frame5_XDispFlipX:
	db $17,$13,$0B,$0A,$FB,$FB,$FA,$F7,$F7
Frame6_Frame6_XDispFlipX:
	db $1F,$0F,$0A,$06,$06,$FA,$F8,$FB
Frame7_Frame7_XDispFlipX:
	db $18,$0B,$0B,$0B,$FB,$FB,$FA,$F3
Frame8_Frame8_XDispFlipX:
	db $13,$09,$09,$03,$FB,$FB,$FB
Frame9_Frame9_XDispFlipX:
	db $0B,$01,$09,$FF,$FF,$F8
Frame10_Frame10_XDispFlipX:
	db $09,$05,$05,$F7,$F5,$F5,$F4
Frame11_Frame11_XDispFlipX:
	db $0B,$FD,$FD,$FD,$F3,$F3,$ED
Frame12_Frame12_XDispFlipX:
	db $0C,$00,$05,$FD,$FD,$F0,$F0,$ED,$E3
Frame13_Frame13_XDispFlipX:
	db $FD,$F8,$EF,$EF,$E8,$E0,$E0
Frame14_Frame14_XDispFlipX:
	db $FC,$FB,$EC,$EC,$E0,$E0
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Frame0_YDisp:
	db $F7,$06,$F9,$09,$F9,$F6
Frame1_Frame1_YDisp:
	db $01,$EE,$F6,$06,$EF,$FF,$09,$FF
Frame2_Frame2_YDisp:
	db $01,$06,$F9,$E9,$F6,$06,$FF,$12
Frame3_Frame3_YDisp:
	db $F4,$EE,$FE,$06,$EF,$FF,$0A,$FF,$F8
Frame4_Frame4_YDisp:
	db $F7,$05,$FA,$0A,$F5,$02,$FF
Frame5_Frame5_YDisp:
	db $FF,$EF,$F6,$06,$EF,$FF,$0A,$00,$F8
Frame6_Frame6_YDisp:
	db $FF,$FF,$06,$E9,$F9,$09,$F9,$F1
Frame7_Frame7_YDisp:
	db $FF,$EE,$FE,$07,$EF,$FF,$09,$FF
Frame8_Frame8_YDisp:
	db $01,$EB,$FB,$09,$EC,$FC,$06
Frame9_Frame9_YDisp:
	db $03,$EB,$FB,$FB,$0A,$03
Frame10_Frame10_YDisp:
	db $00,$EB,$FB,$08,$EC,$FC,$0C
Frame11_Frame11_YDisp:
	db $FA,$E9,$F9,$09,$FF,$03,$EF
Frame12_Frame12_YDisp:
	db $01,$F4,$04,$0B,$03,$E6,$F6,$06,$F9
Frame13_Frame13_YDisp:
	db $FC,$0C,$F0,$00,$07,$EA,$FA
Frame14_Frame14_YDisp:
	db $FE,$0E,$F8,$06,$FA,$0A
Frame0_Frame0_YDispFlipX:
	db $F7,$06,$F9,$09,$F9,$F6
Frame1_Frame1_YDispFlipX:
	db $01,$EE,$F6,$06,$EF,$FF,$09,$FF
Frame2_Frame2_YDispFlipX:
	db $01,$06,$F9,$E9,$F6,$06,$FF,$12
Frame3_Frame3_YDispFlipX:
	db $F4,$EE,$FE,$06,$EF,$FF,$0A,$FF,$F8
Frame4_Frame4_YDispFlipX:
	db $F7,$05,$FA,$0A,$F5,$02,$FF
Frame5_Frame5_YDispFlipX:
	db $FF,$EF,$F6,$06,$EF,$FF,$0A,$00,$F8
Frame6_Frame6_YDispFlipX:
	db $FF,$FF,$06,$E9,$F9,$09,$F9,$F1
Frame7_Frame7_YDispFlipX:
	db $FF,$EE,$FE,$07,$EF,$FF,$09,$FF
Frame8_Frame8_YDispFlipX:
	db $01,$EB,$FB,$09,$EC,$FC,$06
Frame9_Frame9_YDispFlipX:
	db $03,$EB,$FB,$FB,$0A,$03
Frame10_Frame10_YDispFlipX:
	db $00,$EB,$FB,$08,$EC,$FC,$0C
Frame11_Frame11_YDispFlipX:
	db $FA,$E9,$F9,$09,$FF,$03,$EF
Frame12_Frame12_YDispFlipX:
	db $01,$F4,$04,$0B,$03,$E6,$F6,$06,$F9
Frame13_Frame13_YDispFlipX:
	db $FC,$0C,$F0,$00,$07,$EA,$FA
Frame14_Frame14_YDispFlipX:
	db $FE,$0E,$F8,$06,$FA,$0A
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Frame0_Sizes:
	db $02,$02,$02,$02,$02,$00
Frame1_Frame1_Sizes:
	db $02,$00,$02,$02,$02,$02,$02,$02
Frame2_Frame2_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$00
Frame3_Frame3_Sizes:
	db $02,$02,$00,$02,$02,$02,$02,$02,$00
Frame4_Frame4_Sizes:
	db $02,$02,$02,$02,$02,$00,$02
Frame5_Frame5_Sizes:
	db $02,$00,$02,$02,$02,$02,$02,$02,$00
Frame6_Frame6_Sizes:
	db $00,$02,$02,$02,$02,$02,$02,$00
Frame7_Frame7_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02
Frame8_Frame8_Sizes:
	db $02,$02,$02,$02,$02,$02,$02
Frame9_Frame9_Sizes:
	db $02,$02,$00,$02,$02,$02
Frame10_Frame10_Sizes:
	db $02,$02,$02,$02,$02,$02,$00
Frame11_Frame11_Sizes:
	db $02,$02,$02,$02,$02,$02,$02
Frame12_Frame12_Sizes:
	db $00,$02,$00,$02,$00,$02,$02,$02,$02
Frame13_Frame13_Sizes:
	db $02,$02,$02,$02,$02,$02,$02
Frame14_Frame14_Sizes:
	db $02,$02,$02,$02,$02,$02
Frame0_Frame0_SizesFlipX:
	db $02,$02,$02,$02,$02,$00
Frame1_Frame1_SizesFlipX:
	db $02,$00,$02,$02,$02,$02,$02,$02
Frame2_Frame2_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$00
Frame3_Frame3_SizesFlipX:
	db $02,$02,$00,$02,$02,$02,$02,$02,$00
Frame4_Frame4_SizesFlipX:
	db $02,$02,$02,$02,$02,$00,$02
Frame5_Frame5_SizesFlipX:
	db $02,$00,$02,$02,$02,$02,$02,$02,$00
Frame6_Frame6_SizesFlipX:
	db $00,$02,$02,$02,$02,$02,$02,$00
Frame7_Frame7_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02
Frame8_Frame8_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02
Frame9_Frame9_SizesFlipX:
	db $02,$02,$00,$02,$02,$02
Frame10_Frame10_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$00
Frame11_Frame11_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02
Frame12_Frame12_SizesFlipX:
	db $00,$02,$00,$02,$00,$02,$02,$02,$02
Frame13_Frame13_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02
Frame14_Frame14_SizesFlipX:
	db $02,$02,$02,$02,$02,$02
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

ChangeAnimationFromStart_fly:
	STZ !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_flip:
	LDA #$01
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_damage:
	LDA #$02
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_dead:
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
	dw $0008,$0004,$0005,$0005

AnimationLastTransition:
	dw $0000,$0003,$0004,$0004

AnimationIndexer:
	dw $0000,$0008,$000C,$0011

Frames:
	
Animation0_fly_Frames:
	db $00,$01,$02,$03,$04,$05,$06,$07
Animation1_flip_Frames:
	db $08,$09,$09,$08
Animation2_damage_Frames:
	db $0A,$0B,$0C,$0B,$0A
Animation3_dead_Frames:
	db $0A,$0B,$0C,$0D,$0E

Times:
	
Animation0_fly_Times:
	db $02,$02,$02,$02,$02,$02,$02,$02
Animation1_flip_Times:
	db $02,$02,$02,$02
Animation2_damage_Times:
	db $04,$04,$0A,$04,$04
Animation3_dead_Times:
	db $04,$04,$04,$04,$04

Flips:
	
Animation0_fly_Flips:
	db $00,$00,$00,$00,$00,$00,$00,$00
Animation1_flip_Flips:
	db $00,$00,$01,$01
Animation2_damage_Flips:
	db $00,$00,$00,$00,$00
Animation3_dead_Flips:
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
    dw $0000,$001E

FrameHitboxesIndexer:
    dw $0000,$0003,$0006,$0009,$000C,$000F,$0012,$0015,$0018,$001B,$001E,$0021,$0024,$0027,$002A
	dw $002D,$0030,$0033,$0036,$0039,$003C,$003F,$0042,$0045,$0048,$004B,$004E,$0051,$0054,$0057

FrameHitBoxes:
    db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $02,$03,$FF
	db $04,$05,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	db $00,$01,$FF
	
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $08,$09,$FF
	db $0A,$0B,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	db $06,$07,$FF
	

HitboxesStart:
    dw $0000,$0006,$000C,$0012,$0018,$001E,$0024,$002A,$0030,$0036,$003C,$0042

Hitboxes:
    db $01,$F8,$00,$1A,$0E,$00
	db $01,$05,$FD,$0C,$11,$00
	db $01,$FC,$00,$15,$0E,$00
	db $01,$05,$FD,$0A,$11,$00
	db $01,$03,$00,$0B,$0E,$00
	db $01,$05,$FD,$08,$11,$00
	db $01,$FE,$00,$1A,$0E,$00
	db $01,$FF,$FD,$0C,$11,$00
	db $01,$FF,$00,$15,$0E,$00
	db $01,$01,$FD,$0A,$11,$00
	db $01,$02,$00,$0B,$0E,$00
	db $01,$03,$FD,$08,$11,$00
	

;This routine will be executed when mario interact with a standar hitbox.
;It will be excecuted if $0E is 1 after execute Interaction routine
DefaultAction:
	JSR SpikyInteraction
RTS
    
SpikyInteraction:
    LDA $1490|!addr ;if player is using the star
    BEQ +           ;kill the sprite
    %Star()
    RTS
+
    LDA $187A|!addr ;If player is riding yoshi then skip spinjump check
    BNE +
 
    LDA $140D|!addr ;if player is doing spin jump then check if can do spin jump over the sprite; otherwise damage the player
    BEQ +++
+  
    LDA !PlayerYSpeed   ;\
    SEC                 ;|Get relative speed between player and the sprite, if it is negative then damage the player
    SBC !SpriteYSpeed,x ;/
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
 
    ;#######################################################################
    ;Here you can add code that happend when the player spin jump the sprite
    ;#######################################################################
 
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