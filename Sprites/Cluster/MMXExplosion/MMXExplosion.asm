;@MMXExplosion.bin,MMXExplosionPal.bin
!ResourceIndex = $06
%GFXTabDef(!ResourceIndex)
%GFXDef(00)
%GFXDef(01)

!LastOAM200Slot = $0DDB|!addr

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

!FrameIndex = !ClusterMiscTable1
!AnimationTimer = !ClusterMiscTable2
!AnimationIndex = !ClusterMiscTable3
!AnimationFrameIndex = !ClusterMiscTable4
!LocalFlip = !ClusterMiscTable5
!GlobalFlip = !ClusterMiscTable6
!Started = !ClusterMiscTable7

StartRoutine:
	LDA #$00
	STA !GlobalFlip,x
	JSL InitWrapperChangeAnimationFromStart

	LDA !ClusterNumber,x
	STA DZ_SDS_SpriteNumber_Cluster,x

	LDA #$34
	STA DZ_SDS_Size_Cluster,x
	LDA #$00
	STA DZ_SDS_PaletteLoaded_Cluster,x
	STA DZ_SDS_Valid_Cluster,x

	JSL !FindCopyCluster
    ;Here you can write your Init Code
    ;This will be excecuted when the sprite is spawned 
RTS

print "INIT ",pc
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
Pal:
	db $81,$91,$A1,$B1,$C1,$D1,$E1,$F1
SpriteCode:
	LDA !Started,x
	BNE +
	LDA #$01
	STA !Started,x
	JSR StartRoutine
+

	LDA DZ_SDS_PaletteLoaded_Cluster,x
	BEQ +
	JMP ++
