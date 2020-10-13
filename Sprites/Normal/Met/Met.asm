;@Met.bin,MetPal1.bin,MetPal2.bin,MetPal3.bin,MetPal4.bin,MetDamagePal.bin
!ResourceIndex = $03
%GFXTabDef(!ResourceIndex)
%GFXDef(00)
%GFXDef(01)
%GFXDef(02)
%GFXDef(03)
%GFXDef(04)
%GFXDef(05)

!MMXExplosion = $03
!MetProjectile = $00

;######################################
;############## Defines ###############
;######################################

!Tile = !ExtendedMiscTable1
!PalAndPage = DZ_FreeRams+$0200

!FrameIndex = !SpriteMiscTable1
!AnimationTimer = !SpriteDecTimer1
!AnimationIndex = !SpriteMiscTable2
!AnimationFrameIndex = !SpriteMiscTable3
!LocalFlip = !SpriteMiscTable4
!GlobalFlip = !SpriteMiscTable5
!Type = !SpriteMiscTable6
!State = !SpriteMiscTable7
!ShootTimer = !SpriteDecTimer2
!ShootMaxTime = !SpriteMiscTable8
!HitPoints = !SpriteMiscTable9
!Started = !ClusterMiscTable7
!HurtPalTimer = !SpriteDecTimer3
!MMXExpCfg = !SpriteMiscTable10
!HSVEffectCanBeDone = $0060|!dp
!HSVEffectHue = $146C|!addr
!HSVEffectValue = $0F3A|!addr
!HSVEffectAddOrDec = $1487|!addr


;######################################
;########### Init Routine #############
;######################################
print "INIT ",pc
	LDA #$00
	STA !GlobalFlip,x
	STA !State,x
	STA !HurtPalTimer,x
	JSL InitWrapperChangeAnimationFromStart

	JSR EXBytes

	LDA !ExtraByte4,x
	AND #$F0
	STA !ShootMaxTime,x
	STA !ShootTimer,x

	LDA !ExtraByte4,x
	AND #$0F
	STA !HitPoints,x

	LDA !ExtraByte2,x
	STA !Type,x

	LDA !CustomSpriteNumber,x
	STA DZ_SDS_SpriteNumber_Normal,x
	LDA !ExtraByte1,x
	AND #$0F
	STA DZ_SDS_PaletteAndPage_Normal,x
	LDA !ExtraByte1,x
	AND #$F0
	STA DZ_SDS_Offset_Normal,x
	STA DZ_SDS_SendOffset_Normal,x

	LDA #$2A
	STA DZ_SDS_Size_Normal,x
	LDA #$00
	STA DZ_SDS_PaletteLoaded_Normal,x
	STA DZ_SDS_Valid_Normal,x

	JSL !FindCopyNormal
    ;Here you can write your Init Code
    ;This will be excecuted when the sprite is spawned 
RTL

EXBytes:
	LDA !ExtraByte1,x
	STA !Scratch0
	LDA !ExtraByte2,x
	STA !Scratch1
	LDA !ExtraByte3,x
	STA !Scratch2
	LDY #$04

	LDA [!Scratch0],y
	STA !MMXExpCfg,x
	DEY 

	LDA [!Scratch0],y
	STA !ExtraByte4,x
	DEY 

	LDA [!Scratch0],y
	STA !ExtraByte3,x
	DEY 

	LDA [!Scratch0],y
	STA !ExtraByte2,x
	DEY 

	LDA [!Scratch0],y
	STA !ExtraByte1,x
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

Pal:
	db $81,$91,$A1,$B1,$C1,$D1,$E1,$F1
PalBNK:
	db !GFX01>>16,!GFX02>>16,!GFX03>>16,!GFX04>>16
PalAddr:
	dw !GFX01,!GFX02,!GFX03,!GFX04
;>Routine: SpriteCode
;>Description: This routine excecute the logic of the sprite
;>RoutineLength: Short
SpriteCode:

	LDA DZ_SDS_PaletteLoaded_Normal,x
	BEQ +
	JMP ++
