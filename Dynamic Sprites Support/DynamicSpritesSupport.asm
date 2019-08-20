VRAMTable:
;SP 3 Second Half
    dw $7400,$7420,$7440,$7460,$7480,$74A0,$74C0,$74E0
    dw $7500,$7520,$7540,$7560,$7580,$75A0,$75C0,$75E0
    dw $7600,$7620,$7640,$7660,$7680,$76A0,$76C0,$76E0
    dw $7700,$7720,$7740,$7760,$7780,$77A0,$77C0,$77E0
;SP 4 First Half
    dw $7800,$7820,$7840,$7860,$7880,$78A0,$78C0,$78E0
    dw $7900,$7920,$7940,$7960,$7980,$79A0,$79C0,$79E0
    dw $7A00,$7A20,$7A40,$7A60,$7A80,$7AA0,$7AC0,$7AE0
    dw $7B00,$7B20,$7B40,$7B60,$7B80,$7BA0,$7BC0,$7BE0
;SP 4 Second Half
    dw $7C00,$7C20,$7C40,$7C60,$7C80,$7CA0,$7CC0,$7CE0
    dw $7D00,$7D20,$7D40,$7D60,$7D80,$7DA0,$7DC0,$7DE0
    dw $7E00,$7E20,$7E40,$7E60,$7E80,$7EA0,$7EC0,$7EE0
    dw $7F00,$7F20,$7F40,$7F60,$7F80,$7FA0,$7FC0,$7FE0

DynamicSpriteSupport:

    LDA !FirstSlot          ;Load First Slot
    STA $0000|!dp           ;Save it on !Scratch0
    CLC
    ASL 
    TAX                     ;X = SlotX2

    CPX #$C0
    BCS .end                ;If the slot is not valid (more than C0), then return
-
    REP #$20
    LDA VRAMTable,x
    STA $2116               ;Loads VRAM destination

    LDA !DMAMapResource,x
    STA $02                 ;Load Resource

    LDA !DMAMapLenght,x
    STA $05                 ;Load Length

    SEP #$20
    LDX $0000|!dp           ;X = Slot

    LDA !DMAMapBNK,x
    STA $04                 ;Load the BNK

    STY $420B               ;Start the DMA Transfer

    LDA !DMAMapNext,x       ;Get Next Slot
    STA $0000|!dp           ;Scratch 0 = Slot

    LDA #$FF
    STA !DMAMapNext,x       ;Put FF to the current Slot
    
    LDA $0000|!dp           ;Scratch 0 = Slot
    CLC
    ASL
    TAX                     ;X = SlotX2
    CPX #$C0
    BCC -                   ;If the slot is not valid (more than C0), then return
.end 
    LDA #$FF
    STA !FirstSlot          ;First Slot is FF now
RTS