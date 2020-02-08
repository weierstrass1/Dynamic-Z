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
!FlagTimer = !SpriteDecTimer1

;	!RAM_Midway		= $7FB4D9
if !SA1
	!RAM_Midway		= $40D000
else
	!RAM_Midway		= $7ED000
endif

!sprite_extra_bits	= !7FAB10
!sprite_extra_prop_1	= !7FAB28
!sprite_extra_prop_2	= !7FAB34
!sprite_state = !SpriteMiscTable8

;######################################
;########### Init Routine #############
;######################################
print "INIT ",pc
	LDA #$00
	STA !GlobalFlip,x
	STA !sprite_state,x
	STA !FlagTimer,x

	JSL !Reserve32x32NormalSpriteOf30FPS
	BCS +
	RTL
+
	JSL !SendSignal32x32Normal

	LDA	!sprite_extra_prop_1,x
	STA	$00
	BEQ	.normal_midpoint
	LDX	$13BF|!Base2
	LDA	!RAM_Midway,x
	CMP	$00
	BCS	.midpoint_crossed
.midpoint_not_crossed	
	LDX	$15E9|!Base2
	STZ !AnimationIndex,x
	JSL InitWrapperChangeAnimationFromStart
	RTL	
.normal_midpoint	
	LDX	$13BF|!Base2
	LDA	$1EA2|!Base2,x
	AND	#$40
	ORA	$13CE|!Base2
	BEQ	.midpoint_not_crossed
.midpoint_crossed	
	LDX	$15E9|!Base2

	LDA $0DD6|!Base2
	LSR
	LSR
	CLC
	ADC #$02
	STA !AnimationIndex,x
	JSL InitWrapperChangeAnimationFromStart
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
	JSR Main
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
Main:
	LDA !sprite_state,x
	BNE +
RTS
+
	LDA !AnimationIndex,x
	BNE ++

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BNE +
RTS
+
	JSR ChangeAnimationFromStart_change
	LDA #$1F
	STA !FlagTimer,x
RTS
++
	CMP #$01
	BNE ++

	LDA !AnimationFrameIndex,x
	CMP #$03
	BNE ++

	LDA !AnimationTimer,x
	BNE ++

	LDA !TransferFrameNormalSprite,x
	AND #$01
	STA $00

	LDA !DynamicTimer
	AND #$01
	CMP $00
	BNE +
RTS
+
	LDA !FlagTimer,x
	BNE ++

	LDA $0DD6|!Base2
	LSR
	LSR
	CLC
	ADC #$02
	STA !AnimationIndex,x
	JSR ChangeAnimationFromStart
++
RTS

;>Section Dynamic
;######################################
;########## Animation Space ###########
;######################################
ResourceOffset:
    Frame0_ResourceOffset:
	dw $0000,$00C0
Frame1_ResourceOffset:
	dw $0180,$0240
Frame2_ResourceOffset:
	dw $0300,$03C0
Frame3_ResourceOffset:
	dw $0480,$0520
Frame4_ResourceOffset:
	dw $05A0,$0660
Frame5_ResourceOffset:
	dw $0720,$07E0
Frame6_ResourceOffset:
	dw $08A0,$0980
Frame7_ResourceOffset:
	dw $0A40,$0B20
Frame8_ResourceOffset:
	dw $0BE0,$0CC0
Frame9_ResourceOffset:
	dw $0D80,$0E60
Frame10_ResourceOffset:
	dw $0F20,$1000
Frame11_ResourceOffset:
	dw $10C0,$11A0


ResourceSize:
    Frame0_ResourceSize:
	dw $00C0,$00C0
Frame1_ResourceSize:
	dw $00C0,$00C0
Frame2_ResourceSize:
	dw $00C0,$00C0
Frame3_ResourceSize:
	dw $00A0,$0080
Frame4_ResourceSize:
	dw $00C0,$00C0
Frame5_ResourceSize:
	dw $00C0,$00C0
Frame6_ResourceSize:
	dw $00E0,$00C0
