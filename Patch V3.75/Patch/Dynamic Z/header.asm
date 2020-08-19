;#########################################################<-----------------
;#########################################################<-----------------
;################ END of Dynamic Z Options ###############<-----------------
;#########################################################<-----------------
;#########################################################<-----------------

;DS = Dynamic Sprite
;GDS = Giant Dynamic Sprite
;SDS = Semi-Dynamic Sprite

;#################################################<-----------------
;#################################################<-----------------
;############# Editable Constants ################<-----------------
;#################################################<-----------------
;#################################################<-----------------

;Constants for level
!DefaultLevelDSVRAMOFfset = $7800       ;6000 = SP3, 6400 = Second half SP1
                                        ;6800 = SP2, 6C00 = Second half SP2
                                        ;7000 = SP3, 7400 = Second half SP3
                                        ;7800 = SP4, 7C00 = Second half SP4
                                        ;Recommended 7000, 7400 or 7800 without 50% more mode or without scanlines sacrifice
                                        ;Recommended 7000 or 7400 with 50% more mode or with scanline sacrifice
!DefaultLevelDSVRAMOffsetIn8x8Tiles #= ((!DefaultLevelDSVRAMOFfset-$6000)/$10)&$FF
!DefaultLevelDSMaxSpaceIn16x16Tiles = $20   ;number of 16x16 tiles that can use by default
!DefaultLevelMaxDataTransferPerFrameIn16x16Tiles = $10  ;number of 16x16 tiles that can transfer per frame by default
                                                        ;Recommended $10 without 50% more mode or without scanlines sacrifice
                                                        ;Recommended $18 with 50% more mode
                                                        ;With scanlines sacrifice, must calculate number based on how many scanlines
                                                        ;In this case i recommend:
                                                        ;3 on the top, 4 on the bottom, No 50% more mode = $18, With 50% more mode = $20
                                                        ;6 on the top, 7 on the bottom, No 50% more mode = $20, With 50% more mode = $28
                                                        ;9 on the top, 10 on the bottom, No 50% more mode = $28, With 50% more mode = $30
                                                        ;12 on the top, 13 on the bottom, No 50% more mode = $30
                                                        ;etc... Basically 50% more mode is a +8 and 3n lines on the top and 3n+1 on the bottom is a +8n
!DefaultLevelMaxDataTransferPerFrame = $0800
!DefaultLevelFindMethod = $01
;Constants for Overworld
!DefaultOWDSVRAMOFfset = $6800 
!DefaultOWDSVRAMOffsetIn8x8Tiles #= ((!DefaultOWDSVRAMOFfset-$6000)/$10)&$FF
!DefaultOWDSMaxSpace = $20
!DefaultOWMaxDataTransferPerFrameIn16x16Tiles = $10    
!DefaultOWMaxDataTransferPerFrame = $0800
!DefaultOWFindMethod = $01     

;#################################################<-----------------
;#################################################<-----------------
;################# Free Rams #####################<-----------------
;#################################################<-----------------
;#################################################<-----------------

;#################################################
;############# Dynamic Sprite Support ############
;#################################################

struct DZ !Variables
    .Timer: skip 1
    .MaxDataPerFrameIn16x16Tiles: skip 1
    .MaxDataPerFrame: skip 2

    .DynamicSprite:
        .DSLength: skip 1
        ;Last slot used
        .DSLastSlot: skip 1
        ;First slot used
        .DSFirstSlot: skip 1
        ;Max space that can be used on the VRAM, must be between $00 and $30
        .DSMaxSpace: skip 1
        ;0 = Find starting at the bottom to the top, 1 find starting at the top to the bottom
        .DSFindSpaceMethod: skip 1
        ;Where starts the space for dynamic sprites
        .DSStartingVRAMOffset: skip 2
        .DSStartingVRAMOffset8x8Tiles: skip 1
        .DSTotalSpaceUsed: skip 1
        .DSTotalSpaceUsedOdd: skip 1
        .DSTotalSpaceUsedEven: skip 1
        .DSTotalDataSentOdd: skip 1
        .DSTotalDataSentEven: skip 1
        .DSCurrentSlotSearcher: skip 1
        .DSSlotSearchedOffset: skip 1

        .LocalVars:
            .DSLocUsedBy: skip 48
            .DSLocSpriteNumber: skip 48
            .DSLocSharedUpdated: skip 48
            .DSLocSpaceUsedOffset: skip 48
            .DSLocSpaceUsed: skip 48
            .DSLocIsValid: skip 48
            .DSLocFrameRateMethod: skip 48
            .DSLocNextSlot: skip 48
            .DSLocPreviewSlot: skip 48
            .DSLocSharedFrame: skip 48

            .UsedSlots:
                .DSLocUSNormal: skip !MaxSprites
                .DSLocUSCluster: skip 20
                .DSLocUSExtended: skip 10
                .DSLocUSOW: skip 16