+
	LDA #$01
	STA DZ_SDS_PaletteLoaded_Cluster,x

	PHX
	LDA DZ_SDS_PaletteAndPage_Cluster,x
	LSR
	TAX

	LDA.l Pal,x
	STA !Scratch0
	PLX

	%TransferToCGRAM(!Scratch0, #!GFX01, #!GFX01>>16, #$001E)
++

	LDA DZ_SDS_Valid_Cluster,x
	BNE +
	LDA.b #!GFX00>>16
	STA !ScratchA
	STZ !ScratchB
	REP #$20
	LDA.w #!GFX00
	STA !Scratch6
	SEP #$20
	JSL !LoadGraphicsSDSCluster
	LDA DZ_SDS_Valid_Cluster,x
	BNE +
RTS
+

    JSR GraphicRoutine                  ;Calls the graphic routine and updates sprite graphics

    ;Here you can put code that will be excecuted each frame even if the sprite is locked

	LDA !LockAnimationFlag				    
	BNE Return			                    ;if locked animation return.

    ;JSR InteractMarioSprite
    ;After this routine, if the sprite interact with mario, Carry is Set.

    ;Here you can write your sprite code routine
    ;This will be excecuted once per frame excepts when 
    ;the animation is locked or when sprite status is not #$08
	LDA !AnimationFrameIndex,x
	CMP #$08
	BNE +

	LDA !AnimationTimer,x
	BNE +

	STZ !ClusterNumber,x
RTS
+

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw
    
	LDA !AnimationTimer,x
	BEQ +
	DEC A
	STA !AnimationTimer,x
+
Return:
RTS

;>EndRoutine

;######################################
;######## Sub Routine Space ###########
;######################################

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

	LDA DZ_SDS_PaletteAndPage_Cluster,x
	STA !ScratchE

	LDA DZ_SDS_Offset_Cluster,x
	STA !ScratchD

	LDA !ClusterXLow,x
	STA !Scratch45
	LDA !ClusterXHigh,x
	STA !Scratch46

	LDA !ClusterYLow,x
	STA !Scratch47
	LDA !ClusterYHigh,x
	STA !Scratch48

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

    LDA Tiles,x
	CLC
	ADC !ScratchD
    STA !TileCode200,y                     ;Set the Tile code of the tile Y

	LDA Properties,x
	AND #$F0
	ORA !ScratchE
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

;>Table: FramesLengths
;>Description: How many tiles use each frame.
;>ValuesSize: 16
FramesLength:
    dw $0003,$0004,$0003,$0003,$0003,$0005,$0001,$0003
	dw $0003,$0004,$0003,$0003,$0003,$0005,$0001,$0003
;>EndTable


;>Table: FramesFlippers
;>Description: Values used to add values to FramesStartPosition and FramesEndPosition
;To use a flipped version of the frames.
;>ValuesSize: 16
FramesFlippers:
    dw $0000,$0010
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0003,$0008,$000C,$0010,$0014,$001A,$001C,$0020
	dw $0024,$0029,$002D,$0031,$0035,$003B,$003D,$0041
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0004,$0009,$000D,$0011,$0015,$001B,$001D
	dw $0021,$0025,$002A,$002E,$0032,$0036,$003C,$003E
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Frame0_Tiles:
	db $00,$00,$00,$00
Frame1_Frame1_Tiles:
	db $02,$02,$24,$25,$24
Frame2_Frame2_Tiles:
	db $04,$04,$06,$06
Frame3_Frame3_Tiles:
	db $08,$08,$0A,$0A
Frame4_Frame4_Tiles:
	db $0C,$0C,$0E,$0E
Frame5_Frame5_Tiles:
	db $20,$20,$27,$28,$27,$28
Frame6_Frame6_Tiles:
	db $22,$22
Frame7_Frame7_Tiles:
	db $26,$26,$26,$26
Frame0_Frame0_TilesFlipX:
	db $00,$00,$00,$00
Frame1_Frame1_TilesFlipX:
	db $02,$02,$24,$25,$24
Frame2_Frame2_TilesFlipX:
	db $04,$04,$06,$06
Frame3_Frame3_TilesFlipX:
	db $08,$08,$0A,$0A
Frame4_Frame4_TilesFlipX:
	db $0C,$0C,$0E,$0E
Frame5_Frame5_TilesFlipX:
	db $20,$20,$27,$28,$27,$28
Frame6_Frame6_TilesFlipX:
	db $22,$22
Frame7_Frame7_TilesFlipX:
	db $26,$26,$26,$26
;>EndTable


;>Table: Properties
;>Description: Properties of each tile of each frame
;>ValuesSize: 8
Properties:
    
Frame0_Frame0_Properties:
	db $25,$65,$A5,$E5
Frame1_Frame1_Properties:
	db $25,$65,$25,$25,$65
Frame2_Frame2_Properties:
	db $25,$65,$25,$65
Frame3_Frame3_Properties:
	db $25,$65,$25,$65
Frame4_Frame4_Properties:
	db $25,$65,$25,$65
Frame5_Frame5_Properties:
	db $25,$65,$25,$25,$65,$65
Frame6_Frame6_Properties:
	db $25,$65
Frame7_Frame7_Properties:
	db $25,$65,$A5,$E5
Frame0_Frame0_PropertiesFlipX:
	db $65,$25,$E5,$A5
Frame1_Frame1_PropertiesFlipX:
	db $65,$25,$65,$65,$25
Frame2_Frame2_PropertiesFlipX:
	db $65,$25,$65,$25
Frame3_Frame3_PropertiesFlipX:
	db $65,$25,$65,$25
Frame4_Frame4_PropertiesFlipX:
	db $65,$25,$65,$25
Frame5_Frame5_PropertiesFlipX:
	db $65,$25,$65,$65,$25,$25
Frame6_Frame6_PropertiesFlipX:
	db $65,$25
Frame7_Frame7_PropertiesFlipX:
	db $65,$25,$E5,$A5
;>EndTable
;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Frame0_XDisp:
	db $F8,$08,$F8,$08
Frame1_Frame1_XDisp:
	db $F8,$08,$FC,$04,$0C
Frame2_Frame2_XDisp:
	db $F8,$08,$F8,$08
Frame3_Frame3_XDisp:
	db $F8,$08,$F8,$08
Frame4_Frame4_XDisp:
	db $F8,$08,$F8,$08
Frame5_Frame5_XDisp:
	db $F8,$08,$F8,$00,$10,$08
Frame6_Frame6_XDisp:
	db $F8,$08
Frame7_Frame7_XDisp:
	db $00,$08,$00,$08
Frame0_Frame0_XDispFlipX:
	db $08,$F8,$08,$F8
Frame1_Frame1_XDispFlipX:
	db $08,$F8,$0C,$04,$FC
Frame2_Frame2_XDispFlipX:
	db $08,$F8,$08,$F8
Frame3_Frame3_XDispFlipX:
	db $08,$F8,$08,$F8
Frame4_Frame4_XDispFlipX:
	db $08,$F8,$08,$F8
Frame5_Frame5_XDispFlipX:
	db $08,$F8,$10,$08,$F8,$00
Frame6_Frame6_XDispFlipX:
	db $08,$F8
Frame7_Frame7_XDispFlipX:
	db $08,$00,$08,$00
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Frame0_YDisp:
	db $F8,$F8,$08,$08
Frame1_Frame1_YDisp:
	db $FA,$FA,$0A,$0A,$0A
Frame2_Frame2_YDisp:
	db $F2,$F2,$02,$02
Frame3_Frame3_YDisp:
	db $F2,$F2,$02,$02
Frame4_Frame4_YDisp:
	db $F2,$F2,$02,$02
Frame5_Frame5_YDisp:
	db $F6,$F6,$06,$06,$06,$06
Frame6_Frame6_YDisp:
	db $FC,$FC
Frame7_Frame7_YDisp:
	db $00,$00,$08,$08
Frame0_Frame0_YDispFlipX:
	db $F8,$F8,$08,$08
Frame1_Frame1_YDispFlipX:
	db $FA,$FA,$0A,$0A,$0A
Frame2_Frame2_YDispFlipX:
	db $F2,$F2,$02,$02
Frame3_Frame3_YDispFlipX:
	db $F2,$F2,$02,$02
Frame4_Frame4_YDispFlipX:
	db $F2,$F2,$02,$02
Frame5_Frame5_YDispFlipX:
	db $F6,$F6,$06,$06,$06,$06
Frame6_Frame6_YDispFlipX:
	db $FC,$FC
Frame7_Frame7_YDispFlipX:
	db $00,$00,$08,$08
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Frame0_Sizes:
	db $02,$02,$02,$02
Frame1_Frame1_Sizes:
	db $02,$02,$00,$00,$00
Frame2_Frame2_Sizes:
	db $02,$02,$02,$02
Frame3_Frame3_Sizes:
	db $02,$02,$02,$02
Frame4_Frame4_Sizes:
	db $02,$02,$02,$02
Frame5_Frame5_Sizes:
	db $02,$02,$00,$00,$00,$00
Frame6_Frame6_Sizes:
	db $02,$02
Frame7_Frame7_Sizes:
	db $00,$00,$00,$00
Frame0_Frame0_SizesFlipX:
	db $02,$02,$02,$02
Frame1_Frame1_SizesFlipX:
	db $02,$02,$00,$00,$00
Frame2_Frame2_SizesFlipX:
	db $02,$02,$02,$02
Frame3_Frame3_SizesFlipX:
	db $02,$02,$02,$02
Frame4_Frame4_SizesFlipX:
	db $02,$02,$02,$02
Frame5_Frame5_SizesFlipX:
	db $02,$02,$00,$00,$00,$00
Frame6_Frame6_SizesFlipX:
	db $02,$02
Frame7_Frame7_SizesFlipX:
	db $00,$00,$00,$00
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

ChangeAnimationFromStart_Animation0:
	STZ !AnimationIndex,x


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
    LDA !AnimationTimer,x
    BEQ +

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
	dw $0009

AnimationLastTransition:
	dw $0008

AnimationIndexer:
	dw $0000

Frames:
	
Animation0_Animation0_Frames:
	db $07,$00,$07,$01,$02,$03,$04,$05,$06

Times:
	
Animation0_Animation0_Times:
	db $02,$04,$02,$04,$04,$04,$04,$04,$04
;>End Animations Section

;Don't Delete or write another >Section Hitbox Interaction or >End Section
;All code between >Section Hitboxes Interaction and >End Hitboxes Interaction Section will be changed by Dyzen : Sprite Maker
;>Section Hitboxes Interaction
;>End Hitboxes Interaction Section



























































































































































