Frame7_ResourceSize:
	dw $00E0,$00C0
Frame8_ResourceSize:
	dw $00E0,$00C0
Frame9_ResourceSize:
	dw $00E0,$00C0
Frame10_ResourceSize:
	dw $00E0,$00C0
Frame11_ResourceSize:
	dw $00E0,$00C0

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
incbin "sprites\mid_flag.bin"
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
	db $40,$48,$60,$68
	db $80,$88,$A0,$A8
	db $C0,$C8,$E0,$E8

GraphicRoutine:
	LDA !LastFrameIndex,x
	CMP #$FF
	BNE +
	RTS
+

    %GetDrawInfo()                     ;Calls GetDrawInfo to get the free slot and the XDisp and YDisp

	LDA !15F6,x
	AND #$0E
	STA !ScratchF

	PHX
	LDA	!VRAMDispNormalSprite,x
	TAX  
	LDA OAMOffset,x
	STA !ScratchE
	PLX

    STZ !Scratch3                       ;$02 = Free Slot but in 16bits
    STY !Scratch2


    PHX                                 ;Preserve X
    
    STZ !Scratch7
    LDA !FrameIndex,x
    STA !Scratch6                       ;$06 = Frame Index but in 16bits

    REP #$30                            ;A/X/Y 16bits mode
    LDA !Scratch6
    ASL
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

	LDA #$21
	ORA !ScratchF
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
    dw $0002,$0002,$0002,$0002,$0002,$0002,$0003,$0003,$0003,$0003,$0003,$0003
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0002,$0005,$0008,$000B,$000E,$0011,$0015,$0019,$001D,$0021,$0025,$0029
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0003,$0006,$0009,$000C,$000F,$0012,$0016,$001A,$001E,$0022,$0026
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Frame0_Tiles:
	db $04,$02,$00
Frame1_Frame1_Tiles:
	db $04,$02,$00
Frame2_Frame2_Tiles:
	db $04,$02,$00
Frame3_Frame3_Tiles:
	db $02,$00,$04
Frame4_Frame4_Tiles:
	db $04,$02,$00
Frame5_Frame5_Tiles:
	db $04,$02,$00
Frame6_Frame6_Tiles:
	db $04,$02,$00,$06
Frame7_Frame7_Tiles:
	db $04,$02,$00,$06
Frame8_Frame8_Tiles:
	db $04,$02,$00,$06
Frame9_Frame9_Tiles:
	db $04,$02,$00,$06
Frame10_Frame10_Tiles:
	db $04,$02,$00,$06
Frame11_Frame11_Tiles:
	db $04,$02,$00,$06
;>EndTable

;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Frame0_XDisp:
	db $05,$05,$0D
Frame1_Frame1_XDisp:
	db $05,$05,$0D
Frame2_Frame2_XDisp:
	db $05,$05,$0D
Frame3_Frame3_XDisp:
	db $05,$09,$11
Frame4_Frame4_XDisp:
	db $05,$05,$0D
Frame5_Frame5_XDisp:
	db $00,$05,$0C
Frame6_Frame6_XDisp:
	db $05,$05,$0E,$16
Frame7_Frame7_XDisp:
	db $05,$05,$0E,$16
Frame8_Frame8_XDisp:
	db $05,$05,$0E,$12
Frame9_Frame9_XDisp:
	db $05,$05,$0E,$16
Frame10_Frame10_XDisp:
	db $05,$05,$0E,$16
Frame11_Frame11_XDisp:
	db $05,$05,$0E,$12
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Frame0_YDisp:
	db $F0,$00,$FB
Frame1_Frame1_YDisp:
	db $F0,$00,$FA
Frame2_Frame2_YDisp:
	db $F0,$00,$FC
Frame3_Frame3_YDisp:
	db $00,$F1,$01
Frame4_Frame4_YDisp:
	db $F0,$00,$FB
Frame5_Frame5_YDisp:
	db $F1,$00,$F8
Frame6_Frame6_YDisp:
	db $F0,$00,$F6,$06
