;Constant
!MinRespawnTime = $10
!MaxRespawnTime = $40
!MaxSpawnTime = $80
!MaxSpawn = $0A
	
;Variables
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

!Variables = !PaletteFreeRAM+$180

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
!Scratch54 = $54

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

!DynamicRoutine = read3(!Routines+0)
!Reserve16x16NormalSpriteOf30FPS = read3(!Routines+3)
!Reserve16x16NormalSpriteOf60FPS = read3(!Routines+6)
!Reserve32x16NormalSpriteOf30FPS = read3(!Routines+9)
!Reserve32x16NormalSpriteOf60FPS = read3(!Routines+12)
!Reserve32x32NormalSpriteOf30FPS = read3(!Routines+15)
!Reserve32x32NormalSpriteOf60FPS = read3(!Routines+18)
!Reserve48x48NormalSpriteOf30FPS = read3(!Routines+21)
!Reserve48x48NormalSpriteOf60FPS = read3(!Routines+24)
!Reserve16x16ClusterSpriteOf30FPS = read3(!Routines+27)
!Reserve16x16ClusterSpriteOf60FPS = read3(!Routines+30)
!Reserve32x16ClusterSpriteOf30FPS = read3(!Routines+33)
!Reserve32x16ClusterSpriteOf60FPS = read3(!Routines+36)
!Reserve32x32ClusterSpriteOf30FPS = read3(!Routines+39)
!Reserve32x32ClusterSpriteOf60FPS = read3(!Routines+42)
!Reserve48x48ClusterSpriteOf30FPS = read3(!Routines+45)
!Reserve48x48ClusterSpriteOf60FPS = read3(!Routines+48)
!SendSignal16x16Normal = read3(!Routines+51)
!SendSignal32x16Normal = read3(!Routines+54)
!SendSignal32x32Normal = read3(!Routines+57)
!SendSignal48x48Normal = read3(!Routines+60)
!SendSignal16x16Cluster = read3(!Routines+63)
!SendSignal32x16Cluster = read3(!Routines+66)
!SendSignal32x32Cluster = read3(!Routines+69)
!SendSignal48x48Cluster = read3(!Routines+72)
!SendSignal16x16Extended = read3(!Routines+75)
!SendSignal32x16Extended = read3(!Routines+78)
!SendSignal32x32Extended = read3(!Routines+81)
!SendSignal48x48Extended = read3(!Routines+84)
!SendSignal16x16OW = read3(!Routines+87)
!SendSignal32x16OW = read3(!Routines+90)
!SendSignal32x32OW = read3(!Routines+93)
!SendSignal48x48OW = read3(!Routines+96)

;Call
!FrameIndex = $45
!BNK = $46
!GFXPointer = $47
!ResourceOffset = $4A
!ResourceSize = $4D
!Lines = $50

macro DynamicRoutine(SignalRoutine, TransferFrame, FrameIndex, LastFrameIndex, VRAMDisp, VRAMSlot, BNK, Lines, GFXPointer, ResourceOffset, ResourceSize)
	JSL <SignalRoutine>					;Send Signal to Dynamic Z to avoid be overrited for other dynamic sprite
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
	LDA <FrameIndex>,x					;\
	CMP <LastFrameIndex>,x				;|If the frame didnt change, then don't reupload graphics
	BNE ?+								;/
RTS
?+
    STA <LastFrameIndex>,x				;Updates last frame
    STA $02
    STZ $01
    STZ $03

    LDA	<VRAMDisp>,x			;|
	TAY 								;|Obtain VRAM displacement to know where 
	LDA <VRAMSlot>,y					    ;|The graphics will be loaded
	STA $00								;|$00 = VRAM displacement; it is 16bits

    LDA <BNK>
    STA !BNK

    LDA #<Lines>
    STA !Lines

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

    PHX
    JSL !DynamicRoutine
    PLX
endmacro


;######################################
;############## Defines ###############
;######################################

