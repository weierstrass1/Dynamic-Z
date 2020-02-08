macro ReserveSprite(TransferRAM,SlotsUsed,SpriteType,SpriteFPS,VRAMDisp,ReserveSlotRoutine,SpriteNumberRAM)
    STX $0F
    LDA <TransferRAM>,x
    STA $06

    LDA <SlotsUsed>              ;Require 4 Slot
    STA $01
    JSR ReserveStart
    BCS ?+

    LDX $0F
    CLC
    BRA ?++

?+

    STX $00                     ;Preserve X in Scratch 0

    LDX $0F
    LDA <TransferRAM>,x
    JSR <ReserveSlotRoutine>    ;Get Slot on VRAM
    BCS ?+

    LDX $00                     ;If dont find a slot, the sprite must be reloaded, and clear the slot
    LDA #$00
    STA !SlotSpriteType,x

    LDX $0F
    CLC
    BRA ?++
?+               
    LDX $0F                     ;Restore X
    STA <VRAMDisp>,x            ;Set Vram Offset

    LDA <SpriteNumberRAM>,x
    LDX $00
    STA !SlotSpriteNumber,x     ;Set the sprite Number

    LDA $0F
    STA !SlotSpriteID,x         ;Set the Sprite ID

    LDA <SpriteType>
    STA !SlotSpriteType,x       ;Type = Normal
    LDA <SpriteFPS>
    STA !FPSSprite,x            ;30FPS

    LDX $0F

    SEC
?++    
endmacro

Reserve16x16NormalSpriteOf30FPS:
    LDA #$00
    BRA Reserve16x16NormalSprite
Reserve16x16NormalSpriteOf60FPS:
    LDA #$01
