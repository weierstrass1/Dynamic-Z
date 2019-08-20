;Reserve a 32x32 slot for a Normal Dynamic Sprite of 30FPS
Reserve32x32NormalSpriteOf30FPS:
    JSR AssignFrameDistribution
    LDA !TransferFrameNormalSprite,x
    STA $06

    PHB
    PHK
    PLB

    LDA #$01                    ;Require 1 Slot
    STA $01
    JSR ReserveStart
    BCS +

    LDX $15E9|!addr
    JSR ReloadSprite            ;if there not enough slots then it must be reloaded
    PLB
RTL

+
    PHX
    TAX
    LDA !SpriteNumber,x
    PLX
    STA !SlotSpriteNumber,x     ;Set the sprite Number

    LDA $15E9|!addr
    STA !SlotSpriteID,x         ;Set the Sprite ID

    LDA #$01
    STA !SlotSpriteType,x       ;Type = Normal
    LDA #$00
    STA !FPSSprite,x            ;30FPS

    STX $00                     ;Preserve X in Scratch 0

    LDX $15E9|!addr
    JSR ReserveSlot32x32        ;Get Slot on VRAM
    BCS +

    LDX $00                     ;If dont find a slot, the sprite must be reloaded, and clear the slot
    LDA #$00
    STA !SlotSpriteType,x

    LDX $15E9|!addr
    JSR ReloadSprite
    PLB
RTL
+               
    LDX $15E9|!addr             ;Restore X
    STA !VRAMDispNormalSprite,x ;Set Vram Offset
    PLB
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
    BCS +

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

Reserve32x32Table:
    db $02,$02,$02,$02,$03,$00,$00,$00,$03,$00,$00,$00,$03,$00,$00,$00
    db $02,$02,$02,$02,$03,$00,$00,$00,$03,$00,$00,$00,$03,$00,$00,$00
    db $02,$02,$02,$02,$03,$00,$00,$00,$03,$00,$00,$00,$03,$00,$00,$00
    db $02,$02,$02,$02,$03,$00,$00,$00,$03,$00,$00,$00,$03,$00,$00,$00
    db $02,$02,$02,$02,$03,$01,$01,$01,$03,$01,$01,$01,$03,$01,$01,$01
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$01,$01,$01,$03,$01,$01,$01,$03,$01,$01,$01
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$01,$01,$01,$03,$01,$01,$01,$03,$01,$01,$01
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04
    db $02,$02,$02,$02,$03,$04,$04,$04,$03,$04,$04,$04,$03,$04,$04,$04

ReserveSlot32x32:

    LDA !SignalsSP4SecondHalf
    TAX

    LDA Reserve32x32Table,x
    CMP #$04
    BCS +

    CLC
    ADC #$08
    SEC
RTS
+

    LDA !NumberOfBlocks
    BEQ .ret

    LDA !SignalsSP4FirstHalf
    TAX

    LDA Reserve32x32Table,x
    CMP #$04
    BCS +

    CLC
    ADC #$04
    SEC
RTS
+

    LDA !NumberOfBlocks
    CMP #$02
    BCC .ret

    LDA !SignalsSP3SecondHalf
    TAX

    LDA Reserve32x32Table,x
    CMP #$04
    BCS .ret

    SEC
RTS
.ret

    CLC
RTS

ReserveSlot48x48:
RTS

ReserveSlot64x64:
RTS

ReserveSlot80x80:
RTS

