;@SmallFish.bin
!ResourceIndex = $07
%GFXTabDef(!ResourceIndex)
%GFXDef(00)

!FreeRams = $7FB880

if !sa1
	!FreeRams = $418B80
endif

;Constant
!MinRespawnTime = $10
!MaxRespawnTime = $40
!MaxSpawnTime = $80
!MaxSpawn = $03

!YoshiTongueTile1 = $0C
!YoshiTongueTile2 = $10
!YoshiTongueTile3 = $14
!YoshiTongueTile4 = $18
!YoshiTongueTile5 = $1C
!BounceSpritesTile = $1C
!SmokeTile1 = $20
!SmokeTile2 = $24
!SmokeTile3 = $28
!SmokeTile4 = $2C
!CoinSpriteTile1 = $30
!CoinSpriteTile2 = $34
!CoinSpriteTile3 = $38
!CoinSpriteTile4 = $3C
!CoinSpriteTile5 = $40
!CoinSpriteTile6 = $44
!CoinSpriteTile7 = $48
!CoinSpriteTile8 = $4C
!MinorExtendedTile1 = $50
!MinorExtendedTile2 = $54
!MinorExtendedTile3 = $58
!MinorExtendedTile4 = $5C
!MinorExtendedTile5 = $60
!MinorExtendedTile6 = $64
!MinorExtendedTile7 = $68
!MinorExtendedTile8 = $6C
!MinorExtendedTile9 = $70
!MinorExtendedTileA = $74
!MinorExtendedTileB = $78
!MinorExtendedTileC = $7C
!ScoreSpriteTile1 = $B0
!ScoreSpriteTile2 = $B4
!ScoreSpriteTile3 = $B8
!ScoreSpriteTile4 = $BC
!ScoreSpriteTile5 = $C0
!ScoreSpriteTile6 = $C4
!ScoreSpriteTile7 = $C8
!ScoreSpriteTile8 = $CC
!ScoreSpriteTile9 = $D0
!ScoreSpriteTileA = $D4
!ScoreSpriteTileB = $D8
!ScoreSpriteTileC = $DC
!ReserveItemTile = $E0
!FireballTile1 = $F8
!FireballTile2 = $FC
!WhiteStarTile1 = $F0
!WhiteStarTile2 = $F4
!WhiteStarTile3 = $F8
!WhiteStarTile4 = $FC

macro checkTile(tile)
	if !YoshiTongueTile1 == <tile> || !YoshiTongueTile2 == <tile> || !YoshiTongueTile3 == <tile> || !YoshiTongueTile4 == <tile> || !YoshiTongueTile5 == <tile> || !BounceSpritesTile == <tile> || !SmokeTile1 == <tile> ||  !SmokeTile2 == <tile> || !SmokeTile3 == <tile> ||  !SmokeTile4 == <tile> || !CoinSpriteTile1 == <tile> || !CoinSpriteTile2 == <tile> || !CoinSpriteTile3 == <tile> || !CoinSpriteTile4 == <tile> || !CoinSpriteTile5 == <tile> || !CoinSpriteTile6 == <tile> || !CoinSpriteTile7 == <tile> || !CoinSpriteTile8 == <tile> || !MinorExtendedTile1 == <tile> || !MinorExtendedTile2 == <tile> || !MinorExtendedTile3 == <tile> || !MinorExtendedTile4 == <tile> || !MinorExtendedTile5 == <tile> || !MinorExtendedTile6 == <tile> || !MinorExtendedTile7 == <tile> || !MinorExtendedTile8 == <tile> || !MinorExtendedTile9 == <tile> || !MinorExtendedTileA == <tile> || !MinorExtendedTileB == <tile> || !MinorExtendedTileC == <tile> || !ScoreSpriteTile1 == <tile> || !ScoreSpriteTile2 == <tile> || !ScoreSpriteTile3 == <tile> || !ScoreSpriteTile4 == <tile> || !ScoreSpriteTile5 == <tile> || !ScoreSpriteTile6 == <tile> || !ScoreSpriteTile7 == <tile> || !ScoreSpriteTile8 == <tile> || !ScoreSpriteTile9 == <tile> || !ScoreSpriteTileA == <tile> || !ScoreSpriteTileB == <tile> || !ScoreSpriteTileC == <tile> || !ReserveItemTile == <tile> || !FireballTile1 == <tile> || !FireballTile2 == <tile> || !WhiteStarTile1 == <tile> || !WhiteStarTile2 == <tile> || !WhiteStarTile3 == <tile> || !WhiteStarTile4 == <tile>
		db $01
	else
		db $00
	endif
