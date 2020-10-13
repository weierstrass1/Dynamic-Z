;@Zinger.bin
!ResourceIndex = $02
%GFXTabDef(!ResourceIndex)
%GFXDef(00)

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

!MovTypeY = !ExtraByte2
!MaxSpeedX = !ExtraByte3
!MaxSpeedY = !ExtraByte4
!AccelX = !SpriteMiscTable9
!AccelY = !SpriteMiscTable10
!AngleLow = !SpriteMiscTable11
!AngleHigh = !SpriteMiscTable12
!AngleSpeed = !SpriteMiscTable13
!AmplitudeX = !SpriteMiscTable14
!AmplitudeY = !SpriteMiscTable15
!PosXL = !Variables+$0800-!MaxSprites
!PosXH = !PosXL-!MaxSprites
!PosYL = !PosXH-!MaxSprites
!PosYH = !PosYL-!MaxSprites
!MovTypeX = !PosYH-!MaxSprites
!PhaseLow = !MovTypeX-!MaxSprites
!PhaseHigh = !PhaseLow-!MaxSprites
!RatioX = !PhaseHigh-!MaxSprites
!RatioY = !RatioX-!MaxSprites
!RatioIncreaseX = !RatioY-!MaxSprites
!RatioIncreaseY = !RatioIncreaseX-!MaxSprites
!RatioIncreaseTimerX = !RatioIncreaseY-!MaxSprites
!RatioIncreaseTimerY = !RatioIncreaseTimerX-!MaxSprites
!RatioAccelX = !RatioIncreaseTimerY-!MaxSprites
!RatioAccelY = !RatioAccelX-!MaxSprites
!RatioMaxX = !RatioAccelY-!MaxSprites
!RatioMaxY = !RatioMaxX-!MaxSprites
!Hitpoints = !RatioMaxY-!MaxSprites

;1 => Basic Dynamic Sprite Extra Byte
;2 => xxxx yyyy, Movement Type, xxxx = For X Axis, yyyy = For Y Axis
;3 => xxxx yyyy, Speed on Constant Movement, Max Speed on Follow Movement, xxxx = For X Axis, yyyy = For Y Axis
;4 => xxxx yyyy, Acceleration on Follow Movement, xxxx = For X Axis, yyyy = For Y Axis
;5 => xxxx xxxx, Phase Angle for Types 3 or more (Min value $00, Max Value $B3)
;6 => xxxx xxxx, Angle Speed for Types 3 or more
;7 => xxxx yyyy, Amplitude for Types 3 or more, xxxx = For X Axis, yyyy = For Y Axis
;8 => xxxx yyyy, Ratio for Types 3 or more, xxxx = For X Axis, yyyy = For Y Axis
;9 => xxxx yyyy, Ratio Increase for Types 3 or more, xxxx = For X Axis, yyyy = For Y Axis

;######################################
;########### Init Routine #############
;######################################
print "INIT ",pc
	LDA #$02
	STA !Hitpoints,x
	LDA #$00
	STA !GlobalFlip,x
	STA !State,x
	LDA #$FF
	STA !LastFrameIndex,x

	LDA #$00
	STA !AngleLow,x
	STA !AngleHigh,x
	STA !RatioIncreaseTimerX,x
	STA !RatioIncreaseTimerY,x

	LDA !SpriteXLow,x
	STA !PosXL,x
	LDA !SpriteXHigh,x
	STA !PosXH,x

	LDA !SpriteYLow,x
	STA !PosYL,x
	LDA !SpriteYHigh,x
	STA !PosYH,x

	JSR SetMiscs

	
	LDA !MovTypeX,x
	TAX
	LDA.l MustSetInitialAngle,x
	PHA
	LDA !MovTypeY,x
	TAX
	PLA
	ORA.l MustSetInitialAngle,x
	BEQ +
	LDX !SpriteIndex
	LDA !PhaseLow,x
	STA !AngleLow,x
	LDA !PhaseHigh,x
	STA !AngleHigh,x
+
	LDX !SpriteIndex

	LDA !MovTypeX,x
	TAX
	LDA.l HasConstSpeed,x
	BNE +
	LDX !SpriteIndex

	STZ !SpriteXSpeed,x
	BRA ++
+
	LDX !SpriteIndex

	LDA !MaxSpeedX,x
	STA !SpriteXSpeed,x
++
	LDA !MovTypeY,x
	TAX
	LDA.l HasConstSpeed,x
	BNE +
	LDX !SpriteIndex
	STZ !SpriteYSpeed,x
	BRA ++
+
	LDX !SpriteIndex
	LDA !MaxSpeedY,x
	STA !SpriteYSpeed,x