!Started = !ClusterMiscTable1
!FrameIndex = !ClusterMiscTable2
!AnimationTimer = !ClusterMiscTable3
!AnimationIndex = !ClusterMiscTable4
!AnimationFrameIndex = !ClusterMiscTable5
!LocalFlip = !ClusterMiscTable6
!GlobalFlip = !ClusterMiscTable7
!LastFrameIndex = !ClusterMiscTable9
!Properties = !PaletteFreeRAM+$8E0
!CurrentRespawnTime = !Properties-$14
!CurrentSpawnTime = !CurrentRespawnTime-$14
!SpawnCounter = !CurrentSpawnTime-$14

!LastOAM200Slot = $1869|!addr

;######################################
;########## Main Routine ##############
;######################################
print "INIT ",pc
print "MAIN ",pc
Main:
    PHB
    PHK
    PLB
    JSR SpriteCode
    PLB
RTL

;######################################
;########### Init Routine #############
;######################################
StartRoutine:
	LDA #$00
	STA !CurrentRespawnTime,x
	STA !SpawnCounter,x

	LDA !Properties,x
	AND #$10
	BNE +

	LDA #$FF
	STA !LastFrameIndex,x
	LDA #!MaxRespawnTime
	STA !CurrentSpawnTime,x

	JSR InitWrapperChangeAnimationFromStart

	LDA !Properties,x
	AND #$E0
	STA !TransferFrameClusterSprite,x
    ;Here you can write your Init Code
	JSL !Reserve32x16ClusterSpriteOf30FPS
	BCS ++
	STZ !ClusterNumber,x
	RTS
++
	JSL !SendSignal32x16Cluster
    ;This will be excecuted when the sprite is spawned 
+
RTS

;>Routine: SpriteCode
;>Description: This routine excecute the logic of the sprite
;>RoutineLength: Short
Return:
RTS
SpriteCode:
	LDA !Started,x
	BNE +
	JSR StartRoutine
	LDA #$01
	STA !Started,x
RTS
+
	LDA !Properties,x
	AND #$10
	BNE +

	JSR DynamicRoutine

+
    JSR GraphicRoutine                  ;Calls the graphic routine and updates sprite graphics

    ;Here you can put code that will be excecuted each frame even if the sprite is locked

	LDA !LockAnimationFlag				    
	BNE Return			                    ;if locked animation return.

    ;JSR InteractMarioSprite
    ;After this routine, if the sprite interact with mario, Carry is Set.
	JSR Move
	JSR Spawn
    ;Here you can write your sprite code routine
    ;This will be excecuted once per frame excepts when 
    ;the animation is locked or when sprite status is not #$08

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw
    
    RTS

;>EndRoutine

;######################################
;######## Sub Routine Space ###########
;######################################

Spawn:

	LDA !Properties,x
	AND #$10
	BEQ +
RTS
+
	LDA !SpawnCounter,x
	CMP #!MaxSpawn
	BCC +
RTS
+
	LDA !CurrentSpawnTime,x
	BEQ +

	DEC A 
	STA !CurrentSpawnTime,x
RTS
+
	JSL $01ACF9|!rom
	LDA $148D|!addr
	AND #!MaxSpawnTime-1
	STA !CurrentSpawnTime,x
	
	STZ !Scratch0
	STZ !Scratch1

	LDA !ClusterNumber,x
	%SpawnCluster()
	BCS +
	RTS
+
	LDA !SpawnCounter,x
	INC A
	STA !SpawnCounter,x
	
	LDA !VRAMDispClusterSprite,x
	PHX
	TYX
	STA !VRAMDispClusterSprite,x
	PHY
	JSR StartSetting
	PLY
	PLX

	PHX
	LDA !Properties,x
	TYX
	AND #$EF
	ORA #$10
	STA !Properties,x
	PLX

	LDA #$00
	STA !Started,y

	LDA !FrameIndex,x
	STA !FrameIndex,y

	LDA !AnimationFrameIndex,x
	STA !AnimationFrameIndex,y

	LDA !AnimationTimer,x
	STA !AnimationTimer,y

	LDA !AnimationIndex,x
	STA !AnimationIndex,y

