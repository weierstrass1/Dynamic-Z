!ResourceIndex = $02
!FreeRams = $7FB880

if !sa1
	!FreeRams = $418B80
endif

;Constant
!MinRespawnTime = $10
!MaxRespawnTime = $40
!MaxSpawnTime = $80
!MaxSpawn = $13

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
!Properties = !FreeRams
!CurrentRespawnTime = !Properties+$14
!CurrentSpawnTime = !CurrentRespawnTime+$14
!SpawnCounter = !CurrentSpawnTime+$14
!YCentreLow = !SpawnCounter+$14
!YCentreHigh = !YCentreLow+$14
!YTimer = !YCentreHigh+$14
!YAdder = !YTimer+$14
!Properties2 = !YAdder+$14
!Palette = !Properties2+$14

!LastOAM200Slot = $0DDB|!addr

%GFXTabDef(!ResourceIndex)
%GFXDef(00)

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
SPEEDXADDER: db $01,$FF
StartRoutine:
	LDA #$00
	STA !CurrentRespawnTime,x
	STA !SpawnCounter,x
	STA !YTimer,x

	JSR GetPal

	LDA #$FF
	STA !LastFrameIndex,x

	JSL $01ACF9|!rom
	LDA $148D|!addr
	AND #$01
	TAY
	LDA SPEEDXADDER,y
	STA !YAdder,x

	JSL !CheckClusterSharedDynamicExisted
	BCS +
	JSR InitWrapperChangeAnimationFromStart

	%CheckSlot(#$00, #$01, "!ClusterNumber,x", $A0, DZ.DSLocUSCluster)

	LDA !FrameIndex,x
	STA !Scratch0
	PHX
	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA !Scratch0
	STA.l DZ.DSLocSharedFrame,x
	PLX 
RTS
+
RTS

;>Routine: SpriteCode
;>Description: This routine excecute the logic of the sprite
;>RoutineLength: Short
Return:
	PHX
	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA.l DZ.DSLocSharedUpdated,x
	BNE +

	LDA #$01
	STA.l DZ.DSLocSharedUpdated,x
	PLX
RTS
+
	PLY
	LDA.l DZ.DSLocUsedBy,x
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
	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA.l DZ.DSLocIsValid,x
	BNE +
	PLX
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
	JSR TimerY
    ;Here you can write your sprite code routine
    ;This will be excecuted once per frame excepts when 
    ;the animation is locked or when sprite status is not #$08

	PHX
	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA.l DZ.DSLocSharedUpdated,x
	BNE +

	LDA #$01
	STA.l DZ.DSLocSharedUpdated,x

	LDA.l DZ.DSLocUsedBy,x
	AND #$E0
	ORA $01,s
	STA.l DZ.DSLocUsedBy,x
	PLX

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw

	LDA !FrameIndex,x
	STA !Scratch0
	PHX
	LDA.l DZ.DSLocUSCluster,x
	TAX
	LDA !Scratch0
	STA.l DZ.DSLocSharedFrame,x
	PLX
    
	JSL !CheckIfLastClusterSharedProcessed
RTS
+
	PLY
	LDA.l DZ.DSLocUsedBy,x
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

TimerY:
	LDA !EffectiveFrameCounter
	AND #$01
	BEQ +
RTS
+
	LDA !YTimer,x
	BEQ +
	DEC A
	STA !YTimer,x
RTS
+
	LDA #$17
	STA !YTimer,x
RTS

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
	SEC
	SBC #!ClusterOffset
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

	LDA !Properties2,x
	STA !Scratch0
	LDA !Properties,x
	
	PHX
	TYX
	STA !Properties,x
	
	LDA !Scratch0
	STA !Properties2,x

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

	JSR GetPal

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
	dw $0101,$FFF1

GetPal:
	JSL $01ACF9|!rom
	LDA $148D|!addr
	EOR !TrueFrameCounter
	AND #$0F
	CMP #$04
	BCS +
	LDA !Properties,x
	AND #$0E
	STA !Palette,x
RTS
+
	CMP #$0C
	BCS +

	LDA !Properties2,x
	AND #$0E
	STA !Palette,x
RTS
+
	LDA !Properties2,x
	LSR
	LSR
	LSR
	LSR
	AND #$0E
	STA !Palette,x
RTS

;Here you can write routines or tables
Move:

	LDA !CurrentRespawnTime,x
	BEQ +

	DEC A
	STA !CurrentRespawnTime,x
RTS
+
	LDA !Scratch52
	BNE .move

	JSL $01ACF9|!rom
	LDA #$00
	STA !CurrentRespawnTime,x
	JSR StartSetting
RTS

.move
+
	LDA !EffectiveFrameCounter
	AND #$01
	BNE ++

	STZ !Scratch1
	LDA #$01
	STA !Scratch0
	LDA !GlobalFlip,x
	BNE +
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

++

	STZ !Scratch0
	STZ !Scratch1
	LDY #$00
	LDA !EffectiveFrameCounter
	AND #$03
	BNE +

	STZ !Scratch1
	LDA !YAdder,x
	STA !Scratch0
	BPL +
	LDA #$FF
	STA !Scratch1
+

	LDA !EffectiveFrameCounter
	AND #$01
	BNE +

	LDA !YTimer,x
	ASL
	TAY
+

	LDA !ClusterYHigh,x
	XBA
	LDA !ClusterYLow,x
	REP #$20
	CLC
	ADC !Scratch0
	CLC
	ADC MovTab,y
	STA !Scratch0
	SEP #$20

	LDA !Scratch0
	STA !ClusterYLow,x
	LDA !Scratch1
	STA !ClusterYHigh,x

RTS

MovTab:
	dw $0000,$0000,$0000,$0000,$0001,$0001,$0001,$0001,$0001,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$0000,$0000,$0000

;>Section Dynamic
;######################################
;########## Animation Space ###########
;######################################
ResourceOffset:
Frame1_ResourceOffset:
	dw $0000,$0040
Frame2_ResourceOffset:
	dw $0080,$00C0
Frame3_ResourceOffset:
	dw $0100,$0140
Frame4_ResourceOffset:
	dw $0180,$01C0
Frame5_ResourceOffset:
	dw $0200,$0240


ResourceSize:
	db $02,$02

DynamicRoutine:

	PHX
	
	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA DZ.DSLocSharedUpdated,x
	BEQ +
	PLX
RTS
+
	PLX

	%CheckEvenOrOdd("DZ.DSLocUSCluster")
	BEQ +								;/
RTS
+
	%FindSpace("DZ.DSLocUSCluster,x")
	BCS +

	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA.l DZ.DSLocIsValid,x
	BNE ++
    STZ !ClusterSpriteNumber,x
++
RTS
+
	LDA !ScratchB
	BNE +
	
	PHX
	LDA.l DZ.DSLocUSCluster,x
	TAX
	LDA.l DZ.DSLocSharedFrame,x
	PLX
	CMP !LastFrameIndex,x				;|if last frame is different to new frame then
	BNE +								;|do dynamic routine
RTS										;/
+
	PHX

	PHA
	LDA #$00
	XBA
	PLA
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

	%GetVramDispDynamicRoutine(DZ.DSLocUSCluster)
	STA !ScratchD

	LDA.l DZ.DSLocUSCluster,x
	TAX

	LDA #$01
	STA.l DZ.DSLocIsValid,x

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

TopOrLeftLimit:
	dw $FFF9,$FFF1

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
GraphicRoutine:

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

	LDA !Palette,x
	AND #$0E
	STA !ScratchD

	%GetVramDisp(DZ.DSLocUSCluster)
	STA !ScratchE

    STZ !Scratch3                       ;$02 = Free Slot but in 16bits
    STY !Scratch2

    STZ !Scratch5
    LDA !GlobalFlip,x   
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

	PHX
	LDA.l DZ.DSLocUSCluster,x
	TAX
	LDA.l DZ.DSLocSharedFrame,x
    STA !Scratch6                       ;$06 = Frame Index but in 16bits
	PLX

    REP #$30                            ;A/X/Y 16bits mode
    LDY !Scratch4                       ;Y = Global Flip
    LDA !Scratch6
    ASL
	CLC
    ADC FramesFlippers,y
    TAX                                 ;X = Frame Index

	LDA #$0000
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
	LDA #$02
	JSR CheckPosition
	BCC ++

	LDA #$01
	STA !Scratch52

    LDA !ScratchE
    STA !TileCode200,y                     ;Set the Tile code of the tile Y

	LDA #$2F
	AND #$F1
	ORA !ScratchD
    EOR !ScratchF
    STA !TileProperty200,y                 ;Set the Tile property of the tile Y

	LDA !Scratch49
	STA !TileXPosition200,y

	LDA !Scratch4B
	STA !TileYPosition200,y

    PHY
	REP #$20                                 
    TYA
	AND #$00FC
	CLC
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

;;All words that starts with '@' and finish with '.' will be replaced by Dyzen

;>Table: FramesFlippers
;>Description: Values used to add values to FramesStartPosition and FramesEndPosition
;To use a flipped version of the frames.
;>ValuesSize: 16
FramesFlippers:
    dw $0000,$000A
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0000,$0001,$0002,$0003,$0004
	dw $0005,$0006,$0007,$0008,$0009
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0001,$0002,$0003,$0004
	dw $0005,$0006,$0007,$0008,$0009
;>EndTable

;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Frame1_XDisp:
	db $FC
Frame1_Frame2_XDisp:
	db $FC
Frame2_Frame3_XDisp:
	db $FD
Frame3_Frame4_XDisp:
	db $FE
Frame4_Frame5_XDisp:
	db $FE
Frame0_Frame1_XDispFlipX:
	db $04
Frame1_Frame2_XDispFlipX:
	db $04
Frame2_Frame3_XDispFlipX:
	db $03
Frame3_Frame4_XDispFlipX:
	db $02
Frame4_Frame5_XDispFlipX:
	db $02
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Frame1_YDisp:
	db $02
Frame1_Frame2_YDisp:
	db $02
Frame2_Frame3_YDisp:
	db $03
Frame3_Frame4_YDisp:
	db $04
Frame4_Frame5_YDisp:
	db $04
Frame0_Frame1_YDispFlipX:
	db $02
Frame1_Frame2_YDispFlipX:
	db $02
Frame2_Frame3_YDispFlipX:
	db $03
Frame3_Frame4_YDispFlipX:
	db $04
Frame4_Frame5_YDispFlipX:
	db $04
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
	LDA #$00
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
	%CheckEvenOrOdd("DZ.DSLocUSCluster")
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
	dw $0008

AnimationLastTransition:
	dw $0000

AnimationIndexer:
	dw $0000

Frames:
	
Animation0_fly_Frames:
	db $00,$01,$02,$03,$04,$03,$02,$01

Times:
	
Animation0_fly_Times:
	db $04,$04,$04,$04,$04,$04,$04,$04
;>End Animations Section

;Don't Delete or write another >Section Hitbox Interaction or >End Section
;All code between >Section Hitboxes Interaction and >End Hitboxes Interaction Section will be changed by Dyzen : Sprite Maker
;>Section Hitboxes Interaction
;>End Hitboxes Interaction Section