;Reserve a 32x16 slot for a Normal Dynamic Sprite of 30FPS
Reserve16x16NormalSprite:
    STA $0E
    JSR AssignFrameDistribution
    %ReserveSprite(!TransferFrameNormalSprite,#$02,#$01,$0E,!VRAMDispNormalSprite,ReserveSlot16x16,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve32x16NormalSpriteOf30FPS:
    LDA #$00
    BRA Reserve32x16NormalSprite
Reserve32x16NormalSpriteOf60FPS:
    LDA #$01
;Reserve a 32x16 slot for a Normal Dynamic Sprite of 30FPS
Reserve32x16NormalSprite:
    STA $0E
    JSR AssignFrameDistribution
    %ReserveSprite(!TransferFrameNormalSprite,#$02,#$01,$0E,!VRAMDispNormalSprite,ReserveSlot32x16,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve32x32NormalSpriteOf30FPS:
    LDA #$00
    BRA Reserve32x32NormalSprite
Reserve32x32NormalSpriteOf60FPS:
    LDA #$01
;Reserve a 32x32 slot for a Normal Dynamic Sprite of 30FPS
Reserve32x32NormalSprite:
    STA $0E
    JSR AssignFrameDistribution
    %ReserveSprite(!TransferFrameNormalSprite,#$04,#$01,$0E,!VRAMDispNormalSprite,ReserveSlot32x32,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve48x48NormalSpriteOf30FPS:
    LDA #$00
    BRA Reserve48x48NormalSprite
Reserve48x48NormalSpriteOf60FPS:
    LDA #$01
;Reserve a 48x48 slot for a Normal Dynamic Sprite of 30FPS
Reserve48x48NormalSprite:
    STA $0E
    JSR AssignFrameDistribution
    %ReserveSprite(!TransferFrameNormalSprite,#$08,#$01,$0E,!VRAMDispNormalSprite,ReserveSlot48x48,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve64x64NormalSpriteOf30FPS:
    LDA #$00
    BRA Reserve64x64NormalSprite
Reserve64x64NormalSpriteOf60FPS:
    LDA #$01
;Reserve a 48x48 slot for a Normal Dynamic Sprite of 30FPS
Reserve64x64NormalSprite:
    STA $0E
    JSR AssignFrameDistribution
    %ReserveSprite(!TransferFrameNormalSprite,#$10,#$01,$0E,!VRAMDispNormalSprite,ReserveSlot64x64,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve16x16ClusterSpriteOf30FPS:
    LDA #$00
    BRA Reserve16x16ClusterSprite
Reserve16x16ClusterSpriteOf60FPS:
    LDA #$01
;Reserve a 32x16 slot for a Normal Dynamic Sprite of 30FPS
Reserve16x16ClusterSprite:
    STA $0E
    %ReserveSprite(!TransferFrameClusterSprite,#$02,#$03,$0E,!VRAMDispClusterSprite,ReserveSlot16x16,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve32x16ClusterSpriteOf30FPS:
    LDA #$00
    BRA Reserve32x16ClusterSprite
Reserve32x16ClusterSpriteOf60FPS:
    LDA #$01
;Reserve a 32x16 slot for a Normal Dynamic Sprite of 30FPS
Reserve32x16ClusterSprite:
    STA $0E
    %ReserveSprite(!TransferFrameClusterSprite,#$02,#$03,$0E,!VRAMDispClusterSprite,ReserveSlot32x16,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve32x32ClusterSpriteOf30FPS:
    LDA #$00
    BRA Reserve32x32ClusterSprite
Reserve32x32ClusterSpriteOf60FPS:
    LDA #$01
;Reserve a 32x32 slot for a Normal Dynamic Sprite of 30FPS
Reserve32x32ClusterSprite:
    STA $0E
    %ReserveSprite(!TransferFrameClusterSprite,#$04,#$03,$0E,!VRAMDispClusterSprite,ReserveSlot32x32,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve48x48ClusterSpriteOf30FPS:
    LDA #$00
    BRA Reserve48x48ClusterSprite
Reserve48x48ClusterSpriteOf60FPS:
    LDA #$01
;Reserve a 48x48 slot for a Normal Dynamic Sprite of 30FPS
Reserve48x48ClusterSprite:
    STA $0E
    %ReserveSprite(!TransferFrameClusterSprite,#$08,#$03,$0E,!VRAMDispClusterSprite,ReserveSlot48x48,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

Reserve64x64ClusterSpriteOf30FPS:
    LDA #$00
    BRA Reserve64x64ClusterSprite
Reserve64x64ClusterSpriteOf60FPS:
    LDA #$01
;Reserve a 48x48 slot for a Normal Dynamic Sprite of 30FPS
Reserve64x64ClusterSprite:
    STA $0E
    %ReserveSprite(!TransferFrameClusterSprite,#$10,#$03,$0E,!VRAMDispClusterSprite,ReserveSlot64x64,!SpriteNumber)

    BCS +

    JSR ReloadSprite
    CLC
+
RTL 

;##########################################################################
;############################ Helpers Routines ############################
;##########################################################################

AssignFrameDistribution:
    LDA #$00
    STA !TransferFrameNormalSprite,x

    LDA !ExtraProp1,x
    AND #$20
    BEQ +

    LDA #$02
    STA !TransferFrameNormalSprite,x

+

    LDA !ExtraProp1,x
    AND #$C0
    BNE .NoAutoDistribution

    LDA !SlotsUsedEven
    CMP !SlotsUsedOdd
    BCC +

    LDA !TransferFrameNormalSprite,x
    ORA #$01
    STA !TransferFrameNormalSprite,x
+
RTS

.NoAutoDistribution

    AND #$80
    CLC
    ROL
    ROL
    ORA !TransferFrameNormalSprite,x
    STA !TransferFrameNormalSprite,x

RTS


ReloadSprite:
    STZ !SpriteStatus,x
    LDA !SpriteLoadStatus,x
    TAX
    LDA #$00
    STA !SpriteLoadTable,x
    LDX $15E9|!addr
RTS

;Clear all unused slots
ClearSlots:
    LDA #$00
    STA !SlotsUsedEven      ;!Slot used = 0
    STA !SlotsUsedOdd      ;!Slot used = 0

    LDA !MaxSlots           ;X = max slots
    TAX
-
    LDA !SlotSpriteNumber,x 
    STA $00                 ;Scratch 0 = Sprite number of the dynamic sprite that reserved that slot

    LDA !SlotSpriteType,x   ;Check the type of the sprite
    BEQ .nextSlot           ;If it is not used then go to the next slot
    CMP #$01
    BEQ .Normal             ;Check Normal sprite
    CMP #$02
    BEQ .Extended           ;Check Extended sprite
    CMP #$03
    BEQ .Cluster            ;otherwise check cluster
    CMP #$04
    BNE .nextSlot
.Overworld
    LDA !SlotSpriteID,x     
    PHX
    TAX                     ;X = Sprite Index that reserved this slot
    LDA $0DE5|!addr,x
    BEQ .ClearSlot          ;Check if the sprite is still alive
    CMP $00
    BNE .ClearSlot          ;Check if the sprite number is correct
    
    PLX

    PHX
    JSR AddOWSprite
    BRA .nextSlot                ;if all is fine then jump to .add, otherwise clear the slot and go to the next slot
    PLX

.Normal
    LDA !SlotSpriteID,x     
    PHX
    TAX                     ;X = Sprite Index that reserved this slot
    LDA !SpriteStatus,x     ;
    BEQ .ClearSlot          ;Check if the sprite is still alive

    LDA !SpriteNumber,x
    CMP $00
    BNE .ClearSlot          ;Check if the sprite number is correct

    PLX

    PHX
    JSR AddNormalSprite     ;if all is fine then jump to .add, otherwise clear the slot and go to the next slot
    PLX
    BRA .nextSlot

.Extended
    LDA !SlotSpriteID,x
    PHX
    TAX                     ;X = Sprite Index that reserved this slot
    LDA $170B|!addr,x       ;
    BEQ .ClearSlot          ;Check if the sprite is still alive
    CMP $00
    BNE .ClearSlot          ;Check if the sprite number is correct
    
    PLX

    PHX
    JSR AddExtendedSprite
    PLX
    BRA .nextSlot

.Cluster
    LDA !SlotSpriteID,x
    PHX
    TAX                     ;X = Sprite Index that reserved this slot

    LDA $1892|!addr,x       ;
    BEQ .ClearSlot          ;Check if the sprite is still alive
    CMP $00
    BNE .ClearSlot          ;Check if the sprite number is correct

    PLX

    PHX
    JSR AddClusterSprite
    PLX
    BRA .nextSlot                ;if all is fine then jump to .add, otherwise clear the slot and go to the next slot

.ClearSlot
    PLX                     ;Restore X
    LDA #$00
    STA !SlotSpriteType,x   ;Clear the slot

.nextSlot
    DEX 
    BMI +                       
    JMP -           ;Go to the next Slot
+
RTS

AddNormalSprite:
    LDA !FPSSprite,x
    BEQ +                   ;Check if it is 30 FPS or 60 FPS, 60FPS use twice of slots

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedEven
    STA !SlotsUsedEven          ;!SlotsUsed += Slots required

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedOdd
    STA !SlotsUsedOdd           ;!SlotsUsed += Slots required

RTS
+

    LDA !SlotSpriteID,x
    PHX
    TAX

    LDA !TransferFrameNormalSprite,x
    JMP Add

AddExtendedSprite:
    LDA !FPSSprite,x
    BEQ +                   ;Check if it is 30 FPS or 60 FPS, 60FPS use twice of slots

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedEven
    STA !SlotsUsedEven          ;!SlotsUsed += Slots required

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedOdd
    STA !SlotsUsedOdd           ;!SlotsUsed += Slots required

RTS
+

    LDA !SlotSpriteID,x
    PHX
    TAX

    LDA !TransferFrameExtendedSprite,x
    BRA Add

AddClusterSprite:
    LDA !FPSSprite,x
    BEQ +                   ;Check if it is 30 FPS or 60 FPS, 60FPS use twice of slots

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedEven
    STA !SlotsUsedEven          ;!SlotsUsed += Slots required

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedOdd
    STA !SlotsUsedOdd           ;!SlotsUsed += Slots required

RTS
+

    LDA !SlotSpriteID,x
    PHX
    TAX

    LDA !TransferFrameClusterSprite,x
    BRA Add

AddOWSprite:
    LDA !FPSSprite,x
    BEQ +                   ;Check if it is 30 FPS or 60 FPS, 60FPS use twice of slots

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedEven
    STA !SlotsUsedEven          ;!SlotsUsed += Slots required

    LDA !SlotsUsedBySprite,x    ;Load the Slots required
    CLC
    ADC !SlotsUsedOdd
    STA !SlotsUsedOdd           ;!SlotsUsed += Slots required

RTS
+

    LDA !SlotSpriteID,x
    PHX
    TAX

    LDA !TransferFrameOWSprite,x

Add:
    AND #$01
    STA $00

    PLX
    LDA !SlotsUsedBySprite,x
    LDX $00
    CLC
    ADC !SlotsUsedEven,x
    STA !SlotsUsedEven,x        ;!SlotsUsed += Slots required
RTS

;This check if there is enough dynamic slots for a dynamic sprites
;Input = Number of Slots Required
;Return Carry Set if there is enough slots, Carry clear if not
CheckSlots:
    PHA                 ;Preserve Number of slots required

    LDA $06
    AND #$01
    TAX

    LDA $01,s
    CLC             
    ADC !SlotsUsedEven,x  ;Check if Slots currently used + slots required < !MaxSlots, then return Carry Set, otherwise update state and check again
    CMP !MaxSlots   
    BCS +
    PLA
    SEC
RTS                 ;Return Carry Set
+
    PLA
    CLC             ;Return Carry Clear
RTS


;Get a Slot Index of Dynamic Sprite Table
;Return X = Slot
;Carry Set if can
;otherwise Carry Clear
GetSlot:
    LDA !MaxSlots 
    TAX
-
    LDA !SlotSpriteType,x   ;Check if unused
    BEQ +
    DEX
    BCS -                   ;Go to next slot
    CLC
RTS
+
    SEC
RTS

ReserveStart:
    JSR ClearSlots          ;Clear Slots

    LDA $01                 ;Loads the slots required
    JSR CheckSlots
    BCS +

    CLC
RTS

+
    JSR GetSlot             ;Get Dynamic Slot on X Register
    BCS +

    CLC
RTS

+

    LDA $01
    STA !SlotsUsedBySprite,x    ;Set the Number of Slots Used
    SEC
RTS

;############################################################
;##################### Reserve Slot #########################
;############################################################

ReserveSlot16x16SignalTable:
    db $00,$01,$01,$01,$00,$02,$02,$02,$00,$02,$02,$02,$00,$02,$02,$02
    db $00,$01,$01,$01,$00,$03,$03,$03,$00,$03,$03,$03,$00,$03,$03,$03
    db $00,$01,$01,$01,$00,$03,$03,$03,$00,$03,$03,$03,$00,$03,$03,$03
    db $00,$01,$01,$01,$00,$03,$03,$03,$00,$03,$03,$03,$00,$03,$03,$03
    db $00,$01,$01,$01,$00,$02,$02,$02,$00,$02,$02,$02,$00,$02,$02,$02
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$02,$02,$02,$00,$02,$02,$02,$00,$02,$02,$02
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$02,$02,$02,$00,$02,$02,$02,$00,$02,$02,$02
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04
    db $00,$01,$01,$01,$00,$04,$04,$04,$00,$04,$04,$04,$00,$04,$04,$04

ReserveSlot16x16SignalTable2:
    db $03,$0C,$30,$C0

macro DefineSlot16x16(Signal,Value)
    PHX
    LDA <Signal>
    TAX
    LDA ReserveSlot16x16SignalTable,x
    PLX
    CMP #$04
    BCS ?+
    
    TAY
    LDA #$FF
    AND ReserveSlot16x16SignalTable2,y
    STA <Signal>
    TYA
    CLC
    ADC <Value>
    PLB
    SEC
RTS
?+
endmacro

ReserveSlot16x16:
    PHB
    PHK
    PLB
    AND #$02
    BEQ .Dowm2Up
    JMP .Up2Down
.Dowm2Up

    %DefineSlot16x16(!SignalSP4SecondHalfBottomLeftQuarter,#$28)
    %DefineSlot16x16(!SignalSP4SecondHalfBottomRightQuarter,#$2C)
    %DefineSlot16x16(!SignalSP4SecondHalfTopLeftQuarter,#$20)
    %DefineSlot16x16(!SignalSP4SecondHalfTopRightQuarter,#$24)
    LDA !NumberOfBlocks
    BNE +
    PLB
    CLC
RTS
+

    %DefineSlot16x16(!SignalSP4FirstHalfBottomLeftQuarter,#$18)
    %DefineSlot16x16(!SignalSP4FirstHalfBottomRightQuarter,#$1C)
    %DefineSlot16x16(!SignalSP4FirstHalfTopLeftQuarter,#$10)
    %DefineSlot16x16(!SignalSP4FirstHalfTopRightQuarter,#$14)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    PLB
    CLC
RTS
+
    %DefineSlot16x16(!SignalSP3SecondHalfBottomLeftQuarter,#$08)
    %DefineSlot16x16(!SignalSP3SecondHalfBottomRightQuarter,#$0C)
    %DefineSlot16x16(!SignalSP3SecondHalfTopLeftQuarter,#$00)
    %DefineSlot16x16(!SignalSP3SecondHalfTopRightQuarter,#$04)
    PLB
    CLC
RTS
.Up2Down

    %DefineSlot16x16(!SignalSP3SecondHalfTopLeftQuarter,#$00)
    %DefineSlot16x16(!SignalSP3SecondHalfTopRightQuarter,#$04)
    %DefineSlot16x16(!SignalSP3SecondHalfBottomLeftQuarter,#$08)
    %DefineSlot16x16(!SignalSP3SecondHalfBottomRightQuarter,#$0C)
    LDA !NumberOfBlocks
    BNE +
    PLB
    CLC
RTS
+

    %DefineSlot16x16(!SignalSP4FirstHalfTopLeftQuarter,#$10)
    %DefineSlot16x16(!SignalSP4FirstHalfTopRightQuarter,#$14)
    %DefineSlot16x16(!SignalSP4FirstHalfBottomLeftQuarter,#$18)
    %DefineSlot16x16(!SignalSP4FirstHalfBottomRightQuarter,#$1C)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    PLB
    CLC
RTS
+
    %DefineSlot16x16(!SignalSP4SecondHalfTopLeftQuarter,#$20)
    %DefineSlot16x16(!SignalSP4SecondHalfTopRightQuarter,#$24)
    %DefineSlot16x16(!SignalSP4SecondHalfBottomLeftQuarter,#$28)
    %DefineSlot16x16(!SignalSP4SecondHalfBottomRightQuarter,#$2C)
    PLB
    CLC
RTS

ReserveSlot32x16SignalTable:
    db $00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    db $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02

ReserveSlot32x16SignalTable2:
    db $0F,$F0

macro DefineSlot32x16(Signal,Value)
    PHX
    LDA <Signal>
    TAX
    LDA ReserveSlot32x16SignalTable,x
    PLX
    CMP #$02
    BCS ?+
    
    TAY
    LDA <Signal>
    ORA ReserveSlot32x16SignalTable2,y
    STA <Signal>
    TYA
    CLC
    ADC <Value>
    PLB
    SEC
RTS
?+
endmacro

ReserveSlot32x16:
    PHB
    PHK
    PLB
    AND #$02
    BEQ .Dowm2Up
    JMP .Up2Down
.Dowm2Up

    %DefineSlot32x16(!SignalSP4SecondHalfBottomLeftQuarter,#$14)
    %DefineSlot32x16(!SignalSP4SecondHalfBottomRightQuarter,#$16)
    %DefineSlot32x16(!SignalSP4SecondHalfTopLeftQuarter,#$10)
    %DefineSlot32x16(!SignalSP4SecondHalfTopRightQuarter,#$12)
    LDA !NumberOfBlocks
    BNE +
    PLB
    CLC
RTS
+

    %DefineSlot32x16(!SignalSP4FirstHalfBottomLeftQuarter,#$0C)
    %DefineSlot32x16(!SignalSP4FirstHalfBottomRightQuarter,#$0E)
    %DefineSlot32x16(!SignalSP4FirstHalfTopLeftQuarter,#$08)
    %DefineSlot32x16(!SignalSP4FirstHalfTopRightQuarter,#$0A)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    PLB
    CLC
RTS
+
    %DefineSlot32x16(!SignalSP3SecondHalfBottomLeftQuarter,#$04)
    %DefineSlot32x16(!SignalSP3SecondHalfBottomRightQuarter,#$06)
    %DefineSlot32x16(!SignalSP3SecondHalfTopLeftQuarter,#$00)
    %DefineSlot32x16(!SignalSP3SecondHalfTopRightQuarter,#$02)
    PLB
    CLC
RTS
.Up2Down

    %DefineSlot32x16(!SignalSP3SecondHalfTopLeftQuarter,#$00)
    %DefineSlot32x16(!SignalSP3SecondHalfTopRightQuarter,#$02)
    %DefineSlot32x16(!SignalSP3SecondHalfBottomLeftQuarter,#$04)
    %DefineSlot32x16(!SignalSP3SecondHalfBottomRightQuarter,#$06)
    LDA !NumberOfBlocks
    BNE +
    PLB
    CLC
RTS
+

    %DefineSlot32x16(!SignalSP4FirstHalfTopLeftQuarter,#$08)
    %DefineSlot32x16(!SignalSP4FirstHalfTopRightQuarter,#$0A)
    %DefineSlot32x16(!SignalSP4FirstHalfBottomLeftQuarter,#$0C)
    %DefineSlot32x16(!SignalSP4FirstHalfBottomRightQuarter,#$0E)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    PLB
    CLC
RTS
+
    %DefineSlot32x16(!SignalSP4SecondHalfTopLeftQuarter,#$10)
    %DefineSlot32x16(!SignalSP4SecondHalfTopRightQuarter,#$12)
    %DefineSlot32x16(!SignalSP4SecondHalfBottomLeftQuarter,#$14)
    %DefineSlot32x16(!SignalSP4SecondHalfBottomRightQuarter,#$16)
    PLB
    CLC
RTS

macro DefineSlot32x32(Signal,Value)
    LDA <Signal>
    BNE ?+
    
    LDA #$FF
    STA <Signal>
    LDA <Value>
    SEC
RTS
?+
endmacro

ReserveSlot32x32:
    AND #$02
    BEQ .Dowm2Up
    JMP .Up2Down
.Dowm2Up
    %DefineSlot32x32(!SignalSP4SecondHalfBottomLeftQuarter,#$0A)
    %DefineSlot32x32(!SignalSP4SecondHalfBottomRightQuarter,#$0B)
    %DefineSlot32x32(!SignalSP4SecondHalfTopLeftQuarter,#$08)
    %DefineSlot32x32(!SignalSP4SecondHalfTopRightQuarter,#$09)
    LDA !NumberOfBlocks
    BNE +
    CLC
RTS
+

    %DefineSlot32x32(!SignalSP4FirstHalfBottomLeftQuarter,#$06)
    %DefineSlot32x32(!SignalSP4FirstHalfBottomRightQuarter,#$07)
    %DefineSlot32x32(!SignalSP4FirstHalfTopLeftQuarter,#$04)
    %DefineSlot32x32(!SignalSP4FirstHalfTopRightQuarter,#$05)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    CLC
RTS
+
    %DefineSlot32x32(!SignalSP3SecondHalfBottomLeftQuarter,#$02)
    %DefineSlot32x32(!SignalSP3SecondHalfBottomRightQuarter,#$03)
    %DefineSlot32x32(!SignalSP3SecondHalfTopLeftQuarter,#$00)
    %DefineSlot32x32(!SignalSP3SecondHalfTopRightQuarter,#$01)
    CLC
RTS
.Up2Down

    %DefineSlot32x32(!SignalSP3SecondHalfTopLeftQuarter,#$00)
    %DefineSlot32x32(!SignalSP3SecondHalfTopRightQuarter,#$01)
    %DefineSlot32x32(!SignalSP3SecondHalfBottomLeftQuarter,#$02)
    %DefineSlot32x32(!SignalSP3SecondHalfBottomRightQuarter,#$03)
    LDA !NumberOfBlocks
    BNE +
    CLC
RTS
+

    %DefineSlot32x32(!SignalSP4FirstHalfTopLeftQuarter,#$04)
    %DefineSlot32x32(!SignalSP4FirstHalfTopRightQuarter,#$05)
    %DefineSlot32x32(!SignalSP4FirstHalfBottomLeftQuarter,#$06)
    %DefineSlot32x32(!SignalSP4FirstHalfBottomRightQuarter,#$07)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    CLC
RTS
+
    %DefineSlot32x32(!SignalSP4SecondHalfTopLeftQuarter,#$08)
    %DefineSlot32x32(!SignalSP4SecondHalfTopRightQuarter,#$09)
    %DefineSlot32x32(!SignalSP4SecondHalfBottomLeftQuarter,#$0A)
    %DefineSlot32x32(!SignalSP4SecondHalfBottomRightQuarter,#$0B)
    CLC
RTS

macro DefineSlot48x48(Signal1,Signal2,Value)
    LDA <Signal1>
    ORA <Signal2>
    BNE ?+
    
    LDA #$FF
    STA <Signal1>
    STA <Signal2>
    LDA <Value>
    SEC
RTS
?+
endmacro
ReserveSlot48x48:
    AND #$02
    BEQ .Dowm2Up
    JMP .Up2Down

.Dowm2Up 
    %DefineSlot48x48(!SignalSP4SecondHalfBottomLeftQuarter,!SignalSP4SecondHalfBottomRightQuarter,#$05)
    %DefineSlot48x48(!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$04)
    LDA !NumberOfBlocks
    BNE +
    CLC
RTS
+
    %DefineSlot48x48(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,#$03)
    %DefineSlot48x48(!SignalSP4FirstHalfTopLeftQuarter,!SignalSP4FirstHalfTopRightQuarter,#$02)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    CLC
RTS
+
    %DefineSlot48x48(!SignalSP4SecondHalfBottomLeftQuarter,!SignalSP4SecondHalfBottomRightQuarter,#$01)
    %DefineSlot48x48(!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$00)
    CLC
RTS

.Up2Down   

    %DefineSlot48x48(!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$00)
    %DefineSlot48x48(!SignalSP4SecondHalfBottomLeftQuarter,!SignalSP4SecondHalfBottomRightQuarter,#$01)
    LDA !NumberOfBlocks
    BNE +
    CLC
RTS
+
    %DefineSlot48x48(!SignalSP4FirstHalfTopLeftQuarter,!SignalSP4FirstHalfTopRightQuarter,#$02)
    %DefineSlot48x48(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,#$03)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    CLC
RTS
+
    %DefineSlot48x48(!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$04)
    %DefineSlot48x48(!SignalSP4SecondHalfBottomLeftQuarter,!SignalSP4SecondHalfBottomRightQuarter,#$05)
    CLC
RTS

macro DefineSlot64x64(Signal1,Signal2,Signal3,Signal4,Value)

    LDA <Signal1>
    ORA <Signal2>
    ORA <Signal3>
    ORA <Signal4>
    BNE ?+

    LDA #$FF
    STA <Signal1>
    STA <Signal2>
    STA <Signal3>
    STA <Signal4>
    LDA <Value>
    SEC
RTS
?+

endmacro

ReserveSlot64x64:
    AND #$02
    BEQ .Dowm2Up
    JMP .Up2Down

.Dowm2Up
    %DefineSlot64x64(!SignalSP4SecondHalfBottomLeftQuarter,!SignalSP4SecondHalfBottomRightQuarter,!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$04)
    LDA !NumberOfBlocks
    BNE +
    CLC
RTS
+
    %DefineSlot64x64(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$03)
    %DefineSlot64x64(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,!SignalSP4FirstHalfTopLeftQuarter,!SignalSP4FirstHalfTopRightQuarter,#$02)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    CLC
RTS
+
    %DefineSlot64x64(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,!SignalSP3SecondHalfTopLeftQuarter,!SignalSP3SecondHalfTopRightQuarter,#$01)
    %DefineSlot64x64(!SignalSP3SecondHalfBottomLeftQuarter,!SignalSP3SecondHalfBottomRightQuarter,!SignalSP3SecondHalfTopLeftQuarter,!SignalSP3SecondHalfTopRightQuarter,#$00)
RTS
    
.Up2Down  
    %DefineSlot64x64(!SignalSP3SecondHalfBottomLeftQuarter,!SignalSP3SecondHalfBottomRightQuarter,!SignalSP3SecondHalfTopLeftQuarter,!SignalSP3SecondHalfTopRightQuarter,#$00)
    
    LDA !NumberOfBlocks
    BNE +
    CLC
RTS
+
    %DefineSlot64x64(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,!SignalSP3SecondHalfTopLeftQuarter,!SignalSP3SecondHalfTopRightQuarter,#$01)
    %DefineSlot64x64(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,!SignalSP4FirstHalfTopLeftQuarter,!SignalSP4FirstHalfTopRightQuarter,#$02)
    LDA !NumberOfBlocks
    CMP #$02
    BCS +
    CLC
RTS
+
    %DefineSlot64x64(!SignalSP4FirstHalfBottomLeftQuarter,!SignalSP4FirstHalfBottomRightQuarter,!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$03)
    %DefineSlot64x64(!SignalSP4SecondHalfBottomLeftQuarter,!SignalSP4SecondHalfBottomRightQuarter,!SignalSP4SecondHalfTopLeftQuarter,!SignalSP4SecondHalfTopRightQuarter,#$04)
RTS

ReserveSlot80x80:
RTS


;############################################################
;####################### Send Signal ########################
;############################################################
Signal16x16:
	db $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$08,$08,$08,$08,$09,$09,$09,$09
	db $06,$06,$06,$06,$07,$07,$07,$07,$04,$04,$04,$04,$05,$05,$05,$05
	db $02,$02,$02,$02,$03,$03,$03,$03,$00,$00,$00,$00,$01,$01,$01,$01

Signal16x16Tab2:
	db $03,$0C,$30,$C0

SendSignal16x16Normal:
    LDA !VRAMDispNormalSprite,x
    BRA SendSignal16x16
SendSignal16x16Extended:
    LDA !VRAMDispExtendedSprite,x
    BRA SendSignal16x16
SendSignal16x16Cluster:
    LDA !VRAMDispClusterSprite,x
    BRA SendSignal16x16
SendSignal16x16OW:
    LDA !VRAMDispOWSprite,x

SendSignal16x16:
    PHB
    PHK
    PLB
	PHX
	TAX
	AND #$03
	TAY

	LDA Signal16x16Tab2,x
	TAX
	LDA !SignalSP4SecondHalfBottomLeftQuarter,x
	ORA Signal16x16Tab2,y
	STA !SignalSP4SecondHalfBottomLeftQuarter,x
	PLX
    PLB
RTL

Signal32x16:
	db $0A,$0A,$0B,$0B,$08,$08,$09,$09
	db $06,$06,$07,$07,$04,$04,$05,$05
	db $02,$02,$03,$03,$00,$00,$01,$01

Signal32x16Tab2:
	db $0F,$F0

SendSignal32x16Normal:
    LDA !VRAMDispNormalSprite,x
    BRA SendSignal32x16
SendSignal32x16Extended:
    LDA !VRAMDispExtendedSprite,x
    BRA SendSignal32x16
SendSignal32x16Cluster:
    LDA !VRAMDispClusterSprite,x
    BRA SendSignal32x16
SendSignal32x16OW:
    LDA !VRAMDispOWSprite,x

SendSignal32x16:
    PHB
    PHK
    PLB
	PHX
	TAX
	AND #$01
	TAY

	LDA Signal32x16,x
	TAX
	LDA !SignalSP4SecondHalfBottomLeftQuarter,x
	ORA Signal32x16Tab2,y
	STA !SignalSP4SecondHalfBottomLeftQuarter,x
	PLX
    PLB
RTL

Signal32x32:
	db $0A,$0B,$08,$09,$06,$07,$04,$05,$02,$03,$00,$01

SendSignal32x32Normal:
    LDA !VRAMDispNormalSprite,x
    BRA SendSignal32x32
SendSignal32x32Extended:
    LDA !VRAMDispExtendedSprite,x
    BRA SendSignal32x32
SendSignal32x32Cluster:
    LDA !VRAMDispClusterSprite,x
    BRA SendSignal32x32
SendSignal32x32OW:
    LDA !VRAMDispOWSprite,x
SendSignal32x32:
    PHB
    PHK
    PLB
	PHX
	TAX

	LDA Signal32x32,x
	TAX
	LDA #$FF
	STA !SignalSP4SecondHalfBottomLeftQuarter,x
	PLX
    PLB
RTL

Signal48x48:
	db $0A,$08,$06,$04,$02,$00

SendSignal48x48Normal:
    LDA !VRAMDispNormalSprite,x
    BRA SendSignal48x48
SendSignal48x48Extended:
    LDA !VRAMDispExtendedSprite,x
    BRA SendSignal48x48
SendSignal48x48Cluster:
    LDA !VRAMDispClusterSprite,x
    BRA SendSignal48x48
SendSignal48x48OW:
    LDA !VRAMDispOWSprite,x
SendSignal48x48:
    PHB
    PHK
    PLB
	PHX
	TAX

	LDA Signal48x48,x
	TAX
	LDA #$FF
	STA !SignalSP4SecondHalfBottomLeftQuarter,x
	STA !SignalSP4SecondHalfBottomLeftQuarter+$01,x
	PLX
	PLB
RTL

Signal64x64:
	db $08,$06,$04,$02,$00

SendSignal64x64Normal:
    LDA !VRAMDispNormalSprite,x
    BRA SendSignal64x64
SendSignal64x64Extended:
    LDA !VRAMDispExtendedSprite,x
    BRA SendSignal64x64
SendSignal64x64Cluster:
    LDA !VRAMDispClusterSprite,x
    BRA SendSignal64x64
SendSignal64x64OW:
    LDA !VRAMDispOWSprite,x
SendSignal64x64:
    PHB
    PHK
    PLB
	PHX
	TAX

	LDA Signal64x64,x
	TAX
	LDA #$FF
	STA !SignalSP4SecondHalfBottomLeftQuarter,x
	STA !SignalSP4SecondHalfBottomLeftQuarter+$01,x
    STA !SignalSP4SecondHalfBottomLeftQuarter+$02,x
    STA !SignalSP4SecondHalfBottomLeftQuarter+$03,x
	PLX
	PLB
RTL
;############################################################
;##################### Dynamic Routine ######################
;############################################################

;Call
!FrameIndex = $45
!BNK = $46
!GFXPointer = $47
!ResourceOffset = $4A
!ResourceSize = $4D
!Lines = $50

macro CheckLine(ValueId)
    SEP #$30
    LDA <ValueId>
    CMP !Lines
    BCC ?+
    RTL
?+
endmacro

macro LoadLine(Offset1, offset2)	
    LDA [!GFXPointer]					;\
	CLC									;|
	ADC [!ResourceOffset],y				;|Load graphics offset of the first line of the current frame
	STA !DMAMapResource+<Offset1>,x		;|to be loaded by Dynamic Z

					                    ;\
    LDA [!ResourceSize],y				;|Load How many bytes must load on the first line
	STA !DMAMapLenght+<Offset1>,x		;|

    SEP #$30

	LDX $00

	LDA !BNK							;|Load the bank of the off set for the first line
	STA !DMAMapBNK+<offset2>,x			;/
endmacro

macro NextIndexs()
    REP #$30
    LDA $06
    INC A
    INC A
    STA $06
    TAY
    LDX $04

endmacro

macro EndLine(offset1)
	LDA !LastSlot
	TAX

	LDA $00					;\
	CLC						;|
	ADC #<offset1>			;|Add Second line at the end of the list
	STA !DMAMapNext,x		;|
	STA !LastSlot			;|

	LDX $00
	LDA #$FF				;|
	STA !DMAMapNext++<offset1>,x	;/
endmacro

VRAMSlot16x16:
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $10,$11,$12,$13,$14,$15,$16,$17
	db $20,$21,$22,$23,$24,$25,$26,$27
	db $30,$31,$32,$33,$34,$35,$36,$37
	db $40,$41,$42,$43,$44,$45,$46,$47
	db $50,$51,$52,$53,$54,$55,$56,$57

VRAMSlot32x16:
	db $00,$02,$04,$06
	db $10,$12,$14,$16
	db $20,$22,$24,$26
	db $30,$32,$34,$36
	db $40,$42,$44,$46
	db $50,$52,$54,$56

VRAMSlot32x32:
	db $00,$04,$10,$14
	db $20,$24,$30,$34
	db $40,$44,$50,$54

VRAMSlot48x48:
	db $00,$10
	db $20,$30
	db $40,$50

VRAMSlot64x64:
	db $00
	db $10,$20
	db $30,$40

DynamicRoutine16x16:
	TAY 								;|Obtain VRAM displacement to know where 
    PHB
    PHK
    PLB

    LDA VRAMSlot16x16,y					    ;|The graphics will be loaded
	STA $00								;|$00 = VRAM displacement; it is 16bits
    PLB
    BRA DynamicRoutine2Lines

DynamicRoutine32x16:
	TAY 								;|Obtain VRAM displacement to know where 
    PHB
    PHK
    PLB

    LDA VRAMSlot32x16,y					    ;|The graphics will be loaded
	STA $00								;|$00 = VRAM displacement; it is 16bits
    PLB
    BRA DynamicRoutine2Lines

DynamicRoutine32x32:
	TAY 								;|Obtain VRAM displacement to know where 
    PHB
    PHK
    PLB

    LDA VRAMSlot32x32,y					    ;|The graphics will be loaded
	STA $00								;|$00 = VRAM displacement; it is 16bits
    PLB
    BRA DynamicRoutine2Lines

DynamicRoutine48x48:
	TAY 								;|Obtain VRAM displacement to know where 
    PHB
    PHK
    PLB

    LDA VRAMSlot48x48,y					    ;|The graphics will be loaded
	STA $00								;|$00 = VRAM displacement; it is 16bits
    PLB
    BRA DynamicRoutine2Lines

DynamicRoutine64x64:
	TAY 								;|Obtain VRAM displacement to know where 
    PHB
    PHK
    PLB

    LDA VRAMSlot64x64,y					    ;|The graphics will be loaded
	STA $00								;|$00 = VRAM displacement; it is 16bits
    PLB
    BRA DynamicRoutine4Lines


DynamicRoutine6Lines:
    STZ $01
    STZ $03

    LDA #$06
    STA !Lines

	REP #$30							;|
	LDA $02								;|Obtain Index to Resource Tables
	ASL									;|$06 = X = Index
    CLC
    ADC $02
	ASL									;|
	STA $06								;|

    BRA DynamicRoutine
DynamicRoutine4Lines:
    STZ $01
    STZ $03

    LDA #$04
    STA !Lines

	REP #$30							;|
	LDA $02								;|Obtain Index to Resource Tables
	ASL									;|$06 = X = Index
	ASL									;|
    ASL
	STA $06								;|

    BRA DynamicRoutine
DynamicRoutine2Lines:
    STZ $01
    STZ $03

    LDA #$02
    STA !Lines

	REP #$30							;|
	LDA $02								;|Obtain Index to Resource Tables
	ASL									;|$06 = X = Index
	ASL									;|
	STA $06								;|

DynamicRoutine:

	LDA $00
	ASL
	STA $04								;$04 = VRAM displacement*2

    LDY $06
    LDX $04

    %LoadLine($00,$00)

	LDA !FirstSlot						;\
	CMP #$FF							;|
	BNE +								;|
										;|
	LDA $00								;|
	STA !FirstSlot						;|
	STA !LastSlot
	BRA ++								;|Add the line to the list of dynamic routines
										;|It works like a Linked Link
+										;|If List is empty add at the first slot
	LDA !LastSlot						;|If List is not empty add at the last slot
	TAX									;|
	LDA $00								;|
	STA !DMAMapNext,x					;|
	STA !LastSlot
++										;|
	TAX									;|
	LDA #$FF							;|
	STA !DMAMapNext,x					;/

    %CheckLine(#$01)

    %NextIndexs()

	LDA [!ResourceSize],y				;|If second is cover by the first line then 
	BEQ +								;|doesn't load it

    %LoadLine($10,$08)

    %EndLine($08)

+
    %CheckLine(#$02)

    %NextIndexs()
	
	LDA [!ResourceSize],y				;|If second is cover by the first line then 
	BEQ +								;|doesn't load it

    %LoadLine($20,$10)

    %EndLine($10)

+
    %CheckLine(#$03)

    %NextIndexs()
	
	LDA [!ResourceSize],y				;|If second is cover by the first line then 
	BEQ +								;|doesn't load it

    %LoadLine($30,$18)

    %EndLine($18)

+
    %CheckLine(#$04)

    %NextIndexs()
	
	LDA [!ResourceSize],y				;|If second is cover by the first line then 
	BEQ +								;|doesn't load it

    %LoadLine($40,$20)

    %EndLine($20)

+
    %CheckLine(#$05)

    %NextIndexs()
	
	LDA [!ResourceSize],y				;|If second is cover by the first line then 
	BEQ +								;|doesn't load it

    %LoadLine($50,$28)

    %EndLine($28)

+
RTL