RTS

StartSetting:
	JSL $01ACF9|!rom
	LDA $148D|!addr
	AND #$01
	STA !GlobalFlip,x
	ASL 
	TAY

	JSL $01ACF9|!rom

	REP #$20

	LDA $148D|!addr
	AND #$00FF
	CLC
	ADC !Layer1Y
	STA !Scratch2

	LDA !Layer1X
	CLC
	ADC StartedXDisp,y
	STA !Scratch0
	SEP #$20

	LDA !Scratch0
	STA !ClusterXLow,x
	LDA !Scratch1
	STA !ClusterXHigh,x

	LDA !Scratch2
	STA !ClusterYLow,x
	LDA !Scratch3
	STA !ClusterYHigh,x
RTS

StartedXDisp:
	dw $FFF1,$0101
;Here you can write routines or tables
Move:

	LDA !CurrentRespawnTime,x
	BEQ +

	DEC A
	STA !CurrentRespawnTime,x
	BEQ ++
RTS
+
	LDA !Scratch52
	BNE .move

	JSL $01ACF9|!rom
	LDA $148D|!addr
	AND #!MaxRespawnTime-1
	CLC
	ADC #!MinRespawnTime
	STA !CurrentRespawnTime,x
RTS

++
	JSR StartSetting
.move
+
	STZ !Scratch1
	LDA #$01
	STA !Scratch0
	LDA !GlobalFlip,x
	BEQ +
	LDA #$FF
	STA !Scratch0
	STA !Scratch1
+
	LDA !ClusterXHigh,x
	XBA
	LDA !ClusterXLow,x
	REP #$20
	CLC
	ADC !Scratch0
	STA !Scratch0
	SEP #$20

	LDA !Scratch0
	STA !ClusterXLow,x
	LDA !Scratch1
	STA !ClusterXHigh,x

RTS

;>Section Dynamic
;######################################
;########## Animation Space ###########
;######################################
ResourceOffset:
Blue0_ResourceOffset:
	dw $0000,$0060
Blue1_ResourceOffset:
	dw $00A0,$0100
Blue2_ResourceOffset:
	dw $0140,$01A0
Blue3_ResourceOffset:
	dw $01E0,$0240
Blue4_ResourceOffset:
	dw $0280,$02E0
Blue5_ResourceOffset:
	dw $0320,$0380
Blue6_ResourceOffset:
	dw $03C0,$0420
Blue7_ResourceOffset:
	dw $0460,$04C0
Frame0_ResourceOffset:
	dw $0500,$0560
Frame1_ResourceOffset:
	dw $05A0,$0600
Frame2_ResourceOffset:
	dw $0640,$06A0
Frame3_ResourceOffset:
	dw $06E0,$0740
Frame4_ResourceOffset:
	dw $0780,$07E0
Frame5_ResourceOffset:
	dw $0820,$0880
Frame6_ResourceOffset:
	dw $08C0,$0920
Frame7_ResourceOffset:
	dw $0960,$09C0


ResourceSize:
Blue0_ResourceSize:
	dw $0060,$0040
Blue1_ResourceSize:
	dw $0060,$0040
Blue2_ResourceSize:
	dw $0060,$0040
Blue3_ResourceSize:
	dw $0060,$0040
Blue4_ResourceSize:
	dw $0060,$0040
Blue5_ResourceSize:
	dw $0060,$0040
Blue6_ResourceSize:
	dw $0060,$0040
Blue7_ResourceSize:
	dw $0060,$0040
Frame0_ResourceSize:
	dw $0060,$0040
Frame1_ResourceSize:
	dw $0060,$0040
Frame2_ResourceSize:
	dw $0060,$0040
Frame3_ResourceSize:
	dw $0060,$0040
Frame4_ResourceSize:
	dw $0060,$0040
Frame5_ResourceSize:
	dw $0060,$0040