endmacro

macro checkRow(row)
	%checkTile($<row>0)
	db $00,$00,$00
	%checkTile($<row>4)
	db $00,$00,$00
	%checkTile($<row>8)
	db $00,$00,$00
	%checkTile($<row>C)
	db $00,$00,$00
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
!Properties = DZ_FreeRams
!CurrentRespawnTime = !Properties+$14
!CurrentSpawnTime = !CurrentRespawnTime+$14
!SpawnCounter = !CurrentSpawnTime+$14

!LastOAM200Slot = $0DDB|!addr


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

	LDA #$FF
	STA !LastFrameIndex,x
	LDA #!MaxRespawnTime
	STA !CurrentSpawnTime,x

	JSL !CheckClusterSharedDynamicExisted
	BCS +
	JSR InitWrapperChangeAnimationFromStart

	%CheckSlot(#$00, #$02, "!ClusterNumber,x", $A0, DZ_DS_Loc_US_Cluster)

RTS
+
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAY

	LDA !AnimationIndex,y
	STA !AnimationIndex,x

	LDA !AnimationTimer,y
	STA !AnimationTimer,x

	LDA !AnimationFrameIndex,y
	STA !AnimationFrameIndex,x

	LDA !FrameIndex,y
	STA !FrameIndex,x
RTS

;>Routine: SpriteCode
;>Description: This routine excecute the logic of the sprite
;>RoutineLength: Short
Return:
	PHX
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX

	LDA.l DZ_DS_Loc_SharedUpdated,x
	BNE +

	LDA #$01
	STA.l DZ_DS_Loc_SharedUpdated,x

	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$E0
	ORA $01,s
	STA.l DZ_DS_Loc_UsedBy,x
	PLX

	JSL !CheckIfLastClusterSharedProcessed
RTS
+
	PLY
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAX

	LDA !AnimationIndex,x
	STA !AnimationIndex,y

	LDA !AnimationTimer,x
	STA !AnimationTimer,y

	LDA !AnimationFrameIndex,x
	STA !AnimationFrameIndex,y

	LDA !FrameIndex,x
	STA !FrameIndex,y
	TYX

	JSL !CheckIfLastClusterSharedProcessed
RTS
SpriteCode:
	LDA !Started,x
	BNE +
	JSR StartRoutine
	LDA #$01
	STA !Started,x
RTS
+
	JSR DynamicRoutine

	PHX
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX

	LDA.l DZ_DS_Loc_IsValid,x
	BNE +
	PLX
	JSL !CheckIfLastClusterSharedProcessed
RTS
+
	PLX

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

	PHX
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX

	LDA.l DZ_DS_Loc_SharedUpdated,x
	BNE +

	LDA #$01
	STA.l DZ_DS_Loc_SharedUpdated,x

	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$E0
	ORA $01,s
	STA.l DZ_DS_Loc_UsedBy,x
	PLX

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw
    
	JSL !CheckIfLastClusterSharedProcessed
RTS
+
	PLY
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAX

	LDA !AnimationTimer,x
	STA !AnimationTimer,y

	LDA !AnimationFrameIndex,x
	STA !AnimationFrameIndex,y

	LDA !FrameIndex,x
	STA !FrameIndex,y
	TYX

	JSL !CheckIfLastClusterSharedProcessed
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
    STZ !Scratch2
    STZ !Scratch3
    STZ !Scratch4
    STZ !Scratch5

	LDA !ClusterNumber,x
	%SpawnCluster()
	BCS +
	RTS
+
	LDA !SpawnCounter,x
	INC A
	STA !SpawnCounter,x

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

	LDA !Properties,x
	
	PHX
	TYX
	AND #$EF
	ORA #$10
	STA !Properties,x

	JSR StartSetting

	PLX
RTS

StartSetting:
	JSL $01ACF9|!rom
	LDA $148D|!addr
	EOR !TrueFrameCounter
	AND #$01
	STA !GlobalFlip,x
	ASL 
	TAY

	JSL $01ACF9|!rom

	REP #$20

	LDA $148D|!addr
	EOR !TrueFrameCounter
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
	dw $FFE9,$00EF
;Here you can write routines or tables
Move:

	LDA !CurrentRespawnTime,x
	BEQ +

	DEC A
	STA !CurrentRespawnTime,x
	BNE ++
	JSR StartSetting
++
RTS
+
	LDA !Scratch52
	BNE .move

	LDA #$20
	STA !CurrentRespawnTime,x
RTS
.move
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
	SEC
	SBC !Layer1X
	BPL ++
	CMP #$FFD9
	BCS +
++
	CMP #$00FF
	BCC +
	SEP #$20
	JSR StartSetting
RTS
+
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
BlueFish0_ResourceOffset:
	dw $0000,$0060
BlueFish1_ResourceOffset:
	dw $00A0,$0100
BlueFish2_ResourceOffset:
	dw $0140,$01A0
BlueFish3_ResourceOffset:
	dw $01E0,$0240
BlueFish4_ResourceOffset:
	dw $0280,$02E0
BlueFish5_ResourceOffset:
	dw $0320,$0380
BlueFish6_ResourceOffset:
	dw $03C0,$0420
BlueFish7_ResourceOffset:
	dw $0460,$04C0
OrangeFish0_ResourceOffset:
	dw $0500,$0560
OrangeFish1_ResourceOffset:
	dw $05A0,$0600
OrangeFish2_ResourceOffset:
	dw $0640,$06A0
OrangeFish3_ResourceOffset:
	dw $06E0,$0740
OrangeFish4_ResourceOffset:
	dw $0780,$07E0
OrangeFish5_ResourceOffset:
	dw $0820,$0880
OrangeFish6_ResourceOffset:
	dw $08C0,$0920
OrangeFish7_ResourceOffset:
	dw $0960,$09C0


ResourceSize:
	db $03,$02

DynamicRoutine:

	PHX
	
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX

	LDA DZ_DS_Loc_SharedUpdated,x
	BEQ +
	PLX
RTS
+
	PLX

	%CheckEvenOrOdd("DZ_DS_Loc_US_Cluster")
	BEQ +								;/
RTS
+
	%FindSpace("DZ_DS_Loc_US_Cluster,x")
	BCS +

	PHX
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX

	LDA.l DZ_DS_Loc_IsValid,x
	BNE ++
    STZ !ClusterSpriteNumber,x
++
	PLX
RTS
+
	LDA !ScratchB
	BNE +
	
	LDA !FrameIndex,x
	STA !Scratch0
	CMP !LastFrameIndex,x				;|if last frame is different to new frame then
	BNE ++								;|do dynamic routine
RTS										;/
+
	LDA !FrameIndex,x
	STA !Scratch0
++
	PHX
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX
	LDA !Scratch0
	STA.l DZ_DS_Loc_SharedFrame,x
	PLX

	PHX

	LDA #$00
	XBA
	LDA !Scratch0
	STA !LastFrameIndex,x
	REP #$30
	ASL
	TAY
	PHY
	SEP #$20
	LDA ResourceSize
	STA !Scratch0
	REP #$20
	TYA
	ASL
	TAY
	PHY
	LDA ResourceOffset,y
	STA !Scratch1
	SEP #$30

	LDA !LastFrameIndex,x
	TAY

	%GetVramDispDynamicRoutine(DZ_DS_Loc_US_Cluster)
	STA !ScratchD

	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX

	LDA #$01
	STA.l DZ_DS_Loc_IsValid,x

	%DynamicRoutine(!ScratchD, #!GFX00, #!GFX00>>16, !Scratch1, !Scratch0)

	REP #$30
	PLY
	LDA ResourceOffset+2,y
	STA !Scratch1
	SEP #$20
	PLY
	LDA ResourceSize+1
	STA !Scratch0
	SEP #$10
	BEQ +

	LDA !ScratchD
	CLC
	ADC #$10
	STA !ScratchD
	%DynamicRoutine(!ScratchD, #!GFX00, #!GFX00>>16, !Scratch1, !Scratch0)
+

	PLX
RTS
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
	%checkRow(0)
	%checkRow(1)
	%checkRow(2)
	%checkRow(3)
	%checkRow(4)
	%checkRow(5)
	%checkRow(6)
	%checkRow(7)
	%checkRow(8)
	%checkRow(9)
	%checkRow(A)
	%checkRow(B)
	%checkRow(C)
	%checkRow(D)
	%checkRow(E)
	%checkRow(F)
	
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

	BPL -

	CLC
RTS
+	
	SEC
RTS

TopOrLeftLimit:
	dw $FFF8,$FFF0

!YScreenPos = $01,s
!XScreenPos = $03,s
!TopOrLeftLimit = $05,s
!StackPointer = $07,s

macro ReturnCheckPosition()
	LDA !XScreenPos
	STA !Scratch49
	LDA !YScreenPos
	STA !Scratch4B

    LDA !StackPointer
    TCS
	SEP #$20
endmacro
CheckPosition:
	PHX
	TAX

	REP #$20

    TSC
    PHA             

	LDA.l TopOrLeftLimit,x
	PHA

	LDA !Scratch45
	CLC
	ADC !Scratch49
	SEC
	SBC !Layer1X
	PHA

	LDA !Scratch47
	CLC
	ADC !Scratch4B
	SEC
	SBC !Layer1Y
	PHA

	LDA !XScreenPos
	CMP !TopOrLeftLimit
	BCC +

	INX
	BRA .CheckVertical
+
	CMP #$0100
	BCC .CheckVertical
	%ReturnCheckPosition()
	PLX
	CLC
RTS
.CheckVertical

	LDA !YScreenPos
	CMP !TopOrLeftLimit
	BCC +
	STX !Scratch4D
	%ReturnCheckPosition()
	PLX
	SEC
RTS
+
	CMP #$00E0
	BCC +
	%ReturnCheckPosition()
	PLX
	CLC
RTS
+
	STX !Scratch4D
	%ReturnCheckPosition()
	PLX
	SEC
RTS

SelectStartSlot:

	LDY #$00EC
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
GraphicRoutine:

	STZ !Scratch52

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

	%GetVramDisp(DZ_DS_Loc_US_Cluster)
	STA !ScratchE

    STZ !Scratch3                       ;$02 = Free Slot but in 16bits
    STY !Scratch2

    STZ !Scratch5
    LDA !GlobalFlip,x   
    ASL
    STA !Scratch4                       ;$04 = Global Flip but in 16bits


    PHX                                 ;Preserve X
    
    STZ !Scratch7
	PHX
	LDA.l DZ_DS_Loc_US_Cluster,x
	TAX
	LDA.l DZ_DS_Loc_SharedFrame,x
    STA !Scratch6                       ;$06 = Frame Index but in 16bits
	PLX

    REP #$30                            ;A/X/Y 16bits mode
    LDY !Scratch4                       ;Y = Global Flip
    LDA !Scratch6
    ASL
	CLC
    ADC FramesFlippers,y
    TAX                                 ;X = Frame Index

    LDA FramesEndPosition,x
    STA !Scratch4                       ;$04 = End Position + A value used to select a frame version that is flipped

    LDA FramesStartPosition,x           
    TAX                                 ;X = Start Position
    SEP #$20                            ;A 8bits mode

	JSR SelectStartSlot
	JSR FindOAM
	BCC .return
-
	STZ !Scratch4A
	LDA XDisplacements,x
	STA !Scratch49
	BPL +
	LDA #$FF
	STA !Scratch4A
+
	STZ !Scratch4C
	LDA YDisplacements,x
	STA !Scratch4B
	BPL +
	LDA #$FF
	STA !Scratch4C
+
	LDA Sizes,x
	JSR CheckPosition
	BCC ++

	LDA #$01
	STA !Scratch52

    %RemapOamTile("Tiles,x", !ScratchE)
    STA !TileCode200,y                     ;Set the Tile code of the tile Y

	LDA Properties,x
	AND #$F1
	ORA !ScratchD
    STA !TileProperty200,y                 ;Set the Tile property of the tile Y

	LDA !Scratch49
	STA !TileXPosition200,y

	LDA !Scratch4B
	STA !TileYPosition200,y

    PHY
	REP #$20                                 
    TYA	
    LSR
    LSR
    TAY                                 ;Y = Y/4 because size directions are not continuous to map 200 and 300
	SEP #$20
    LDA !Scratch4D
    STA !TileSize420,y                  ;Set the Tile size of the tile Y
    PLY

    DEY
	DEY
	DEY
	DEY

	JSR FindOAM
	BCC .return
++
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
    
Frame0_BlueFish0_Tiles:
	db $02,$00
Frame1_BlueFish1_Tiles:
	db $02,$00
Frame2_BlueFish2_Tiles:
	db $02,$00
Frame3_BlueFish3_Tiles:
	db $02,$00
Frame4_BlueFish4_Tiles:
	db $02,$00
Frame5_BlueFish5_Tiles:
	db $02,$00
Frame6_BlueFish6_Tiles:
	db $02,$00
Frame7_BlueFish7_Tiles:
	db $02,$00
Frame8_OrangeFish0_Tiles:
	db $02,$00
Frame9_OrangeFish1_Tiles:
	db $02,$00
Frame10_OrangeFish2_Tiles:
	db $02,$00
Frame11_OrangeFish3_Tiles:
	db $02,$00
Frame12_OrangeFish4_Tiles:
	db $02,$00
Frame13_OrangeFish5_Tiles:
	db $02,$00
Frame14_OrangeFish6_Tiles:
	db $02,$00
Frame15_OrangeFish7_Tiles:
	db $02,$00
Frame0_BlueFish0_TilesFlipX:
	db $02,$00
Frame1_BlueFish1_TilesFlipX:
	db $02,$00
Frame2_BlueFish2_TilesFlipX:
	db $02,$00
Frame3_BlueFish3_TilesFlipX:
	db $02,$00
Frame4_BlueFish4_TilesFlipX:
	db $02,$00
Frame5_BlueFish5_TilesFlipX:
	db $02,$00
Frame6_BlueFish6_TilesFlipX:
	db $02,$00
Frame7_BlueFish7_TilesFlipX:
	db $02,$00
Frame8_OrangeFish0_TilesFlipX:
	db $02,$00
Frame9_OrangeFish1_TilesFlipX:
	db $02,$00
Frame10_OrangeFish2_TilesFlipX:
	db $02,$00
Frame11_OrangeFish3_TilesFlipX:
	db $02,$00
Frame12_OrangeFish4_TilesFlipX:
	db $02,$00
Frame13_OrangeFish5_TilesFlipX:
	db $02,$00
Frame14_OrangeFish6_TilesFlipX:
	db $02,$00
Frame15_OrangeFish7_TilesFlipX:
	db $02,$00
;>EndTable


;>Table: Properties
;>Description: Properties of each tile of each frame
;>ValuesSize: 8
Properties:
    
Frame0_BlueFish0_Properties:
	db $2D,$2D
Frame1_BlueFish1_Properties:
	db $2D,$2D
Frame2_BlueFish2_Properties:
	db $2D,$2D
Frame3_BlueFish3_Properties:
	db $2D,$2D
Frame4_BlueFish4_Properties:
	db $2D,$2D
Frame5_BlueFish5_Properties:
	db $2D,$2D
Frame6_BlueFish6_Properties:
	db $2D,$2D
Frame7_BlueFish7_Properties:
	db $2D,$2D
Frame8_OrangeFish0_Properties:
	db $2F,$2F
Frame9_OrangeFish1_Properties:
	db $2F,$2F
Frame10_OrangeFish2_Properties:
	db $2F,$2F
Frame11_OrangeFish3_Properties:
	db $2F,$2F
Frame12_OrangeFish4_Properties:
	db $2F,$2F
Frame13_OrangeFish5_Properties:
	db $2F,$2F
Frame14_OrangeFish6_Properties:
	db $2F,$2F
Frame15_OrangeFish7_Properties:
	db $2F,$2F
Frame0_BlueFish0_PropertiesFlipX:
	db $6D,$6D
Frame1_BlueFish1_PropertiesFlipX:
	db $6D,$6D
Frame2_BlueFish2_PropertiesFlipX:
	db $6D,$6D
Frame3_BlueFish3_PropertiesFlipX:
	db $6D,$6D
Frame4_BlueFish4_PropertiesFlipX:
	db $6D,$6D
Frame5_BlueFish5_PropertiesFlipX:
	db $6D,$6D
Frame6_BlueFish6_PropertiesFlipX:
	db $6D,$6D
Frame7_BlueFish7_PropertiesFlipX:
	db $6D,$6D
Frame8_OrangeFish0_PropertiesFlipX:
	db $6F,$6F
Frame9_OrangeFish1_PropertiesFlipX:
	db $6F,$6F
Frame10_OrangeFish2_PropertiesFlipX:
	db $6F,$6F
Frame11_OrangeFish3_PropertiesFlipX:
	db $6F,$6F
Frame12_OrangeFish4_PropertiesFlipX:
	db $6F,$6F
Frame13_OrangeFish5_PropertiesFlipX:
	db $6F,$6F
Frame14_OrangeFish6_PropertiesFlipX:
	db $6F,$6F
Frame15_OrangeFish7_PropertiesFlipX:
	db $6F,$6F
;>EndTable
;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_BlueFish0_XDisp:
	db $FF,$01
Frame1_BlueFish1_XDisp:
	db $FC,$01
Frame2_BlueFish2_XDisp:
	db $FD,$01
Frame3_BlueFish3_XDisp:
	db $FD,$01
Frame4_BlueFish4_XDisp:
	db $FD,$01
Frame5_BlueFish5_XDisp:
	db $FC,$01
Frame6_BlueFish6_XDisp:
	db $FD,$01
Frame7_BlueFish7_XDisp:
	db $FD,$01
Frame8_OrangeFish0_XDisp:
	db $FD,$00
Frame9_OrangeFish1_XDisp:
	db $FB,$00
Frame10_OrangeFish2_XDisp:
	db $FB,$00
Frame11_OrangeFish3_XDisp:
	db $FC,$00
Frame12_OrangeFish4_XDisp:
	db $FC,$00
Frame13_OrangeFish5_XDisp:
	db $FB,$00
Frame14_OrangeFish6_XDisp:
	db $FB,$00
Frame15_OrangeFish7_XDisp:
	db $FD,$00
Frame0_BlueFish0_XDispFlipX:
	db $19,$0F
Frame1_BlueFish1_XDispFlipX:
	db $1C,$0F
Frame2_BlueFish2_XDispFlipX:
	db $1B,$0F
Frame3_BlueFish3_XDispFlipX:
	db $1B,$0F
Frame4_BlueFish4_XDispFlipX:
	db $1B,$0F
Frame5_BlueFish5_XDispFlipX:
	db $1C,$0F
Frame6_BlueFish6_XDispFlipX:
	db $1B,$0F
Frame7_BlueFish7_XDispFlipX:
	db $1B,$0F
Frame8_OrangeFish0_XDispFlipX:
	db $1B,$10
Frame9_OrangeFish1_XDispFlipX:
	db $1D,$10
Frame10_OrangeFish2_XDispFlipX:
	db $1D,$10
Frame11_OrangeFish3_XDispFlipX:
	db $1C,$10
Frame12_OrangeFish4_XDispFlipX:
	db $1C,$10
Frame13_OrangeFish5_XDispFlipX:
	db $1D,$10
Frame14_OrangeFish6_XDispFlipX:
	db $1D,$10
Frame15_OrangeFish7_XDispFlipX:
	db $1B,$10
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_BlueFish0_YDisp:
	db $04,$04
Frame1_BlueFish1_YDisp:
	db $06,$04
Frame2_BlueFish2_YDisp:
	db $05,$03
Frame3_BlueFish3_YDisp:
	db $05,$03
Frame4_BlueFish4_YDisp:
	db $06,$05
Frame5_BlueFish5_YDisp:
	db $06,$04
Frame6_BlueFish6_YDisp:
	db $07,$05
Frame7_BlueFish7_YDisp:
	db $07,$05
Frame8_OrangeFish0_YDisp:
	db $06,$05
Frame9_OrangeFish1_YDisp:
	db $06,$05
Frame10_OrangeFish2_YDisp:
	db $05,$04
Frame11_OrangeFish3_YDisp:
	db $06,$04
Frame12_OrangeFish4_YDisp:
	db $08,$05
Frame13_OrangeFish5_YDisp:
	db $07,$05
Frame14_OrangeFish6_YDisp:
	db $08,$06
Frame15_OrangeFish7_YDisp:
	db $08,$06
Frame0_BlueFish0_YDispFlipX:
	db $04,$04
Frame1_BlueFish1_YDispFlipX:
	db $06,$04
Frame2_BlueFish2_YDispFlipX:
	db $05,$03
Frame3_BlueFish3_YDispFlipX:
	db $05,$03
Frame4_BlueFish4_YDispFlipX:
	db $06,$05
Frame5_BlueFish5_YDispFlipX:
	db $06,$04
Frame6_BlueFish6_YDispFlipX:
	db $07,$05
Frame7_BlueFish7_YDispFlipX:
	db $07,$05
Frame8_OrangeFish0_YDispFlipX:
	db $06,$05
Frame9_OrangeFish1_YDispFlipX:
	db $06,$05
Frame10_OrangeFish2_YDispFlipX:
	db $05,$04
Frame11_OrangeFish3_YDispFlipX:
	db $06,$04
Frame12_OrangeFish4_YDispFlipX:
	db $08,$05
Frame13_OrangeFish5_YDispFlipX:
	db $07,$05
Frame14_OrangeFish6_YDispFlipX:
	db $08,$06
Frame15_OrangeFish7_YDispFlipX:
	db $08,$06
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_BlueFish0_Sizes:
	db $00,$02
Frame1_BlueFish1_Sizes:
	db $00,$02
Frame2_BlueFish2_Sizes:
	db $00,$02
Frame3_BlueFish3_Sizes:
	db $00,$02
Frame4_BlueFish4_Sizes:
	db $00,$02
Frame5_BlueFish5_Sizes:
	db $00,$02
Frame6_BlueFish6_Sizes:
	db $00,$02
Frame7_BlueFish7_Sizes:
	db $00,$02
Frame8_OrangeFish0_Sizes:
	db $00,$02
Frame9_OrangeFish1_Sizes:
	db $00,$02
Frame10_OrangeFish2_Sizes:
	db $00,$02
Frame11_OrangeFish3_Sizes:
	db $00,$02
Frame12_OrangeFish4_Sizes:
	db $00,$02
Frame13_OrangeFish5_Sizes:
	db $00,$02
Frame14_OrangeFish6_Sizes:
	db $00,$02
Frame15_OrangeFish7_Sizes:
	db $00,$02
Frame0_BlueFish0_SizesFlipX:
	db $00,$02
Frame1_BlueFish1_SizesFlipX:
	db $00,$02
Frame2_BlueFish2_SizesFlipX:
	db $00,$02
Frame3_BlueFish3_SizesFlipX:
	db $00,$02
Frame4_BlueFish4_SizesFlipX:
	db $00,$02
Frame5_BlueFish5_SizesFlipX:
	db $00,$02
Frame6_BlueFish6_SizesFlipX:
	db $00,$02
Frame7_BlueFish7_SizesFlipX:
	db $00,$02
Frame8_OrangeFish0_SizesFlipX:
	db $00,$02
Frame9_OrangeFish1_SizesFlipX:
	db $00,$02
Frame10_OrangeFish2_SizesFlipX:
	db $00,$02
Frame11_OrangeFish3_SizesFlipX:
	db $00,$02
Frame12_OrangeFish4_SizesFlipX:
	db $00,$02
Frame13_OrangeFish5_SizesFlipX:
	db $00,$02
Frame14_OrangeFish6_SizesFlipX:
	db $00,$02
Frame15_OrangeFish7_SizesFlipX:
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
	%CheckEvenOrOdd("DZ_DS_Loc_US_Cluster")
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



















































































































































































































































































































































































































































































