++
	JSL !CheckNormalSharedDynamicExisted
	BCS +
	JSL InitWrapperChangeAnimationFromStart

	%CheckSlotNormalSprite(#$08, $80)

	PHB
	PHK
	PLB
	JSR MovementState
	PLB
    ;Here you can write your Init Code
    ;This will be excecuted when the sprite is spawned 
RTL
+
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAY

	LDA !LocalFlip,y
	STA !LocalFlip,x

	LDA !AnimationIndex,y
	STA !AnimationIndex,x

	LDA !AnimationTimer,y
	STA !AnimationTimer,x

	LDA !AnimationFrameIndex,y
	STA !AnimationFrameIndex,x

	LDA !FrameIndex,y
	STA !FrameIndex,x

	PHB
	PHK
	PLB
	JSR MovementState
	PLB
RTL

HasConstSpeed:
	db $00,$01,$00,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00
MustSetInitialAngle:
	db $00,$00,$00,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

SetMiscs:
	LDA !ExtraByte1,x
	STA !Scratch0
	LDA !ExtraByte2,x
	STA !Scratch1
	LDA !ExtraByte3,x
	STA !Scratch2

	LDY #$00
	LDA [!Scratch0],y
	STA !ExtraByte1,x
	INY 

	;Mov Type
	LDA [!Scratch0],y
	LSR
	LSR
	LSR
	LSR
	STA !MovTypeX,x
	LDA [!Scratch0],y
	AND #$0F
	STA !MovTypeY,x
	INY 

	;Max Speed
	LDA [!Scratch0],y
	AND #$F0
	STA !MaxSpeedX,x
	LDA [!Scratch0],y
	AND #$0F
	CLC
	ASL
	ASL
	ASL
	ASL
	STA !MaxSpeedY,x
	INY 

	;Accel
	LDA [!Scratch0],y
	LSR
	LSR
	LSR
	LSR
	STA !AccelX,x
	LDA [!Scratch0],y
	AND #$0F
	STA !AccelY,x
	INY 

	;Initial Angle
	LDA #$00
	XBA
	LDA [!Scratch0],y
	CLC
	REP #$20
	ASL
	ASL
	STA !Scratch3
	SEP #$20

	LDA !Scratch3
	STA !PhaseLow,x
	LDA !Scratch4
	STA !PhaseHigh,x
	INY

	;Angle Speed
	LDA [!Scratch0],y
	STA !AngleSpeed,x
	INY

	;Amplitude
	LDA [!Scratch0],y
	AND #$F0
	STA !AmplitudeX,x
	LDA [!Scratch0],y
	AND #$0F
	ASL
	ASL
	ASL
	ASL
	STA !AmplitudeY,x
	INY

	LDA [!Scratch0],y
	AND #$F0
	STA !RatioX,x
	LDA [!Scratch0],y
	AND #$0F
	ASL
	ASL
	ASL
	ASL
	STA !RatioY,x
	INY

	LDA [!Scratch0],y
	LSR
	LSR
	LSR
	LSR
	STA !RatioIncreaseX,x
	LDA [!Scratch0],y
	AND #$0F
	STA !RatioIncreaseY,x
	INY

	LDA [!Scratch0],y
	AND #$F0
	STA !RatioMaxX,x
	LDA [!Scratch0],y
	AND #$0F
	CLC
	ASL
	ASL
	ASL
	ASL
	STA !RatioMaxY,x
	INY
	
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
	PHX
	LDA.l DZ_DS_Loc_US_Normal,x
	TAX
	LDA DZ_DS_Loc_UsedBy,x
	AND #$80
	BNE +

	PLX
RTS
+

	LDA.l DZ_DS_Loc_SharedUpdated,x
	BNE +

	LDA #$01
	STA.l DZ_DS_Loc_SharedUpdated,x

	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$E0
	ORA $01,s
	STA.l DZ_DS_Loc_UsedBy,x
	PLX

	JSL !CheckIfLastNormalSharedProcessed
RTS
+
	PLY
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAX

	LDA !LocalFlip,x
	STA !LocalFlip,y

	LDA !AnimationIndex,x
	STA !AnimationIndex,y

	LDA !AnimationTimer,x
	STA !AnimationTimer,y

	LDA !AnimationFrameIndex,x
	STA !AnimationFrameIndex,y

	LDA !FrameIndex,x
	STA !FrameIndex,y
	TYX

	JSL !CheckIfLastNormalSharedProcessed
RTS
SpriteCode:

	JSR DynamicRoutine

	LDA DZ_DS_Loc_US_Normal,x
	TAX

	LDA DZ_DS_Loc_IsValid,x
	BNE +
	LDX !SpriteIndex
	BRA Return
+
	LDX !SpriteIndex 
    JSR GraphicRoutine                  ;Calls the graphic routine and updates sprite graphics

    ;Here you can put code that will be excecuted each frame even if the sprite is locked

    LDA !SpriteStatus,x			      
	CMP #$02
	BEQ +  
	CMP #$08                            ;if sprite dead return
	BEQ +
	JMP Return	
+

	LDA !LockAnimationFlag				    
	BEQ +
	JMP Return			                    ;if locked animation return.
+
    %SubOffScreen()

    JSR InteractMarioSprite
    ;After this routine, if the sprite interact with mario, Carry is Set.

	JSR StateMachine
    ;Here you can write your sprite code routine
    ;This will be excecuted once per frame excepts when 
    ;the animation is locked or when sprite status is not #$08

	PHX
	LDA.l DZ_DS_Loc_US_Normal,x
	TAX
	LDA DZ_DS_Loc_UsedBy,x
	AND #$80
	BNE +

	PLX

    JSR AnimationRoutine                ;Calls animation routine and decides the next frame to draw
RTS
+
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
    
	JSL !CheckIfLastNormalSharedProcessed
RTS
+
	PLY
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAX

	LDA !LocalFlip,x
	STA !LocalFlip,y

	LDA !AnimationIndex,x
	STA !AnimationIndex,y

	LDA !AnimationTimer,x
	STA !AnimationTimer,y

	LDA !AnimationFrameIndex,x
	STA !AnimationFrameIndex,y

	LDA !FrameIndex,x
	STA !FrameIndex,y
	TYX

	JSL !CheckIfLastNormalSharedProcessed
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
	dw Dead
	dw Hurt

Idle:
	LDX !SpriteIndex

	JSR MovementState

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	CLC
	ADC #$000C
	CMP !PlayerX
	SEP #$20
	BCS +

	LDA !GlobalFlip,x
	BNE ++

	JSR ChangeToDynamic
	BCC ++
	JSR ChangeAnimationFromStart_flip
	LDA #$01
	STA !State,x
	BRA ++
+
	LDA !GlobalFlip,x
	BEQ ++

	JSR ChangeToDynamic
	BCC ++
	JSR ChangeAnimationFromStart_flip
	LDA #$01
	STA !State,x
++
	LDX !SpriteIndex
RTS

Flip:
	LDX !SpriteIndex

	JSR MovementState

	LDA !AnimationTimer,x
	BNE +

	LDA !AnimationFrameIndex,x
	CMP #$03
	BCC +

	JSR ChangeToSharedDynamic
	BCC +
	BEQ ++
	JSR ChangeAnimationFromStart_idle
++
	STZ !State,x

	LDA !GlobalFlip,x
	EOR #$01
	STA !GlobalFlip,x
RTS
+
	LDX !SpriteIndex
RTS

Dead:
	LDX !SpriteIndex

	LDA !AnimationIndex,x
	CMP #$02
	BEQ +

	JSR ChangeToDynamic
	BCS ++
RTS
++
	JSR ChangeAnimationFromStart_dead
	LDA #$C0
	STA !SpriteYSpeed,x
	LDA !GlobalFlip,x
	TAY
	LDA DeadSpeed,y
	STA !SpriteXSpeed,x

	LDA #$28
	STA $1DFC|!addr

+
	JSL $01802A|!rom
RTS

DeadSpeed: db $10,$F0

Hurt:
	LDX !SpriteIndex

	LDA !AnimationIndex,x
	CMP #$03
	BEQ +

	JSR ChangeToDynamic
	BCS ++
RTS
++
	JSR ChangeAnimationFromStart_Hurt

	LDA #$28
	STA $1DFC|!addr

+
RTS

ExtraByteTab: 
	db $80,$40
ChangeToDynamic:

	LDA DZ_DS_Loc_US_Normal,x
	TAX
	LDA DZ_DS_Loc_UsedBy,x
	LDX !SpriteIndex
	AND #$80
	BNE +
	CLC
RTS
+

	LDA DZ_Timer
	AND #$01
	TAY
	LDA !ExtraByte1,x
	PHA
	LDA ExtraByteTab,y
	STA !ExtraByte1,x

	LDA DZ_DS_Loc_US_Normal,x
	PHA
	LDA #$FF
	STA DZ_DS_Loc_US_Normal,x
	%CheckSlotNormalSpriteNoRemove(#$08, $00)
	PLA
	BCS +
	STA DZ_DS_Loc_US_Normal,x
	PLA
	STA !ExtraByte1,x 
	CLC
RTS
+
	PLA
	LDA #$FF
	STA !LastFrameIndex,x
	SEC
RTS

ChangeToSharedDynamic:
	LDA DZ_DS_Loc_US_Normal,x
	TAX
	LDA DZ_DS_Loc_UsedBy,x
	LDX !SpriteIndex
	AND #$80
	BEQ +
	CLC
RTS
+
	LDA DZ_DS_Loc_US_Normal,x
	STA !Scratch0

	JSL !CheckNormalSharedDynamicExisted
	BCS +

	JSL !ClearSlot

	LDA DZ_DS_Loc_US_Normal,x
	TAX
	LDA DZ_DS_Loc_UsedBy,x
	ORA #$80
	STA DZ_DS_Loc_UsedBy,x
	LDA #$00
	STA DZ_DS_Loc_SharedUpdated,x
	LDX !SpriteIndex

	LDA #$01
	SEC
RTS
+
	PHX
	LDX !Scratch0
	LDA #$FF
	STA DZ_DS_Loc_UsedBy,x
	PLX
	LDA DZ_DS_Loc_US_Normal,x
	TAX
	LDA.l DZ_DS_Loc_UsedBy,x
	AND #$1F
	TAY

	LDX !SpriteIndex

	LDA !LocalFlip,y
	STA !LocalFlip,x

	LDA !AnimationIndex,y
	STA !AnimationIndex,x

	LDA !AnimationTimer,y
	STA !AnimationTimer,x

	LDA !AnimationFrameIndex,y
	STA !AnimationFrameIndex,x

	LDA !FrameIndex,y
	STA !FrameIndex,x

	TYX
	LDA !ExtraByte1,x
	LDX !SpriteIndex
	STA !ExtraByte1,x

	JSL !ClearSlot

	LDA #$00
	SEC
RTS
;Here you can write routines or tables
ApplyAngleSpeed:
	db $00,$00,$00,$01,$01,$01,$01,$01,$01,$00

MovementState:
	LDA !MovTypeX,x
	TAY
	LDA.w ApplyAngleSpeed,y
	PHA
	LDA !MovTypeY,x
	TAY
	PLA
	ORA.w ApplyAngleSpeed,y
	BEQ +

	STZ !Scratch1
	LDA !AngleSpeed,x
	STA !Scratch0
	BPL ++
	LDA #$FF
	STA !Scratch1
++

	LDA !AngleHigh,x
	XBA
	LDA !AngleLow,x
	REP #$20
	CLC
	ADC !Scratch0
	STA !Scratch0
	CMP #$02D0
	BCC ++
	SEC
	SBC #$02D0
	STA !Scratch0
++
	SEP #$20
	LDA !Scratch0
	STA !AngleLow,x
	LDA !Scratch1
	STA !AngleHigh,x
+

	LDA !MovTypeX,x
	ASL
	TAX
	
	JSR (MoveX,x)

	LDA !MovTypeY,x
	ASL
	TAX
	
	JSR (MoveY,x)
RTS

MoveX:
	dw NoMovement
	dw ConstantX
	dw FollowX
	dw SinX
	dw CosX
	dw SinSinX
	dw SinCosX
	dw CosSinX
	dw CosCosX

MoveY:
	dw NoMovement
	dw ConstantY
	dw FollowY
	dw SinY
	dw CosY
	dw SinSinY
	dw SinCosY
	dw CosSinY
	dw CosCosY

NoMovement:
	LDX !SpriteIndex
RTS

ConstantX:
	LDX !SpriteIndex

	JSL $018022|!rom
RTS

ConstantY:
	LDX !SpriteIndex

	JSL $01801A|!rom
RTS

FollowX:
	LDX !SpriteIndex

	LDA !SpriteXHigh,x
	XBA
	LDA !SpriteXLow,x
	REP #$20
	CLC
	ADC #$000C
	CMP !PlayerX
	SEP #$20
	BCC +

	LDA !MaxSpeedX,x
	EOR #$FF
	INC A
	STA !Scratch0

	LDA !SpriteXSpeed,x
	SEC
	SBC !AccelX,x
	STA !SpriteXSpeed,x
	BPL ++
	CMP !Scratch0
	BCS ++
	LDA !Scratch0
	STA !SpriteXSpeed,x
	JSL $018022|!rom
RTS
+
	LDA !SpriteXSpeed,x
	CLC
	ADC !AccelX,x
	STA !SpriteXSpeed,x
	BMI ++
	CMP !MaxSpeedX,x
	BCC ++
	LDA !MaxSpeedX,x
	STA !SpriteXSpeed,x
++
	JSL $018022|!rom
RTS

FollowY:
	LDX !SpriteIndex

	LDA !SpriteYHigh,x
	XBA
	LDA !SpriteYLow,x
	REP #$20
	SEC
	SBC #$0008
	CMP !PlayerY
	SEP #$20
	BCC +

	LDA !MaxSpeedY,x
	EOR #$FF
	INC A
	STA !Scratch0

	LDA !SpriteYSpeed,x
	SEC
	SBC !AccelY,x
	STA !SpriteYSpeed,x
	BPL ++
	CMP !Scratch0
	BCS ++
	LDA !Scratch0
	STA !SpriteYSpeed,x
	JSL $01801A|!rom
RTS
+
	LDA !SpriteYSpeed,x
	CLC
	ADC !AccelY,x
	STA !SpriteYSpeed,x
	BMI ++
	CMP !MaxSpeedY,x
	BCC ++
	LDA !MaxSpeedY,x
	STA !SpriteYSpeed,x
++
	JSL $01801A|!rom
RTS

SinX:
	JSR ApplyRatioXIncrease
	JSR Follow2X
	JSR SinCosXStart
	%Sin()
	JSR SinCosXEnd

RTS

SinY:
	JSR ApplyRatioYIncrease
	JSR Follow2Y
	JSR SinCosYStart
	%Sin()
	JSR SinCosYEnd

RTS

CosX:
	JSR ApplyRatioXIncrease
	JSR Follow2X
	JSR SinCosXStart
	%Cos()
	JSR SinCosXEnd
RTS

CosY:
	JSR ApplyRatioYIncrease
	JSR Follow2Y
	JSR SinCosYStart
	%Cos()
	JSR SinCosYEnd

RTS

SinSinX:
	JSR ApplyRatioXIncrease
	JSR Follow2X
	JSR SSSCCSCCXStart
	%Sin()
	JSR SSSCCSCCMiddle
	%Sin()
	JSR SinCosXEnd

RTS

SinSinY:
	JSR ApplyRatioYIncrease
	JSR Follow2Y
	JSR SSSCCSCCYStart
	%Sin()
	JSR SSSCCSCCMiddle
	%Sin()
	JSR SinCosYEnd

RTS

SinCosX:
	JSR ApplyRatioXIncrease
	JSR Follow2X
	JSR SSSCCSCCXStart
	%Cos()
	JSR SSSCCSCCMiddle
	%Sin()
	JSR SinCosXEnd

RTS

SinCosY:
	JSR ApplyRatioYIncrease
	JSR Follow2Y
	JSR SSSCCSCCYStart
	%Cos()
	JSR SSSCCSCCMiddle
	%Sin()
	JSR SinCosYEnd

RTS

CosSinX:
	JSR ApplyRatioXIncrease
	JSR Follow2X
	JSR SSSCCSCCXStart
	%Sin()
	JSR SSSCCSCCMiddle
	%Cos()
	JSR SinCosXEnd

RTS

CosSinY:
	JSR ApplyRatioYIncrease
	JSR Follow2Y
	JSR SSSCCSCCYStart
	%Sin()
	JSR SSSCCSCCMiddle
	%Cos()
	JSR SinCosYEnd

RTS

CosCosX:
	JSR ApplyRatioXIncrease
	JSR Follow2X
	JSR SSSCCSCCXStart
	%Cos()
	JSR SSSCCSCCMiddle
	%Cos()
	JSR SinCosXEnd

RTS

CosCosY:
	JSR ApplyRatioYIncrease
	JSR Follow2Y
	JSR SSSCCSCCYStart
	%Cos()
	JSR SSSCCSCCMiddle
	%Cos()
	JSR SinCosYEnd

RTS

SinCosXStart:

	LDA !PosXL,x
	STA !SpriteXLow,x
	LDA !PosXH,x
	STA !SpriteXHigh,x

	JSL $018022|!rom

	LDA !SpriteXLow,x
	STA !PosXL,x
	STA !ScratchC
	LDA !SpriteXHigh,x
	STA !PosXH,x
	STA !ScratchD

	LDA !RatioX,x
	PHA
	LDA !AngleHigh,x
	XBA
	LDA !AngleLow,x
	REP #$10
	TAX
	PLA
RTS

SinCosXEnd:
	CLC
	ADC !ScratchC
	STA !ScratchC
	SEP #$30
	LDX !SpriteIndex

	LDA !ScratchC
	STA !SpriteXLow,x
	LDA !ScratchD
	STA !SpriteXHigh,x

RTS

SinCosYStart:

	LDA !PosYL,x
	STA !SpriteYLow,x
	LDA !PosYH,x
	STA !SpriteYHigh,x

	JSL $01801A|!rom

	LDA !SpriteYLow,x
	STA !PosYL,x
	STA !ScratchC
	LDA !SpriteYHigh,x
	STA !PosYH,x
	STA !ScratchD

	LDA !RatioY,x
	PHA
	LDA !AngleHigh,x
	XBA
	LDA !AngleLow,x
	REP #$10
	TAX
	PLA
RTS

SinCosYEnd:
	CLC
	ADC !ScratchC
	STA !ScratchC
	SEP #$30
	LDX !SpriteIndex

	LDA !ScratchC
	STA !SpriteYLow,x
	LDA !ScratchD
	STA !SpriteYHigh,x

RTS

SSSCCSCCXStart:

	LDA !PosXL,x
	STA !SpriteXLow,x
	LDA !PosXH,x
	STA !SpriteXHigh,x

	JSL $018022|!rom

	LDA !SpriteXLow,x
	STA !PosXL,x
	STA !ScratchC
	LDA !SpriteXHigh,x
	STA !PosXH,x
	STA !ScratchD

	LDA !RatioX,x
	STA !Scratch9

	LDA !PhaseHigh,x
	STA !ScratchB
	LDA !PhaseLow,x
	STA !ScratchA

	LDA !AmplitudeX,x
	PHA
	LDA !AngleHigh,x
	XBA
	LDA !AngleLow,x
	REP #$10
	TAX
	PLA
RTS

SSSCCSCCMiddle:
	CLC
	ADC !ScratchA
	BPL +
	CLC
	ADC #$02D0
	BRA ++
+
	CMP #$02D0
	BCC ++

	SEC
	SBC #$02D0
++
	TAX
	SEP #$20
	LDA !Scratch9
RTS

SSSCCSCCYStart:
	LDA !PosYL,x
	STA !SpriteYLow,x
	LDA !PosYH,x
	STA !SpriteYHigh,x

	JSL $01801A|!rom

	LDA !SpriteYLow,x
	STA !PosYL,x
	STA !ScratchC
	LDA !SpriteYHigh,x
	STA !PosYH,x
	STA !ScratchD

	LDA !RatioY,x
	STA !Scratch9

	LDA !PhaseHigh,x
	STA !ScratchB
	LDA !PhaseLow,x
	STA !ScratchA

	LDA !AmplitudeY,x
	PHA
	LDA !AngleHigh,x
	XBA
	LDA !AngleLow,x
	REP #$10
	TAX
	PLA
RTS

ApplyRatioXIncrease:
	LDX !SpriteIndex

	LDA !RatioIncreaseX,x
	BNE +
RTS
+
	LDY #$00
	LDA !RatioIncreaseTimerX,x
	CLC
	ADC !RatioIncreaseX,x
	STA !RatioIncreaseTimerX,x			;Ratio += Ratio Increase
	BPL +
	LDY #$01
	EOR #$FF
	INC A
+
	LSR
	LSR
	LSR
	LSR
	STA !Scratch0
	BNE +
RTS
+
	CPY #$01
	BNE +
	EOR #$FF
	INC A
	STA !Scratch0
	LDA !RatioIncreaseTimerX,x
	CLC
	ADC #$10
	STA !RatioIncreaseTimerX,x
	BRA ++
+
	LDA !RatioIncreaseTimerX,x
	CLC
	ADC #$F0
	STA !RatioIncreaseTimerX,x	
++

	LDA !RatioX,x
	PHP
	CLC
	ADC !Scratch0
	STA !RatioX,x			;Ratio += Ratio Increase
	PLA
	BMI +

	LDA !RatioIncreaseX,x
	BPL +

	LDA !RatioX,x
	BPL +

	LDA !RatioIncreaseX,x

	LDA #$00
	STA !RatioX,x
	LDA !RatioIncreaseX,x
	EOR #$FF
	INC A
	STA !RatioIncreaseX,x
RTS

+

	LDA !RatioMaxX,x
	CMP !RatioX,x
	BCS +

	STA !RatioX,x
	
	LDA !RatioIncreaseX,x
	EOR #$FF
	INC A
	STA !RatioIncreaseX,x

+

RTS

ApplyRatioYIncrease:
	LDX !SpriteIndex

	LDA !RatioIncreaseY,x
	BNE +
RTS
+
	LDY #$00
	LDA !RatioIncreaseTimerY,x
	CLC
	ADC !RatioIncreaseY,x
	STA !RatioIncreaseTimerY,x			;Ratio += Ratio Increase
	BPL +
	LDY #$01
	EOR #$FF
	INC A
+
	LSR
	LSR
	LSR
	LSR
	STA !Scratch0
	BNE +
RTS
+
	CPY #$01
	BNE +
	EOR #$FF
	INC A
	STA !Scratch0
	LDA !RatioIncreaseTimerY,x
	CLC
	ADC #$10
	STA !RatioIncreaseTimerY,x
	BRA ++
+
	LDA !RatioIncreaseTimerY,x
	CLC
	ADC #$F0
	STA !RatioIncreaseTimerY,x	
++
	LDA !RatioY,x
	PHP
	CLC
	ADC !Scratch0
	STA !RatioY,x			;Ratio += Ratio Increase
	PLA
	BMI +

	LDA !RatioIncreaseY,x
	BPL +

	LDA !RatioY,x
	BPL +

	LDA #$00
	STA !RatioY,x
	LDA !RatioIncreaseY,x
	EOR #$FF
	INC A
	STA !RatioIncreaseY,x
RTS

+

	LDA !RatioMaxY,x
	CMP !RatioY,x
	BCS +

	STA !RatioY,x
	
	LDA !RatioIncreaseY,x
	EOR #$FF
	INC A
	STA !RatioIncreaseY,x

+
RTS

Follow2X:
	LDA !AccelX,x
	BNE +
RTS
+

	LDA !PosXH,x
	XBA
	LDA !PosXL,x
	REP #$20
	CLC
	ADC #$000C
	CMP !PlayerX
	SEP #$20
	BCC +

	LDA !MaxSpeedX,x
	EOR #$FF
	INC A
	STA !Scratch0

	LDA !SpriteXSpeed,x
	SEC
	SBC !AccelX,x
	STA !SpriteXSpeed,x
	BPL ++
	CMP !Scratch0
	BCS ++
	LDA !Scratch0
	STA !SpriteXSpeed,x
RTS
+
	LDA !SpriteXSpeed,x
	CLC
	ADC !AccelX,x
	STA !SpriteXSpeed,x
	BMI ++
	CMP !MaxSpeedX,x
	BCC ++
	LDA !MaxSpeedX,x
	STA !SpriteXSpeed,x
++
RTS

Follow2Y:
	LDA !AccelY,x
	BNE +
RTS
+

	LDA !PosYH,x
	XBA
	LDA !PosYL,x
	REP #$20
	SEC
	SBC #$0008
	CMP !PlayerY
	SEP #$20
	BCC +

	LDA !MaxSpeedY,x
	EOR #$FF
	INC A
	STA !Scratch0

	LDA !SpriteYSpeed,x
	SEC
	SBC !AccelY,x
	STA !SpriteYSpeed,x
	BPL ++
	CMP !Scratch0
	BCS ++
	LDA !Scratch0
	STA !SpriteYSpeed,x
RTS
+
	LDA !SpriteYSpeed,x
	CLC
	ADC !AccelY,x
	STA !SpriteYSpeed,x
	BMI ++
	CMP !MaxSpeedY,x
	BCC ++
	LDA !MaxSpeedY,x
	STA !SpriteYSpeed,x
++
RTS

;>Section Dynamic
;######################################
;########## Animation Space ###########
;######################################
ResourceOffset:
Frame0_ResourceOffset:
	dw $0000,$0160
Frame1_ResourceOffset:
	dw $02A0,$0480
Frame2_ResourceOffset:
	dw $0660,$0820
Frame3_ResourceOffset:
	dw $09A0,$0BA0
Frame4_ResourceOffset:
	dw $0D60,$0F00
Frame5_ResourceOffset:
	dw $1080,$1280
Frame6_ResourceOffset:
	dw $1440,$1620
Frame7_ResourceOffset:
	dw $17E0,$19A0
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
	db $0B,$0A
Frame1_ResourceSize:
	db $0F,$0F
Frame2_ResourceSize:
	db $0E,$0C
Frame3_ResourceSize:
	db $1E,$00
Frame4_ResourceSize:
	db $0D,$0C
Frame5_ResourceSize:
	db $1E,$00
Frame6_ResourceSize:
	db $0F,$0E
Frame7_ResourceSize:
	db $0E,$0D
Frame8_ResourceSize:
	db $0E,$0E
Frame9_ResourceSize:
	db $0B,$0A
Frame10_ResourceSize:
	db $0D,$0C
Frame11_ResourceSize:
	db $0E,$0E
Frame12_ResourceSize:
	db $0F,$0C
Frame13_ResourceSize:
	db $0E,$0E
Frame14_ResourceSize:
	db $0C,$0C


DynamicRoutine:
	PHX
	
	LDA.l DZ_DS_Loc_US_Normal,x
	TAX

	LDA DZ_DS_Loc_UsedBy,x
	AND #$80
	BEQ +

	LDA DZ_DS_Loc_SharedUpdated,x
	BEQ +
	PLX
RTS
+
	PLX

	%CheckEvenOrOdd("DZ_DS_Loc_US_Normal")
	BEQ +								;/
RTS
+
	%FindSpace("DZ_DS_Loc_US_Normal,x")
	BCS +

	LDA.l DZ_DS_Loc_US_Normal,x
	TAX

	LDA.l DZ_DS_Loc_IsValid,x
	BNE ++
    LDX $15E9|!addr
    STZ !SpriteStatus,x
    LDA !SpriteLoadStatus,x
    TAX
    LDA #$00
    STA !SpriteLoadTable,x
++
    LDX $15E9|!addr
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
	LDA.l DZ_DS_Loc_US_Normal,x
	TAX
	LDA !Scratch0
	STA.l DZ_DS_Loc_SharedFrame,x

	LDX $15E9|!addr

	LDA #$00
	XBA
	LDA !FrameIndex,x
	STA !LastFrameIndex,x
	REP #$30
	ASL
	TAY
	PHY
	SEP #$20
	LDA ResourceSize,y
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


	%GetVramDispDynamicRoutine(DZ_DS_Loc_US_Normal)
	STA !ScratchD

	LDA.l DZ_DS_Loc_US_Normal,x
	TAX

	LDA #$01
	STA.l DZ_DS_Loc_IsValid,x

	%DynamicRoutine(!ScratchD, #!GFX00, #!GFX00>>16, !Scratch1, !Scratch0)

	REP #$30
	PLY
	LDA ResourceOffset+2,y
	STA !Scratch1
	PLY
	SEP #$20
	LDA ResourceSize+1,y
	STA !Scratch0
	SEP #$10
	BEQ +

	LDA !ScratchD
	CLC
	ADC #$10
	STA !ScratchE

	%DynamicRoutine(!ScratchE, #!GFX00, #!GFX00>>16, !Scratch1, !Scratch0)
+

	LDX $15E9|!addr
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

;>Routine: GraphicRoutine
;>Description: Updates tiles on the oam map
;results will be visible the next frame.
;>RoutineLength: Short
GraphicRoutine:

    %GetDrawInfo()                     ;Calls GetDrawInfo to get the free slot and the XDisp and YDisp

	%GetVramDisp(DZ_DS_Loc_US_Normal)
	STA !ScratchE

	LDA #$04
	STA !ScratchD
	LDA !ExtraBits,x
	AND #$04
	BEQ +
	LDA #$02
	STA !ScratchD
+

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
	LDA.l DZ_DS_Loc_US_Normal,x
	TAX
	LDA.l DZ_DS_Loc_SharedFrame,x
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
	%RemapOamTile("Tiles,x", !ScratchE)
    STA !TileCode,y                     ;Set the Tile code of the tile Y

	LDA #$21
	ORA !ScratchD
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
	db $08,$06,$04,$02,$0A,$00
Frame1_Frame1_Tiles:
	db $0D,$0B,$09,$07,$05,$00,$03,$01
Frame2_Frame2_Tiles:
	db $0A,$08,$0D,$06,$04,$02,$00,$0C
Frame3_Frame3_Tiles:
	db $0C,$0F,$0A,$08,$06,$04,$02,$00,$0E
Frame4_Frame4_Tiles:
	db $0A,$08,$06,$00,$0C,$04,$02
Frame5_Frame5_Tiles:
	db $0C,$0A,$0F,$08,$06,$04,$02,$00,$0E
Frame6_Frame6_Tiles:
	db $0C,$0A,$08,$06,$04,$0E,$02,$00
Frame7_Frame7_Tiles:
	db $0B,$0D,$09,$07,$05,$00,$03,$01
Frame8_Frame8_Tiles:
	db $0C,$0A,$08,$06,$02,$00,$04
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
	db $08,$06,$04,$02,$0A,$00
Frame1_Frame1_TilesFlipX:
	db $0D,$0B,$09,$07,$05,$00,$03,$01
Frame2_Frame2_TilesFlipX:
	db $0A,$08,$0D,$06,$04,$02,$00,$0C
Frame3_Frame3_TilesFlipX:
	db $0C,$0F,$0A,$08,$06,$04,$02,$00,$0E
Frame4_Frame4_TilesFlipX:
	db $0A,$08,$06,$00,$0C,$04,$02
Frame5_Frame5_TilesFlipX:
	db $0C,$0A,$0F,$08,$06,$04,$02,$00,$0E
Frame6_Frame6_TilesFlipX:
	db $0C,$0A,$08,$06,$04,$0E,$02,$00
Frame7_Frame7_TilesFlipX:
	db $0B,$0D,$09,$07,$05,$00,$03,$01
Frame8_Frame8_TilesFlipX:
	db $0C,$0A,$08,$06,$02,$00,$04
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
	db $F0,$FD,$00,$0D,$10,$10
Frame1_Frame1_XDisp:
	db $F0,$FD,$FD,$FD,$0D,$0D,$0E,$15
Frame2_Frame2_XDisp:
	db $F1,$FE,$01,$02,$02,$0E,$10,$15
Frame3_Frame3_XDisp:
	db $F1,$FD,$FD,$FE,$0D,$0D,$0E,$11,$19
Frame4_Frame4_XDisp:
	db $F1,$FE,$01,$0E,$0E,$0F,$11
Frame5_Frame5_XDisp:
	db $F1,$FD,$FE,$FE,$06,$06,$10,$11,$16
Frame6_Frame6_XDisp:
	db $F0,$FE,$00,$02,$0E,$0E,$0E,$10
Frame7_Frame7_XDisp:
	db $F0,$FE,$FE,$FE,$0D,$0D,$0E,$15
Frame8_Frame8_XDisp:
	db $F7,$FF,$01,$01,$0D,$0D,$0F
Frame9_Frame9_XDisp:
	db $00,$0A,$0A,$0C,$0C,$13
Frame10_Frame10_XDisp:
	db $FE,$02,$02,$10,$12,$12,$1B
Frame11_Frame11_XDisp:
	db $01,$0F,$0F,$0F,$19,$19,$1F
Frame12_Frame12_XDisp:
	db $03,$08,$08,$0A,$10,$17,$17,$18,$24
Frame13_Frame13_XDisp:
	db $0A,$0F,$18,$18,$1F,$27,$27
Frame14_Frame14_XDisp:
	db $0C,$0D,$1C,$1C,$28,$28
Frame0_Frame0_XDispFlipX:
	db $2A,$1D,$1A,$0D,$12,$0A
Frame1_Frame1_XDispFlipX:
	db $2A,$1D,$1D,$1D,$0D,$0D,$0C,$05
Frame2_Frame2_XDispFlipX:
	db $29,$1C,$21,$18,$18,$0C,$0A,$0D
Frame3_Frame3_XDispFlipX:
	db $29,$25,$1D,$1C,$0D,$0D,$0C,$09,$09
Frame4_Frame4_XDispFlipX:
	db $29,$1C,$19,$0C,$14,$0B,$09
Frame5_Frame5_XDispFlipX:
	db $29,$1D,$24,$1C,$14,$14,$0A,$09,$0C
Frame6_Frame6_XDispFlipX:
	db $2A,$1C,$1A,$18,$0C,$14,$0C,$0A
Frame7_Frame7_XDispFlipX:
	db $2A,$24,$1C,$1C,$0D,$0D,$0C,$05
Frame8_Frame8_XDispFlipX:
	db $23,$1B,$19,$19,$0D,$0D,$0B
Frame9_Frame9_XDispFlipX:
	db $1A,$10,$18,$0E,$0E,$07
Frame10_Frame10_XDispFlipX:
	db $1C,$18,$18,$0A,$08,$08,$07
Frame11_Frame11_XDispFlipX:
	db $19,$0B,$0B,$0B,$01,$01,$FB
Frame12_Frame12_XDispFlipX:
	db $1F,$12,$1A,$10,$12,$03,$03,$02,$F6
Frame13_Frame13_XDispFlipX:
	db $10,$0B,$02,$02,$FB,$F3,$F3
Frame14_Frame14_XDispFlipX:
	db $0E,$0D,$FE,$FE,$F2,$F2
;>EndTable
;>Table: YDisplacements
;>Description: Y Displacement of each tile of each frame
;>ValuesSize: 8
YDisplacements:
    
Frame0_Frame0_YDisp:
	db $FD,$0C,$FF,$0F,$FC,$FF
Frame1_Frame1_YDisp:
	db $05,$F4,$04,$0D,$F5,$05,$0F,$05
Frame2_Frame2_YDisp:
	db $05,$0C,$04,$EF,$FF,$0F,$FF,$F7
Frame3_Frame3_YDisp:
	db $05,$F5,$FC,$0C,$F5,$05,$10,$06,$FE
Frame4_Frame4_YDisp:
	db $FD,$0B,$FF,$FB,$0F,$10,$00
Frame5_Frame5_YDisp:
	db $FA,$F4,$04,$0C,$F5,$05,$10,$05,$FE
Frame6_Frame6_YDisp:
	db $07,$0C,$FF,$EF,$FC,$0C,$10,$05
Frame7_Frame7_YDisp:
	db $07,$F4,$FC,$0C,$F5,$05,$0F,$05
Frame8_Frame8_YDisp:
	db $FC,$0A,$F1,$01,$F2,$02,$0F
Frame9_Frame9_YDisp:
	db $08,$F0,$00,$00,$0F,$08
Frame10_Frame10_YDisp:
	db $09,$F4,$04,$11,$F5,$05,$15
Frame11_Frame11_YDisp:
	db $06,$F5,$05,$15,$0B,$0F,$FB
Frame12_Frame12_YDisp:
	db $07,$00,$10,$17,$0F,$F2,$02,$12,$05
Frame13_Frame13_YDisp:
	db $08,$18,$F8,$08,$13,$F6,$06
Frame14_Frame14_YDisp:
	db $09,$19,$03,$11,$05,$15
Frame0_Frame0_YDispFlipX:
	db $FD,$0C,$FF,$0F,$FC,$FF
Frame1_Frame1_YDispFlipX:
	db $05,$F4,$04,$0D,$F5,$05,$0F,$05
Frame2_Frame2_YDispFlipX:
	db $05,$0C,$04,$EF,$FF,$0F,$FF,$F7
Frame3_Frame3_YDispFlipX:
	db $05,$F5,$FC,$0C,$F5,$05,$10,$06,$FE
Frame4_Frame4_YDispFlipX:
	db $FD,$0B,$FF,$FB,$0F,$10,$00
Frame5_Frame5_YDispFlipX:
	db $FA,$F4,$04,$0C,$F5,$05,$10,$05,$FE
Frame6_Frame6_YDispFlipX:
	db $07,$0C,$FF,$EF,$FC,$0C,$10,$05
Frame7_Frame7_YDispFlipX:
	db $07,$F4,$FC,$0C,$F5,$05,$0F,$05
Frame8_Frame8_YDispFlipX:
	db $FC,$0A,$F1,$01,$F2,$02,$0F
Frame9_Frame9_YDispFlipX:
	db $08,$F0,$00,$00,$0F,$08
Frame10_Frame10_YDispFlipX:
	db $09,$F4,$04,$11,$F5,$05,$15
Frame11_Frame11_YDispFlipX:
	db $06,$F5,$05,$15,$0B,$0F,$FB
Frame12_Frame12_YDispFlipX:
	db $07,$00,$10,$17,$0F,$F2,$02,$12,$05
Frame13_Frame13_YDispFlipX:
	db $08,$18,$F8,$08,$13,$F6,$06
Frame14_Frame14_YDispFlipX:
	db $09,$19,$03,$11,$05,$15
;>EndTable
;>Table: Sizes.
;>Description: size of each tile of each frame
;>ValuesSize: 8
Sizes:
    
Frame0_Frame0_Sizes:
	db $02,$02,$02,$02,$00,$02
Frame1_Frame1_Sizes:
	db $02,$02,$02,$02,$02,$02,$02,$02
Frame2_Frame2_Sizes:
	db $02,$02,$00,$02,$02,$02,$02,$00
Frame3_Frame3_Sizes:
	db $02,$00,$02,$02,$02,$02,$02,$02,$00
Frame4_Frame4_Sizes:
	db $02,$02,$02,$02,$00,$02,$02
Frame5_Frame5_Sizes:
	db $02,$02,$00,$02,$02,$02,$02,$02,$00
Frame6_Frame6_Sizes:
	db $02,$02,$02,$02,$02,$00,$02,$02
Frame7_Frame7_Sizes:
	db $02,$00,$02,$02,$02,$02,$02,$02
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
	db $02,$02,$02,$02,$00,$02
Frame1_Frame1_SizesFlipX:
	db $02,$02,$02,$02,$02,$02,$02,$02
Frame2_Frame2_SizesFlipX:
	db $02,$02,$00,$02,$02,$02,$02,$00
Frame3_Frame3_SizesFlipX:
	db $02,$00,$02,$02,$02,$02,$02,$02,$00
Frame4_Frame4_SizesFlipX:
	db $02,$02,$02,$02,$00,$02,$02
Frame5_Frame5_SizesFlipX:
	db $02,$02,$00,$02,$02,$02,$02,$02,$00
Frame6_Frame6_SizesFlipX:
	db $02,$02,$02,$02,$02,$00,$02,$02
Frame7_Frame7_SizesFlipX:
	db $02,$00,$02,$02,$02,$02,$02,$02
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

ChangeAnimationFromStart_idle:
	STZ !AnimationIndex,x
	BRA ChangeAnimationFromStart
ChangeAnimationFromStart_flip:
	LDA #$01
	STA !AnimationIndex,x
	BRA ChangeAnimationFromStart
ChangeAnimationFromStart_dead:
	LDA #$02
	STA !AnimationIndex,x
	BRA ChangeAnimationFromStart
ChangeAnimationFromStart_Hurt:
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
	%CheckEvenOrOdd("DZ_DS_Loc_US_Normal")
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
	dw $0008,$0004,$0005,$0009

AnimationLastTransition:
	dw $0000,$0003,$0004,$0008

AnimationIndexer:
	dw $0000,$0008,$000C,$0011

Frames:
	
Animation0_idle_Frames:
	db $00,$01,$02,$03,$04,$05,$06,$07
Animation1_flip_Frames:
	db $08,$09,$09,$08
Animation2_dead_Frames:
	db $0A,$0B,$0C,$0D,$0E
Animation3_hurt_Frames:
	db $0A,$0B,$0C,$0D,$0E,$0D,$0C,$0B,$0A

Times:
	
Animation0_idle_Times:
	db $02,$02,$02,$02,$02,$02,$02,$02
Animation1_flip_Times:
	db $02,$02,$02,$02
Animation2_dead_Times:
	db $02,$02,$02,$02,$02
Animation3_hurt_Times:
	db $02,$02,$02,$02,$02,$02,$02,$02,$02

Flips:
	
Animation0_idle_Flips:
	db $00,$00,$00,$00,$00,$00,$00,$00
Animation1_flip_Flips:
	db $00,$00,$01,$01
Animation2_dead_Flips:
	db $00,$00,$00,$00,$00
Animation3_hurt_Flips:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00

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
+
	LDX #!MaxSprites-1
-
	LDA !SpriteStatus,x
	CMP #$09
	BEQ +
	CMP #$0A
	BNE .next
+
	LDA !SpriteNumber,x
	CMP #$03
	BCC .next
	CMP #$08
	BCS .next

	STX !Scratch45

	JSL $03B6E5|!rom

	LDX !SpriteIndex
	JSR Interaction
	BCC .next
	CMP #$01
	BNE .next

	JSR SpriteSpriteAction
	SEC
RTS
.next
	DEX
	BPL -

ReturnNoContact2:
	LDX !SpriteIndex
	CLC
	RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This subroutine checks if the two hitboxes of A and B to see if they are in contact.
;Carry is set if true, else false.
;Syntax:
; $00 = X low byte position/displacement B
; $01 = Y low byte position/displacement B
; $02 = Hitbox width (8-bit) B
; $03 = Hitbox height (8-bit) B
; $04 = X low byte position/displacement A
; $05 = Y low byte position/displacement A
; $06 = Hitbox width (8-bit) A
; $07 = Hitbox height (8-bit) A
; $08 = X high byte position/displacement B
; $09 = Y high byte position/displacement B
; $0A = X high byte position/displacement A
; $0B = Y high byte position/displacement A
;Destroyed values:
; $0C = used as part of the high byte to check if they are too far
; $0F = used as the furthest distance to check if the hitboxes are at least edge
;       to edge on contact.

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
    dw $0000,$0002,$0004,$0006,$0008,$000A,$000C,$000E,$0010,$0012,$0014,$0015,$0016,$0017,$0018
	dw $0019,$001B,$001D,$001F,$0021,$0023,$0025,$0027,$0029,$002B,$002D,$002E,$002F,$0030,$0031

FrameHitBoxes:
    db $00,$FF
	db $00,$FF
	db $00,$FF
	db $00,$FF
	db $00,$FF
	db $00,$FF
	db $00,$FF
	db $00,$FF
	db $01,$FF
	db $02,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $03,$FF
	db $04,$FF
	db $05,$FF
	db $FF
	db $FF
	db $FF
	db $FF
	db $FF
	

HitboxesStart:
    dw $0000,$0006,$000C,$0012,$0018,$001E

Hitboxes:
    db $01,$FF,$06,$1A,$0E,$00
	db $01,$06,$06,$13,$0E,$00
	db $01,$0D,$06,$0C,$0E,$00
	db $01,$11,$06,$1A,$0E,$00
	db $01,$11,$06,$13,$0E,$00
	db $01,$11,$06,$0C,$0E,$00
	

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

	LDA !ExtraBits,x
	AND #$04
	BEQ +
	LDA #$02
    STA $1DF9|!addr     ;Play Spin Jump Sound
RTS
+
	LDA !Hitpoints,x
	BEQ +
	DEC A
	STA !Hitpoints,x
	LDA #$03
	STA !State,x
RTS
+
	LDA #$02
	STA !State,x
RTS























































































































































