Frame6_ResourceSize:
	dw $0060,$0040
Frame7_ResourceSize:
	dw $0060,$0040

VRAMSlot32x16:
	db $00,$02,$04,$06
	db $10,$12,$14,$16
	db $20,$22,$24,$26
	db $30,$32,$34,$36
	db $40,$42,$44,$46
	db $50,$52,$54,$56

DynamicRoutine:
	PHB
	PLA
	STA $53
	%DynamicRoutine(!SendSignal32x16Cluster, !TransferFrameClusterSprite, !FrameIndex, !LastFrameIndex, !VRAMDispClusterSprite, VRAMSlot32x16, $53, $02, GFXPointer, ResourceOffset, ResourceSize)
RTS

GFXPointer:
dw resource

;fill this with the name of your exgfx (replace "resource.bin" for the name of your graphic.bin)
resource:
incbin "cluster\SmallFish.bin"
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
IgnoreList: 
      ; 00              04              08              0C            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00
	  ; 10              14              18              1C              
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
	  ; 20              24              28              2C            
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
	  ; 30              34              38              3C            
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
      ; 40              44              48              4C            
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
	  ; 50              54              58              5C            
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
	  ; 60              64              68              6C            
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
	  ; 70              74              78              7C            
	db $01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00,$00,$00
      ; 80              84              88              8C            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	  ; 90              94              98              9C            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	  ; A0              A4              A8              AC            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	  ; B0              B4              B8              BC            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
      ; C0              C4              C8              CC            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	  ; D0              D4              D8              DC            
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	  ; E0              E4              E8              EC            
	db $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	  ; F0              F4
	db $00,$00,$00,$00,$00
	
FindOAM:
-	
	LDA IgnoreList,y
	BNE ++
	LDA !TileYPosition200,y
	CMP #$F0
	BEQ +
++

	DEY
	DEY
	DEY
	DEY

	CPY #$F4
	BCC -

	CLC
RTS
+	
	SEC
RTS

CMPTab1:
	dw $00F9,$00F1

CheckPosition:

	LDX !Scratch4C
	STZ !Scratch4A
	STZ !Scratch4B
	
	REP #$20
	LDA !Scratch4E	;XDisp
	CLC
	ADC !Scratch45	;X + XDisp
	SEC
	SBC !Layer1X	;X + XDisp - LX
	CMP #$0100
	BCC +

	PHA 
	LDA #$0001
	STA !Scratch4A
	PLA

+
	CMP #$FFF0
	BCS +
	PHA
	LDA !Scratch4A
	BEQ ++

	PLA
	SEP #$20

	LDA #$F0
	STA !TileYPosition200,y
	CLC
RTS
++
	PLA
+
	SEP #$20
	STA !TileXPosition200,y

	REP #$20
	LDA !Scratch50	;YDisp
	CLC
	ADC !Scratch47	;Y + YDisp
	SEC
	SBC !Layer1Y	;Y + YDisp - LY
	SEP #$20
	STA !TileYPosition200,y
	SEC
RTS

SelectStartSlot:

	LDY #$00F4
	LDA !TileYPosition200,y
	CMP #$F0
	BEQ +

	LDY !LastOAM200Slot
+

RTS

;>Routine: GraphicRoutine
;>Description: Updates tiles on the oam map
;results will be visible the next frame.
;>RoutineLength: Short
OAMOffset:
	db $40,$44,$48,$4C,$60,$64,$68,$6C
	db $80,$84,$88,$8C,$A0,$A4,$A8,$AC
	db $C0,$C4,$C8,$CC,$E0,$E4,$E8,$EC
GraphicRoutine:

	LDA !LastFrameIndex,x
	CMP #$FF
	BNE +
RTS
+
	LDA !CurrentRespawnTime,x
	BEQ +