endstruct

struct PPUMirrors extends DZ
    .Reg420B: skip 1
    .CGRAM:
        .CGRAMTransferLength: skip 1
        .CGRAMTransferSourceBNKLength: skip 128
        .CGRAMTransferOffset: skip 64
        .CGRAMTransferSource: skip 128
        .CGRAMLastPlayerPal: skip 2
    .VRAM
        .VRAMTransferLength: skip 1
        .VRAMTransferSourceLength: skip 190
        .VRAMTransferOffset skip 190
        .VRAMTransferSource: skip 190
        .VRAMTransferSourceBNK: skip 190
    .WideScreen:
        .WSEnable: skip 1
        .WSLinesDeletedOnTheTop: skip 1
        .WSLinesDeletedOnTheBottom: skip 1
        .WSBuffer: skip 435
endstruct

;#################################################
;########## Giant Dynamic Sprite Support #########
;#################################################

;#################################################
;########## Semi Dynamic Sprite Support ##########
;#################################################

;#################################################
;########### DSX Dynamic Sprite Support ##########
;#################################################

;#################################################
;############# Graphic Change Support ############
;#################################################

;#################################################
;############# Palette Change Support ############
;#################################################

;#################################################
;############### DMA Mirror Support ##############
;#################################################

;#################################################
;######## Original Player DMA Optimization #######
;#################################################

;#################################################
;##### 16x32 Player Graphic Change Support #######
;#################################################

;#################################################
;######## Player Palette Change Support ##########
;#################################################

;#################################################
;######### Fully Custom Player Support ###########
;#################################################

;#################################################
;############# 32x32 Player Patch ################
;#################################################

;#################################################
;####### Mario's 8x8 Tiles DMA-er Patch ##########
;#################################################

;#################################################
;############ 50% More Mode Support ##############
;#################################################

;#################################################<-----------------
;#################################################<-----------------
;############## Dynamic Z Library ################<-----------------
;#################################################<-----------------
;#################################################<-----------------
!Routines = ((read1($0082DA+4)<<16)+read2($00823D+4))|!rom

!ClearSlot = read3(!Routines)
!CheckSlot = read3(!Routines+$03)
!FindSpace = read3(!Routines+$06)
!DynamicRoutine = read3(!Routines+$09)

!SpriteNumberToGraphics = read3(!Routines+$0C)
!CheckEvenOrOdd = read3(!Routines+$0F)
!GetVramDisp = read3(!Routines+$12)
!GetVramDispDynamicRoutine = read3(!Routines+$15)
!RemapOamTile = read3(!Routines+$18)
!CheckNormalSharedDynamicExisted = read3(!Routines+$1B)
!CheckClusterSharedDynamicExisted = read3(!Routines+$1E)
!CheckExtendedSharedDynamicExisted = read3(!Routines+$21)
!CheckOWSharedDynamicExisted = read3(!Routines+$24)
!CheckIfLastNormalSharedProcessed = read3(!Routines+$27)
!CheckIfLastClusterSharedProcessed = read3(!Routines+$2A)
!CheckIfLastExtendedSharedProcessed = read3(!Routines+$2D)
!CheckIfLastOWSharedProcessed = read3(!Routines+$30)

macro FindSpace(DSSlotUsed)
    LDA.l <DSSlotUsed>
    STA !Scratch0

    JSL !FindSpace
endmacro

macro CheckSlot(FrameRateMode, NumberOf16x16Tiles, SpriteNumber, SpriteTypeAndSlot, SpriteUsedSlot)
    JSL !ClearSlot
    
    PHX

    TSC
    PHA

    TXA
if <SpriteTypeAndSlot> < $80
    AND #$0F
else
    AND #$E0
endif
    ORA <SpriteTypeAndSlot>
    PHA

    LDA <FrameRateMode>
    PHA

    LDA <SpriteNumber>
    PHA

    LDA <NumberOf16x16Tiles>
    PHA
    JSL !CheckSlot
    BCS ?+
if !sa1
    PLA
    PLA
    PLA
    PLA
    PLA
else
    LDA #$01
    XBA
    LDA $05,s
    TCS
endif

    PLX
    STZ <SpriteNumber>
    BRA ?++
?+
if !sa1
    PLA
    PLA
    PLA
    PLA
    PLA
else
    LDA #$01
    XBA
    LDA $05,s
    TCS
endif

    TXA
    PLX
	STA.l <SpriteUsedSlot>,x
?++
endmacro