Frame7_Frame7_YDisp:
	db $F0,$00,$F5,$05
Frame8_Frame8_YDisp:
	db $F0,$00,$F5,$05
Frame9_Frame9_YDisp:
	db $F0,$00,$F6,$06
Frame10_Frame10_YDisp:
	db $F0,$00,$F5,$05
Frame11_Frame11_YDisp:
	db $F0,$00,$F5,$05
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Frame0_Sizes:
	db $02,$02,$02
Frame1_Frame1_Sizes:
	db $02,$02,$02
Frame2_Frame2_Sizes:
	db $02,$02,$02
Frame3_Frame3_Sizes:
	db $02,$02,$00
Frame4_Frame4_Sizes:
	db $02,$02,$02
Frame5_Frame5_Sizes:
	db $02,$02,$02
Frame6_Frame6_Sizes:
	db $02,$02,$02,$00
Frame7_Frame7_Sizes:
	db $02,$02,$02,$00
Frame8_Frame8_Sizes:
	db $02,$02,$02,$00
Frame9_Frame9_Sizes:
	db $02,$02,$02,$00
Frame10_Frame10_Sizes:
	db $02,$02,$02,$00
Frame11_Frame11_Sizes:
	db $02,$02,$02,$00
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
	JSR ChangeAnimationFromStart
	PLB
	RTL

ChangeAnimationFromStart_enemy:
	STZ !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_change:
	LDA #$01
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_mario:
	LDA #$02
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_luigi:
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

	LDA !Scratch2
	STA !AnimationFrameIndex,x

	SEP #$10						;X/Y of 8 bits
	LDX !Scratch4					;X = sprite index in 8 bits
RTS
;>EndRoutine

;All words that starts with '>' and finish with '.' will be replaced by Dyzen

AnimationLenght:
	dw $0003,$0004,$0003,$0003

AnimationLastTransition:
	dw $0000,$0000,$0000,$0000

AnimationIndexer:
	dw $0000,$0003,$0007,$000A

Frames:
	
Animation0_enemy_Frames:
	db $00,$01,$02
Animation1_change_Frames:
	db $03,$04,$05,$04
Animation2_mario_Frames:
	db $06,$07,$08
Animation3_luigi_Frames:
	db $09,$0A,$0B

Times:
	
Animation0_enemy_Times:
	db $06,$06,$06
Animation1_change_Times:
	db $04,$04,$04,$04
Animation2_mario_Times:
	db $06,$06,$06
Animation3_luigi_Times:
	db $06,$06,$06
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
    LDA !FrameIndex,x
	STA !Scratch4
	STZ !Scratch5

    REP #$20
	LDA !Scratch4
	ASL
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

FrameHitboxesIndexer:
    dw $0000,$0002,$0004,$0006,$0007,$0008,$0009,$000A,$000B,$000C,$000D,$000E

FrameHitBoxes:
    db $00,$FF
	db $01,$FF
	db $02,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	

HitboxesStart:
    dw $0000,$0006,$000C

Hitboxes:
    db $01,$FF,$00,$0B,$0E,$00
	db $01,$FE,$01,$0B,$0E,$00
	db $01,$FF,$01,$09,$0E,$00
	

;This routine will be executed when mario interact with a standar hitbox.
;It will be excecuted if $0E is 1 after execute Interaction routine
DefaultAction:
	LDX !SpriteIndex

	LDA !sprite_state,x
	BEQ +
RTS
+
	INC	!sprite_state,x

	LDA	!sprite_extra_prop_1,x
	BEQ	.normal_midpoint
	LDX	$13BF|!Base2
	STA	!RAM_Midway,x
.normal_midpoint	
	LDX	$15E9|!Base2

	LDA	#$01
	STA	$13CE|!Base2
	LDA	$19
	BNE	.already_big
	LDA	#$02
	STA	$71
	LDA	#$2F
	STA	$1496|!Base2
	STA	$9D
.already_big		
	LDA	#$05
	STA	$1DF9|!Base2
RTS
    
;>End Hitboxes Interaction Section