RTS
+

	LDA !ClusterXLow,x
	STA !Scratch45
	LDA !ClusterXHigh,x
	STA !Scratch46

	LDA !ClusterYLow,x
	STA !Scratch47
	LDA !ClusterYHigh,x
	STA !Scratch48

	LDA !Properties,x
	AND #$0E
	STA !ScratchD
	PHX
	LDA	!VRAMDispClusterSprite,x
	TAX  
	LDA OAMOffset,x
	STA !ScratchE
	PLX

    STZ !Scratch3                       ;$02 = Free Slot but in 16bits
    STY !Scratch2


    STZ !Scratch5
    LDA !GlobalFlip,x   
    ASL
    STA !Scratch4                       ;$04 = Global Flip but in 16bits


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

	LDA #$0001
    STA !Scratch8

    LDA FramesEndPosition,x
    STA !Scratch4                       ;$04 = End Position + A value used to select a frame version that is flipped

    LDA FramesStartPosition,x           
    TAX                                 ;X = Start Position
    SEP #$20                            ;A 8bits mode

	STZ !Scratch52

	JSR SelectStartSlot
	JSR FindOAM
	BCC .return
-
    LDA Tiles,x
	CLC
	ADC !ScratchE
    STA !TileCode200,y                     ;Set the Tile code of the tile Y

    LDA Properties,x
	AND #$F1
	ORA !ScratchD
    STA !TileProperty200,y                 ;Set the Tile property of the tile Y

	LDA Sizes,x

	PHX
	STA !Scratch4C
	STZ !Scratch4D

	STZ !Scratch4F
	LDA XDisplacements,x
	STA !Scratch4E
	BPL +
	LDA #$FF
	STA !Scratch4F
+

	STZ !Scratch51
	LDA YDisplacements,x
	STA !Scratch50
	BPL +
	LDA #$FF
	STA !Scratch51
+
	JSR CheckPosition
	BCC ++

	LDA #$01
	STA !Scratch52

	PLX

    PHY
	REP #$20                                 
    TYA
    LSR
    LSR
    TAY                                 ;Y = Y/4 because size directions are not continuous to map 200 and 300
	SEP #$20
    LDA Sizes,x
	CLC
	ADC !Scratch4A
    STA !TileSize420,y                  ;Set the Tile size of the tile Y
    PLY
	BRA +
++
	PLX
	BRA ++
+
    DEY
	DEY
	DEY
	DEY
++
	JSR FindOAM
	BCC .return

    DEX
    BMI .return
    CPX !Scratch4                       ;if X < start position or is negative then return
    BCS -                               ;else loop

.return
	STY !LastOAM200Slot
    SEP #$10
    PLX                                 ;Restore X
    
RTS
;>EndRoutine

;All words that starts with '@' and finish with '.' will be replaced by Dyzen

;>Table: FramesFlippers
;>Description: Values used to add values to FramesStartPosition and FramesEndPosition
;To use a flipped version of the frames.
;>ValuesSize: 16
FramesFlippers:
    dw $0000,$0020
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0001,$0003,$0005,$0007,$0009,$000B,$000D,$000F,$0011,$0013,$0015,$0017,$0019,$001B,$001D,$001F
	dw $0021,$0023,$0025,$0027,$0029,$002B,$002D,$002F,$0031,$0033,$0035,$0037,$0039,$003B,$003D,$003F
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0002,$0004,$0006,$0008,$000A,$000C,$000E,$0010,$0012,$0014,$0016,$0018,$001A,$001C,$001E
	dw $0020,$0022,$0024,$0026,$0028,$002A,$002C,$002E,$0030,$0032,$0034,$0036,$0038,$003A,$003C,$003E
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Blue0_Tiles:
	db $02,$00
Frame1_Blue1_Tiles:
	db $02,$00
Frame2_Blue2_Tiles:
	db $02,$00
Frame3_Blue3_Tiles:
	db $02,$00
Frame4_Blue4_Tiles:
	db $02,$00
Frame5_Blue5_Tiles:
	db $02,$00
Frame6_Blue6_Tiles:
	db $02,$00
Frame7_Blue7_Tiles:
	db $02,$00
Frame8_Frame0_Tiles:
	db $02,$00