+
	LDA #$01
	STA DZ_SDS_PaletteLoaded_Normal,x

	PHX
	LDA DZ_SDS_PaletteAndPage_Normal,x
	LSR
	TAX

	LDA.l Pal,x
	STA !Scratch0
	PLX

	LDA !Type,x
	TAY
	LDA.w PalBNK,y
	STA !Scratch3

	LDA !Type,x
	ASL
	TAY
	REP #$20
	LDA.w PalAddr,y
	STA !Scratch1
	SEP #$20

	%TransferToCGRAM(!Scratch0, !Scratch1, !Scratch3, #$001E)
	%TransferToCGRAM(#$F1, #!GFX05, #!GFX05>>16, #$001E)

	LDA !Type,x
	TAY

	LDA !HSVEffectCanBeDone,y
	BNE ++

	LDA #$01
	STA !HSVEffectCanBeDone,y
++

	LDA DZ_SDS_Valid_Normal,x
	BNE +
	LDA.b #!GFX00>>16
	STA !ScratchA
	STZ !ScratchB
	REP #$20
	LDA.w #!GFX00
	STA !Scratch6
	SEP #$20
	JSL !LoadGraphicsSDSNormal
	LDA DZ_SDS_Valid_Normal,x
	BNE +
RTS
+

    JSR GraphicRoutine                  ;Calls the graphic routine and updates sprite graphics

    ;Here you can put code that will be excecuted each frame even if the sprite is locked

    LDA !SpriteStatus,x			        
	BEQ Return
	CMP #$02
	BEQ Return	

	LDA !LockAnimationFlag				    
	BNE Return			                    ;if locked animation return.

    %SubOffScreen()

    JSR InteractMarioSprite
    ;After this routine, if the sprite interact with mario, Carry is Set.

    ;Here you can write your sprite code routine
    ;This will be excecuted once per frame excepts when 
    ;the animation is locked or when sprite status is not #$08
	JSR StateMachine

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw
    
    RTS
Return:
RTS

;>EndRoutine

;######################################
;######## Sub Routine Space ###########
;######################################

HueTab: db $0B,$00,$15,$05
;Here you can write routines or tables
StateMachine:
	LDA !Type,x
	TAY

	LDA !HSVEffectCanBeDone,y
	CMP #$02
	BCS +
	
	LDA #$02
	STA !HSVEffectCanBeDone,y
	LDA #$01
	STA !HSVEffectAddOrDec,y
	LDA #$10
	STA !HSVEffectValue,y

	PHX

	LDA.w PalBNK,y
	STA $02
	TYA
	ASL
	TAY

	REP #$20
	LDA.w PalAddr,y
	STA $00

	LDY #$10
	LDA [$00],y
	STA DZ_FreeRams+$019A
	INY
	INY
	LDA [$00],y
	STA DZ_FreeRams+$019C
	INY
	INY
	LDA [$00],y
	STA DZ_FreeRams+$019E

	SEP #$20

	LDA DZ_SDS_PaletteAndPage_Normal,x
	LSR
	TAX

	LDA.l Pal,x
	CLC
	ADC #$08
	STA !Scratch0
	STZ !Scratch1

	%SetBaseAsHSVWithWithDestSrcAndOffsetNoConstant($0006, DZ_PPUMirrors_CGRAM_BasePalette, #DZ_FreeRams+$019A, !Scratch0)
	PLX
+
	
	LDA !EffectiveFrameCounter
	AND #$01
	BEQ +
	JMP +++
+
	LDA !Type,x
	TAY

	LDA.w HueTab,y
	STA !HSVEffectHue,y
	
	LDA !HSVEffectValue,y
	CLC
	ADC !HSVEffectAddOrDec,y
	STA !HSVEffectValue,y
	CMP #$04
	BCS +
	LDA #$01
	STA !HSVEffectAddOrDec,y
	LDA #$05
	STA !HSVEffectValue,y
	BRA ++
+
	CMP #$20
	BCC ++

	LDA #$FF
	STA !HSVEffectAddOrDec,y
	LDA #$1E
	STA !HSVEffectValue,y
++
	PHX
	LDA DZ_SDS_PaletteAndPage_Normal,x
	LSR
	TAX

	LDA.l Pal,x
	CLC
	ADC #$08
	STA !Scratch0
	STZ !Scratch1

	LDA !HSVEffectHue,y
	STA !Scratch2
	LDA !HSVEffectValue,y
	STA !Scratch3

	%ChangePaletteHueAndSaturationWithOffsetNoConstant("!Scratch2", "!Scratch3", $0006, "!Scratch0")
	PLX

	PHX
	LDA DZ_SDS_PaletteAndPage_Normal,x
	LSR
	TAX

	STZ !Scratch1
	LDA #$00
	XBA
	LDA.l Pal,x
	CLC
	ADC #$08
	STA !Scratch0
	REP #$20
	CLC
	ASL
	CLC
	ADC #DZ_PPUMirrors_CGRAM_PaletteWriteMirror
	STA !Scratch2
	SEP #$20

	%TransferToCGRAM(!Scratch0, !Scratch2, #DZ_PPUMirrors_CGRAM_PaletteWriteMirror>>16, #$0006)
	PLX
+++

	STZ !SpriteXSpeed,x

	LDA !State,x
	ASL
	TAX

	JSR (States,x)

	LDA !SpriteBlockedStatus_ASB0UDLR,x
	AND #$24
	BEQ ++
	LDA !SpriteXSpeed,x
	BEQ +
++
	JSL $01802A|!rom
+
RTS

States:
	dw Hide
	dw Walk
	dw Shoot

TransitionToAnimation1AFI:
	db $02,$01,$00,$02,$02,$02,$02
TransitionToAnimation1F:
	db $00,$01,$02,$02,$02,$02,$02
	
Hide:
	LDX !SpriteIndex
	LDA !AnimationIndex,x
	CMP #$01
	BEQ +
	
	LDA !FrameIndex,x
	TAY
	LDA.w TransitionToAnimation1AFI,y
	PHA
	LDA.w TransitionToAnimation1F,y
	PHA
	JSR ChangeAnimationFromStart_Hide
	PLA
	STA !FrameIndex,x
	PLA
	STA !AnimationFrameIndex,x
RTS
+

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	CMP !PlayerX
	SEP #$20
	BCC +

	LDA #$00
	STA !GlobalFlip,x
	BRA ++
+
	LDA #$01
	STA !GlobalFlip,x
++

	LDA !GlobalFlip,x
	TAY
	CMP !PlayerDirection
	BNE +
	LDA !SpinJumpFlag
	BNE +
	LDA #$01
	STA !State,x
+

	LDA !SpriteBlockedStatus_ASB0UDLR,x
	AND.w CheckWall,y
	BEQ +
	STZ !State,x
+

	LDA !ShootTimer,x
	BNE +
	
	LDA !ShootMaxTime,x
	STA !ShootTimer,x

	LDA #$02
	STA !State,x
+
RTS

TransitionToAnimation0AFI:
	db $00,$01,$02,$03,$04,$04,$04
TransitionToAnimation0F:
	db $00,$01,$02,$03,$02,$02,$02
Walk:
	LDX !SpriteIndex

	LDA !GlobalFlip,x
	TAY
	LDA !SpriteBlockedStatus_ASB0UDLR,x
	AND.w CheckWall,y
	BEQ +
	STZ !State,x
	STZ !SpriteXSpeed,x
	LDA !ShootMaxTime,x
	STA !ShootTimer,x
RTS
+

	LDA !AnimationIndex,x
	CMP #$01
	BEQ +
	CMP #$03
	BNE ++	
+
	LDA !FrameIndex,x
	TAY
	LDA.w TransitionToAnimation0AFI,y
	PHA
	LDA.w TransitionToAnimation0F,y
	PHA
	JSR ChangeAnimationFromStart_HideOut
	PLA
	STA !FrameIndex,x
	PLA
	STA !AnimationFrameIndex,x
RTS
++
	LDA !AnimationIndex,x
	BNE +

	LDA !AnimationFrameIndex,x
	CMP #$04
	BNE +

	LDA !AnimationTimer,x
	BNE +

	JSR ChangeAnimationFromStart_Walk
+

	LDA !AnimationIndex,x
	CMP #$02
	BNE +

	LDA !GlobalFlip,x
	BNE ++
	LDA !ExtraByte3,x
	EOR #$FF
	INC A
	STA !SpriteXSpeed,x

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	CMP !PlayerX
	SEP #$20
	BCS +++
	STZ !State,x
	STZ !SpriteXSpeed,x
	LDA !ShootMaxTime,x
	STA !ShootTimer,x
RTS
+++

	BRA +
++
	LDA !ExtraByte3,x
	STA !SpriteXSpeed,x

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	CMP !PlayerX
	SEP #$20
	BCC +++
	STZ !State,x
	STZ !SpriteXSpeed,x
	LDA !ShootMaxTime,x
	STA !ShootTimer,x
RTS
+++
+	

	LDA !SpinJumpFlag
	BNE +
	LDA !GlobalFlip,x
	CMP !PlayerDirection
	BEQ +
	STZ !State,x
	STZ !SpriteXSpeed,x
	LDA !ShootMaxTime,x
	STA !ShootTimer,x
+
RTS

CheckWall:
	db $02,$01

Shoot:
	LDX !SpriteIndex

	LDA !AnimationIndex,x
	CMP #$03
	BEQ +

	JSR ChangeAnimationFromStart_Shoot
RTS
+
	LDA !AnimationFrameIndex,x
	CMP #$02
	BNE +

	LDA !AnimationTimer,x
	CMP #$02
	BNE +

	JSR Spawn

	LDA !Type,x
	AND #$01
	BNE +
	JSR SpawnDown
	JSR SpawnUp

RTS
+

	LDA !AnimationFrameIndex,x
	CMP #$04
	BNE +

	LDA !AnimationTimer,x
	BNE +

	STZ !State,x
	STZ !SpriteXSpeed,x
	LDA !ShootMaxTime,x
	STA !ShootTimer,x
+
RTS

SpawnDown:

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	SEC
	SBC !PlayerY
	SEC
	SBC #$001C
	STA !Scratch2
	SEP #$20
	BRA SpawnBullet

SpawnUp:

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	SEC
	SBC !PlayerY
	SEC
	SBC #$FFF4
	STA !Scratch2
	SEP #$20
	BRA SpawnBullet

Spawn:

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	SEC
	SBC !PlayerY
	SEC
	SBC #$000C
	STA !Scratch2
	SEP #$20

SpawnBullet:
	LDA !GlobalFlip,x
	ASL
	TAY

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	SEC
	SBC !PlayerX
	CLC
	ADC.w XadderSpawn,y
	STA !Scratch0
	SEP #$20

	LDA #$20
	%Aiming()

	LDA !Scratch2
	STA !Scratch3

	LDA !Scratch0
	STA !Scratch2

	LDA #$08
	STA !Scratch1

	LDA !GlobalFlip,x
	ASL
	TAY

	LDA XadderSpawn,y
	STA !Scratch0

	LDA #!MetProjectile
	CLC
	ADC #!ExtendedOffset
	%SpawnExtended()
	BCS +

	LDA #$F0
	STA !ExtendedMiscTable2,y

	LDA DZ_SDS_Offset_Normal,x
	CLC
	ADC #$08
	STA !Tile,y

	LDA !Type,x
	ASL
	ASL
	ASL
	ASL
	ORA DZ_SDS_PaletteAndPage_Normal,x
	TYX
	STA !PalAndPage,x

	LDX !SpriteIndex

+
RTS

XadderSpawn:
	dw $0004,$000C
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
GraphicRoutine:

    %GetDrawInfo()                     ;Calls GetDrawInfo to get the free slot and the XDisp and YDisp

	LDA DZ_SDS_PaletteAndPage_Normal,x
	STA !ScratchE

	LDA !HurtPalTimer,x
	BEQ +

	LDA !ScratchE
	ORA #$0E
	STA !ScratchE

+

	LDA DZ_SDS_Offset_Normal,x
	STA !ScratchD

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
	ADC !ScratchD
    STA !TileCode,y                     ;Set the Tile code of the tile Y

	LDA #$2F
	AND #$F0
	ORA !ScratchE
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
    dw $0004,$0007,$0004,$0004,$0004,$0004,$0003
	dw $0004,$0007,$0004,$0004,$0004,$0004,$0003
;>EndTable


;>Table: FramesFlippers
;>Description: Values used to add values to FramesStartPosition and FramesEndPosition
;To use a flipped version of the frames.
;>ValuesSize: 16
FramesFlippers:
    dw $0000,$000E
;>EndTable


;>Table: FramesStartPosition
;>Description: Indicates the index where starts each frame
;>ValuesSize: 16
FramesStartPosition:
    dw $0004,$000C,$0011,$0016,$001B,$0020,$0024
	dw $0029,$0031,$0036,$003B,$0040,$0045,$0049
;>EndTable

;>Table: FramesEndPosition
;>Description: Indicates the index where end each frame
;>ValuesSize: 16
FramesEndPosition:
    dw $0000,$0005,$000D,$0012,$0017,$001C,$0021
	dw $0025,$002A,$0032,$0037,$003C,$0041,$0046
;>EndTable


;>Table: Tiles
;>Description: Tiles codes of each tile of each frame
;>ValuesSize: 8
Tiles:
    
Frame0_Hide0_Tiles:
	db $16,$17,$18,$06,$07
Frame1_Hide1_Tiles:
	db $20,$21,$22,$16,$17,$18,$06,$07
Frame2_Hide2_Tiles:
	db $0D,$0E,$0F,$00,$01
Frame3_Hide3_Tiles:
	db $00,$01,$1D,$1E,$1F
Frame4_Walk0_Tiles:
	db $09,$25,$26,$29,$28
Frame5_Walk1_Tiles:
	db $0B,$25,$26,$27,$29
Frame6_Walk2_Tiles:
	db $03,$04,$23,$24
Frame0_Hide0_TilesFlipX:
	db $16,$17,$18,$06,$07
Frame1_Hide1_TilesFlipX:
	db $20,$21,$22,$16,$17,$18,$06,$07
Frame2_Hide2_TilesFlipX:
	db $0D,$0E,$0F,$00,$01
Frame3_Hide3_TilesFlipX:
	db $00,$01,$1D,$1E,$1F
Frame4_Walk0_TilesFlipX:
	db $09,$25,$26,$29,$28
Frame5_Walk1_TilesFlipX:
	db $0B,$25,$26,$27,$29
Frame6_Walk2_TilesFlipX:
	db $03,$04,$23,$24
;>EndTable

;>Table: XDisplacements
;>Description: X Displacement of each tile of each frame
;>ValuesSize: 8
XDisplacements:
    
Frame0_Hide0_XDisp:
	db $00,$08,$10,$02,$0A
Frame1_Hide1_XDisp:
	db $00,$08,$10,$00,$08,$10,$02,$0A
Frame2_Hide2_XDisp:
	db $00,$08,$10,$00,$08
Frame3_Hide3_XDisp:
	db $00,$08,$00,$08,$10
Frame4_Walk0_XDisp:
	db $FF,$02,$0A,$0F,$0F
Frame5_Walk1_XDisp:
	db $00,$02,$0A,$10,$0F
Frame6_Walk2_XDisp:
	db $00,$08,$00,$08
Frame0_Hide0_XDispFlipX:
	db $0E,$06,$FE,$0C,$04
Frame1_Hide1_XDispFlipX:
	db $0E,$06,$FE,$0E,$06,$FE,$0C,$04
Frame2_Hide2_XDispFlipX:
	db $0E,$06,$FE,$06,$FE
Frame3_Hide3_XDispFlipX:
	db $06,$FE,$0E,$06,$FE
Frame4_Walk0_XDispFlipX:
	db $07,$0C,$04,$FF,$FF
Frame5_Walk1_XDispFlipX:
	db $06,$0C,$04,$FE,$FF
Frame6_Walk2_XDispFlipX:
	db $06,$FE,$0E,$06
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Hide0_YDisp:
	db $08,$08,$08,$00,$00
Frame1_Hide1_YDisp:
	db $0E,$0E,$0E,$06,$06,$06,$FE,$FE
Frame2_Hide2_YDisp:
	db $09,$09,$09,$F9,$F9
Frame3_Hide3_YDisp:
	db $F8,$F8,$08,$08,$08
Frame4_Walk0_YDisp:
	db $00,$F8,$F8,$00,$08
Frame5_Walk1_YDisp:
	db $00,$F8,$F8,$08,$00
Frame6_Walk2_YDisp:
	db $FB,$FB,$0B,$0B
Frame0_Hide0_YDispFlipX:
	db $08,$08,$08,$00,$00
Frame1_Hide1_YDispFlipX:
	db $0E,$0E,$0E,$06,$06,$06,$FE,$FE
Frame2_Hide2_YDispFlipX:
	db $09,$09,$09,$F9,$F9
Frame3_Hide3_YDispFlipX:
	db $F8,$F8,$08,$08,$08
Frame4_Walk0_YDispFlipX:
	db $00,$F8,$F8,$00,$08
Frame5_Walk1_YDispFlipX:
	db $00,$F8,$F8,$08,$00
Frame6_Walk2_YDispFlipX:
	db $FB,$FB,$0B,$0B
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Hide0_Sizes:
	db $00,$00,$00,$00,$00
Frame1_Hide1_Sizes:
	db $00,$00,$00,$00,$00,$00,$00,$00
Frame2_Hide2_Sizes:
	db $00,$00,$00,$02,$02
Frame3_Hide3_Sizes:
	db $02,$02,$00,$00,$00
Frame4_Walk0_Sizes:
	db $02,$00,$00,$00,$00
Frame5_Walk1_Sizes:
	db $02,$00,$00,$00,$00
Frame6_Walk2_Sizes:
	db $02,$02,$00,$00
Frame0_Hide0_SizesFlipX:
	db $00,$00,$00,$00,$00
Frame1_Hide1_SizesFlipX:
	db $00,$00,$00,$00,$00,$00,$00,$00
Frame2_Hide2_SizesFlipX:
	db $00,$00,$00,$02,$02
Frame3_Hide3_SizesFlipX:
	db $02,$02,$00,$00,$00
Frame4_Walk0_SizesFlipX:
	db $02,$00,$00,$00,$00
Frame5_Walk1_SizesFlipX:
	db $02,$00,$00,$00,$00
Frame6_Walk2_SizesFlipX:
	db $02,$02,$00,$00
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
	LDA #$01
	STA !AnimationIndex,x
	JSR ChangeAnimationFromStart
	PLB
	RTL

ChangeAnimationFromStart_HideOut:
	STZ !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_Hide:
	LDA #$01
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_Walk:
	LDA #$02
	STA !AnimationIndex,x
	JMP ChangeAnimationFromStart
ChangeAnimationFromStart_Shoot:
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
	dw $0005,$0003,$0004,$0005

AnimationLastTransition:
	dw $0004,$0002,$0000,$0004

AnimationIndexer:
	dw $0000,$0005,$0008,$000C

Frames:
	
Animation0_HideOut_Frames:
	db $00,$01,$02,$03,$02
Animation1_Hide_Frames:
	db $02,$01,$00
Animation2_Walk_Frames:
	db $05,$06,$04,$02
Animation3_Shoot_Frames:
	db $00,$01,$02,$01,$00

Times:
	
Animation0_HideOut_Times:
	db $06,$06,$06,$02,$06
Animation1_Hide_Times:
	db $06,$06,$06
Animation2_Walk_Times:
	db $06,$06,$06,$06
Animation3_Shoot_Times:
	db $06,$06,$06,$06,$06
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
	BCC +
	LDA !ScratchE
	CMP #$01
	BNE +

	JSR DefaultAction
	LDA !SpriteStatus,x
	BNE +
RTS
+
	LDX #!MaxSprites-1
-
	PHX
	LDA !SpriteStatus,x
	CMP #$09
	BEQ +
	CMP #$0A
	BNE .next
+
	STX !Scratch45

	JSL $03B6E5|!rom

	LDX !SpriteIndex
	JSR Interaction
	BCC .next
	LDA !ScratchE
	CMP #$01
	BNE .next

	PLX
	JSR SpriteSpriteAction
	SEC
RTS
.next
	PLX
	DEX
	BPL -

	LDX #$09
-
	PHX
	LDA !ExtendedSpriteNumber,x
	CMP #$01
	BEQ +
	CMP #$05
	BNE .next2
+
	STX !Scratch45
	TXY

	PHK                       ;\This will push the 24-bit address location
	PEA.w .jslrtsreturn-1     ;/after the JML (below) into the stack*
	PEA $A772-1               ;>This modifies the RTS in the pointed routine (below) to jump to an RTL in same bank.*
                              ;^This RTL then pulls the stack (which is the 24-bit address) to jump to a location after the JML
	JML $02A547|!rom          ;>The desired routine that ends with RTS

.jslrtsreturn
	LDX !SpriteIndex
	JSR Interaction
	BCC .next2
	LDA !ScratchE
	CMP #$01
	BNE .next2

	PLX
	JSR SpriteFireballAction
	SEC
RTS
.next2
	PLX
	DEX
	BPL -

ReturnNoContact2:
	LDX !SpriteIndex
	CLC
	RTS

Interaction:
    STZ !ScratchE
	LDA !GlobalFlip,x
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
    dw $0000,$000E

FrameHitboxesIndexer:
    dw $0000,$0002,$0004,$0006,$0008,$000A,$000C
	dw $000E,$0010,$0012,$0014,$0016,$0018,$001A

FrameHitBoxes:
    db $00,$FF
	db $00,$FF
	db $01,$FF
	db $01,$FF
	db $01,$FF
	db $01,$FF
	db $01,$FF
	
	db $02,$FF
	db $02,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	

HitboxesStart:
    dw $0000,$0006,$000C,$0012

Hitboxes:
    db $01,$04,$07,$0D,$09,$00
	db $01,$04,$FF,$0D,$11,$00
	db $01,$05,$07,$0D,$09,$00
	db $01,$05,$FF,$0D,$11,$00
	

;This routine will be executed when mario interact with a standar hitbox.
;It will be excecuted if $0E is 1 after execute Interaction routine
DefaultAction:
	LDX !SpriteIndex

	JSR SpikyInteraction
RTS
    
;>End Hitboxes Interaction Section
;>End Hitboxes Interaction Section
SpikyInteraction:
    LDA $1490|!addr ;if player is using the star
    BEQ +           ;kill the sprite
	%Star()
    RTS
+
	LDA !PlayerYSpeed	;\
	CMP !SpriteYSpeed,x	;/
	BMI +++				;other wise check the position of the player
 
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
	LDA !RidingYoshi
	AND #$00FF
	BNE ++
	LDA !SpinJumpFlag
	AND #$00FF
	BEQ +++

++
    SEP #$20            ;/
 
    JSL $01AB99|!rom    ;Display White Star                
    JSL $01AA33|!rom    ;Do the player boost its Y Speed   
 
	LDA #$02
    STA $1DF9|!addr     ;Play Spin Jump Sound

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

SpriteSpriteAction:
	LDX !Scratch45

	STZ !SpriteStatus,x
	
	STZ $00 : STZ $01
	LDA #$1B : STA $02
	LDA #$01
	%SpawnSmoke()

	LDX !SpriteIndex

	LDA !FrameIndex,x
	CMP #$02
	BCS +
RTS
+
	LDA !HitPoints,x
	BEQ +
	DEC A
	STA !HitPoints,x

	LDA #$08
	STA !HurtPalTimer,x
	
RTS
+
	STZ !SpriteStatus,x

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	STA !Scratch0
	SEP #$20

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	STA !Scratch2
	SEP #$20

	LDA #$04
	STA !Scratch4
	STZ !Scratch5

	LDA #!MMXExplosion
    CLC
    ADC #!ClusterOffset
	%SpawnCluster()
	BCC +
	LDA #$00
	STA !Started,y

	TYX
	LDA #$0D
	STA DZ_SDS_PaletteAndPage_Cluster,x
	LDA #$00
	STA DZ_SDS_Offset_Cluster,x
	STA DZ_SDS_SendOffset_Cluster,x
+
	LDX !SpriteIndex
RTS

SpriteFireballAction:
	LDX !Scratch45

	STZ !ExtendedSpriteNumber,x
	
	STZ $00 : STZ $01
	LDA #$1B : STA $02
	LDA #$01
	%SpawnSmoke()
	BCS +

	LDA !ExtendedYLow,x
	SEC
	SBC #$04
	STA $17C4|!Base2,y      ; /

	LDA !ExtendedXLow,x
	SEC
	SBC #$04
	STA $17C8|!Base2,y      ; /
	
+
	LDX !SpriteIndex

	LDA !FrameIndex,x
	CMP #$02
	BCS +
RTS
+
	LDA !HitPoints,x
	BEQ +
	DEC A
	STA !HitPoints,x

	LDA #$08
	STA !HurtPalTimer,x
	
RTS
+
	STZ !SpriteStatus,x

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	STA !Scratch0
	SEP #$20

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	STA !Scratch2
	SEP #$20

	LDA #$04
	STA !Scratch4
	STZ !Scratch5

	LDA #!MMXExplosion
    CLC
    ADC #!ClusterOffset
	%SpawnCluster()
	BCC +
	LDA #$00
	STA !Started,y

	TYX
	LDA #$0D
	STA DZ_SDS_PaletteAndPage_Cluster,x
	LDA #$00
	STA DZ_SDS_Offset_Cluster,x
	STA DZ_SDS_SendOffset_Cluster,x
+
	LDX !SpriteIndex
RTS















