macro CheckSlotNormalSprite(NumberOf16x16Tiles, SpriteTypeAndSlot)
    JSL !ClearSlot
    
    TSC
    PHA

    TXA
    ORA #<SpriteTypeAndSlot>
if <SpriteTypeAndSlot> < $80
    AND #$9F
else
    AND #$90
endif
    PHA

    LDA !ExtraByte1,x
    CLC
    ROL
    ROL
    ROL
    AND #$02
    PHA

    LDA !SpriteNumberNormal,x
    PHA

    LDA <NumberOf16x16Tiles>
    PHA
    JSL !CheckSlot
    BCS ?+
    
if !sa1
    PLA
    PLA
    PLA
    PLA
    PLA
else
    LDA #$01
    XBA
    LDA $05,s
    TCS
endif

    LDX $15E9|!addr
    STZ !SpriteStatus,x
    LDA !SpriteLoadStatus,x
    TAX
    LDA #$00
    STA !SpriteLoadTable,x
    LDX $15E9|!addr

RTL
?+
if !sa1
    PLA
    PLA
    PLA
    PLA
    PLA
else
    LDA #$01
    XBA
    LDA $05,s
    TCS
endif

    TXA
    LDX $15E9|!addr
	STA.l DZ.DSLocUSNormal,x
endmacro

macro DynamicRoutine(VRAMOffset, ResourceAddr, ResourceBNK, ResourceOffset, size)
    PHX                     ;B

    TSC
    PHA                     ;B

    LDA <size>              ;A
    PHA

    LDA <VRAMOffset>        ;9
    PHA

    LDA.b <ResourceBNK>     ;8
    PHA

    REP #$20
    LDA.w <ResourceAddr>
    CLC
    ADC <ResourceOffset>
    PHA                     ;6
    SEP #$20
    JSL !DynamicRoutine

if !sa1
    PLA
    PLA
    PLA
    PLA
    PLA
    PLA
else
    LDA #$01
    XBA
    LDA $06,s
    TCS
endif

    PLX

endmacro

macro GFXTabDef(index)
    !GraphicsTable #= read3(!SpriteNumberToGraphics+<index>+<index>+<index>)
endmacro

macro GFXDef(offset)
    !GFX<offset> = read3(!GraphicsTable+$05+$<offset>+$<offset>+$<offset>)
endmacro

macro CheckEvenOrOdd(DSLocUS)
	LDA.l <DSLocUS>,x
    JSL !CheckEvenOrOdd
endmacro

macro GetVramDisp(DSLocUS)
	LDA.l <DSLocUS>,x
    JSL !GetVramDisp
endmacro

macro GetVramDispDynamicRoutine(DSLocUS)
	LDA.l <DSLocUS>,x
    JSL !GetVramDispDynamicRoutine
endmacro

macro RemapOamTile(Tile, Offset)

    LDA <Tile>
    PHA

    LDA <Offset>
    PHA
    JSL !RemapOamTile
    PLA
    PLA
endmacro

macro TransferToVRAM(VRAMOffset, ResourceAddr, ResourceBNK, Lenght)

    PHX

    LDA #$00
    XBA
    LDA.l DZ.PPUMirrors.VRAMTransferLength
    INC A
    STA.l DZ.PPUMirrors.VRAMTransferLength
    REP #$20
    ASL
    TAX
    
    LDA <ResourceBNK>
    STA.l  DZ.PPUMirrors.VRAMTransferSourceBNK,x
    LDA #$0000
    STA.l  DZ.PPUMirrors.VRAMTransferSourceBNK+1,x

    LDA <ResourceAddr>
    STA.l DZ.PPUMirrors.VRAMTransferSource,x

    LDA <Lenght>
    STA.l DZ.PPUMirrors.VRAMTransferSourceLength,x

    LDA <VRAMOffset>
    STA.l DZ.PPUMirrors.VRAMTransferOffset,x
    SEP #$20
    
    PLX

endmacro

macro TransferToCGRAM(CGRAMOffset, TableAddr, TableBNK, Lenght)

    PHX

    LDA #$00
    XBA
    LDA.l DZ.PPUMirrors.CGRAMTransferLength
    INC A
    PHA
    STA.l DZ.PPUMirrors.CGRAMTransferLength
    REP #$30
    ASL
    TAX

    LDA <TableAddr>
    STA.l DZ.PPUMirrors.CGRAMTransferSource,x

    LDA <TableBNK>
    STA.l DZ.PPUMirrors.CGRAMTransferSourceBNKLength,x

    LDA <Lenght>
    STA.l DZ.PPUMirrors.CGRAMTransferSourceBNKLength+1,x
    SEP #$30
    
    PLX
    LDA <CGRAMOffset>
    STA.l DZ.PPUMirrors.CGRAMTransferOffset,x

    PLX

endmacro