Frame9_Frame1_Tiles:
	db $02,$00
Frame10_Frame2_Tiles:
	db $02,$00
Frame11_Frame3_Tiles:
	db $02,$00
Frame12_Frame4_Tiles:
	db $02,$00
Frame13_Frame5_Tiles:
	db $02,$00
Frame14_Frame6_Tiles:
	db $02,$00
Frame15_Frame7_Tiles:
	db $02,$00
Frame0_Blue0_TilesFlipX:
	db $02,$00
Frame1_Blue1_TilesFlipX:
	db $02,$00
Frame2_Blue2_TilesFlipX:
	db $02,$00
Frame3_Blue3_TilesFlipX:
	db $02,$00
Frame4_Blue4_TilesFlipX:
	db $02,$00
Frame5_Blue5_TilesFlipX:
	db $02,$00
Frame6_Blue6_TilesFlipX:
	db $02,$00
Frame7_Blue7_TilesFlipX:
	db $02,$00
Frame8_Frame0_TilesFlipX:
	db $02,$00
Frame9_Frame1_TilesFlipX:
	db $02,$00
Frame10_Frame2_TilesFlipX:
	db $02,$00
Frame11_Frame3_TilesFlipX:
	db $02,$00
Frame12_Frame4_TilesFlipX:
	db $02,$00
Frame13_Frame5_TilesFlipX:
	db $02,$00
Frame14_Frame6_TilesFlipX:
	db $02,$00
Frame15_Frame7_TilesFlipX:
	db $02,$00
;>EndTable


;>Table: Properties
;>Description: Properties of each tile of each frame
;>ValuesSize: 8
Properties:
    
Frame0_Blue0_Properties:
	db $2D,$2D
Frame1_Blue1_Properties:
	db $2D,$2D
Frame2_Blue2_Properties:
	db $2D,$2D
Frame3_Blue3_Properties:
	db $2D,$2D
Frame4_Blue4_Properties:
	db $2D,$2D
Frame5_Blue5_Properties:
	db $2D,$2D
Frame6_Blue6_Properties:
	db $2D,$2D
Frame7_Blue7_Properties:
	db $2D,$2D
Frame8_Frame0_Properties:
	db $2F,$2F
Frame9_Frame1_Properties:
	db $2F,$2F
Frame10_Frame2_Properties:
	db $2F,$2F
Frame11_Frame3_Properties:
	db $2F,$2F
Frame12_Frame4_Properties:
	db $2F,$2F
Frame13_Frame5_Properties:
	db $2F,$2F
Frame14_Frame6_Properties:
	db $2F,$2F
Frame15_Frame7_Properties:
	db $2F,$2F
Frame0_Blue0_PropertiesFlipX:
	db $6D,$6D
Frame1_Blue1_PropertiesFlipX:
	db $6D,$6D
Frame2_Blue2_PropertiesFlipX:
	db $6D,$6D
Frame3_Blue3_PropertiesFlipX:
	db $6D,$6D
Frame4_Blue4_PropertiesFlipX:
	db $6D,$6D
Frame5_Blue5_PropertiesFlipX:
	db $6D,$6D
Frame6_Blue6_PropertiesFlipX:
	db $6D,$6D
Frame7_Blue7_PropertiesFlipX:
	db $6D,$6D
Frame8_Frame0_PropertiesFlipX:
	db $6F,$6F
Frame9_Frame1_PropertiesFlipX:
	db $6F,$6F
Frame10_Frame2_PropertiesFlipX:
	db $6F,$6F
Frame11_Frame3_PropertiesFlipX:
	db $6F,$6F
Frame12_Frame4_PropertiesFlipX:
	db $6F,$6F
Frame13_Frame5_PropertiesFlipX:
	db $6F,$6F
Frame14_Frame6_PropertiesFlipX:
	db $6F,$6F
Frame15_Frame7_PropertiesFlipX:
	db $6F,$6F
;>EndTable
;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Blue0_XDisp:
	db $FF,$01
Frame1_Blue1_XDisp:
	db $FC,$01
Frame2_Blue2_XDisp:
	db $FD,$01
Frame3_Blue3_XDisp:
	db $FD,$01
Frame4_Blue4_XDisp:
	db $FD,$01
Frame5_Blue5_XDisp:
	db $FC,$01
Frame6_Blue6_XDisp:
	db $FD,$01
Frame7_Blue7_XDisp:
	db $FD,$01
Frame8_Frame0_XDisp:
	db $FD,$00
Frame9_Frame1_XDisp:
	db $FB,$00
Frame10_Frame2_XDisp:
	db $FB,$00
Frame11_Frame3_XDisp:
	db $FC,$00
Frame12_Frame4_XDisp:
	db $FC,$00
Frame13_Frame5_XDisp:
	db $FB,$00
Frame14_Frame6_XDisp:
	db $FB,$00
Frame15_Frame7_XDisp:
	db $FD,$00
Frame0_Blue0_XDispFlipX:
	db $09,$FF
Frame1_Blue1_XDispFlipX:
	db $0C,$FF
Frame2_Blue2_XDispFlipX:
	db $0B,$FF
Frame3_Blue3_XDispFlipX:
	db $0B,$FF
Frame4_Blue4_XDispFlipX:
	db $0B,$FF
Frame5_Blue5_XDispFlipX:
	db $0C,$FF
Frame6_Blue6_XDispFlipX:
	db $0B,$FF
Frame7_Blue7_XDispFlipX:
	db $0B,$FF
Frame8_Frame0_XDispFlipX:
	db $0B,$00
Frame9_Frame1_XDispFlipX:
	db $0D,$00
Frame10_Frame2_XDispFlipX:
	db $0D,$00
Frame11_Frame3_XDispFlipX:
	db $0C,$00
Frame12_Frame4_XDispFlipX:
	db $0C,$00
Frame13_Frame5_XDispFlipX:
	db $0D,$00
Frame14_Frame6_XDispFlipX:
	db $0D,$00
Frame15_Frame7_XDispFlipX:
	db $0B,$00
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Blue0_YDisp:
	db $04,$04
Frame1_Blue1_YDisp:
	db $06,$04
Frame2_Blue2_YDisp:
	db $05,$03
Frame3_Blue3_YDisp:
	db $05,$03
Frame4_Blue4_YDisp:
	db $06,$05
Frame5_Blue5_YDisp:
	db $06,$04
Frame6_Blue6_YDisp:
	db $07,$05
Frame7_Blue7_YDisp:
	db $07,$05
Frame8_Frame0_YDisp:
	db $06,$05
Frame9_Frame1_YDisp:
	db $06,$05
Frame10_Frame2_YDisp:
	db $05,$04
Frame11_Frame3_YDisp:
	db $06,$04
Frame12_Frame4_YDisp:
	db $08,$05
Frame13_Frame5_YDisp:
	db $07,$05
Frame14_Frame6_YDisp:
	db $08,$06
Frame15_Frame7_YDisp:
	db $08,$06
Frame0_Blue0_YDispFlipX:
	db $04,$04
Frame1_Blue1_YDispFlipX:
	db $06,$04
Frame2_Blue2_YDispFlipX:
	db $05,$03
Frame3_Blue3_YDispFlipX:
	db $05,$03
Frame4_Blue4_YDispFlipX:
	db $06,$05
Frame5_Blue5_YDispFlipX:
	db $06,$04
Frame6_Blue6_YDispFlipX:
	db $07,$05
Frame7_Blue7_YDispFlipX:
	db $07,$05
Frame8_Frame0_YDispFlipX:
	db $06,$05
Frame9_Frame1_YDispFlipX:
	db $06,$05
Frame10_Frame2_YDispFlipX:
	db $05,$04
Frame11_Frame3_YDispFlipX:
	db $06,$04
Frame12_Frame4_YDispFlipX:
	db $08,$05
Frame13_Frame5_YDispFlipX:
	db $07,$05
Frame14_Frame6_YDispFlipX:
	db $08,$06
Frame15_Frame7_YDispFlipX:
	db $08,$06
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Blue0_Sizes:
	db $00,$02
Frame1_Blue1_Sizes:
	db $00,$02
Frame2_Blue2_Sizes:
	db $00,$02
Frame3_Blue3_Sizes:
	db $00,$02
Frame4_Blue4_Sizes:
	db $00,$02
Frame5_Blue5_Sizes:
	db $00,$02
Frame6_Blue6_Sizes:
	db $00,$02
Frame7_Blue7_Sizes:
	db $00,$02
Frame8_Frame0_Sizes:
	db $00,$02
Frame9_Frame1_Sizes:
	db $00,$02
Frame10_Frame2_Sizes:
	db $00,$02
Frame11_Frame3_Sizes:
	db $00,$02
Frame12_Frame4_Sizes:
	db $00,$02
Frame13_Frame5_Sizes:
	db $00,$02
Frame14_Frame6_Sizes:
	db $00,$02
Frame15_Frame7_Sizes:
	db $00,$02
Frame0_Blue0_SizesFlipX:
	db $00,$02
Frame1_Blue1_SizesFlipX:
	db $00,$02
Frame2_Blue2_SizesFlipX:
	db $00,$02
Frame3_Blue3_SizesFlipX:
	db $00,$02
Frame4_Blue4_SizesFlipX:
	db $00,$02
Frame5_Blue5_SizesFlipX:
	db $00,$02
Frame6_Blue6_SizesFlipX:
	db $00,$02
Frame7_Blue7_SizesFlipX:
	db $00,$02
Frame8_Frame0_SizesFlipX:
	db $00,$02
Frame9_Frame1_SizesFlipX:
	db $00,$02
Frame10_Frame2_SizesFlipX:
	db $00,$02
Frame11_Frame3_SizesFlipX:
	db $00,$02
Frame12_Frame4_SizesFlipX:
	db $00,$02
Frame13_Frame5_SizesFlipX:
	db $00,$02
Frame14_Frame6_SizesFlipX:
	db $00,$02
Frame15_Frame7_SizesFlipX:
	db $00,$02
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
	LDA !Properties,x
	AND #$01
	STA !AnimationIndex,x
	JSR ChangeAnimationFromStart
RTS

ChangeAnimationFromStart_blue:
	STZ !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_orange:
	LDA #$01
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

	LDA !Scratch2
	STA !AnimationFrameIndex,x

	SEP #$10						;X/Y of 8 bits
	LDX !Scratch4					;X = sprite index in 8 bits
RTS
	

;>Routine: AnimationRoutine
;>Description: Decides what will be the next frame.
;>RoutineLength: Short
AnimationRoutine:
	LDA !TransferFrameClusterSprite,x
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

	LDA !Scratch2
	STA !AnimationFrameIndex,x

	SEP #$10						;X/Y of 8 bits
	LDX !Scratch4					;X = sprite index in 8 bits
RTS
;>EndRoutine

;All words that starts with '>' and finish with '.' will be replaced by Dyzen

AnimationLenght:
	dw $0008,$0008

AnimationLastTransition:
	dw $0000,$0000

AnimationIndexer:
	dw $0000,$0008

Frames:
	
Animation0_blue_Frames:
	db $00,$01,$02,$03,$04,$05,$06,$07
Animation1_orange_Frames:
	db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F

Times:
	
Animation0_blue_Times:
	db $04,$04,$04,$04,$04,$04,$04,$04
Animation1_orange_Times:
	db $04,$04,$04,$04,$04,$04,$04,$04
;>End Animations Section

;Don't Delete or write another >Section Hitbox Interaction or >End Section
;All code between >Section Hitboxes Interaction and >End Hitboxes Interaction Section will be changed by Dyzen : Sprite Maker
;>Section Hitboxes Interaction
;>End Hitboxes Interaction Section