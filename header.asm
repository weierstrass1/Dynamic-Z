!True = 1	;\Do not change these.
!False = 0	;/

;#########################################################<-----------------
;#########################################################<-----------------
;################ Dynamic Z Options ######################<-----------------
;#########################################################<-----------------
;#########################################################<-----------------

;Next use Hijacks: $00823D and $0082DA
;No patches uses thats hijacks.
;This hijacks are required always
!DynamicSpritesSupport = !True          ;Allows Dynamic Z dynamic sprites support, sprites that loads their graphics dynamically
!GiantDynamicSpritesSupport = !True     ;Allows dynamic sprites of 96x96 (or less) and 112x112 (or less, 112x112 requires 50% more mode)
!SemiDynamicSpritesSupport = !True      ;Allows semi-dynamic sprites that loads all their graphics only when they enter on the screen
                                        ;Each copy of the sprite use the same graphics. This is a system similar to Megaman X Sprites
!DSXRetrocompatibilitySupport = !True   ;Allows Old Dynamic Sprite Patch's Dynamic Sprites compatiblity
!GFXChangeSupport = !True               ;Allows to change graphics and tilemaps dynamically, you can use it from blocks, sprites, uberasm level code, etc.
!PaletteChangeSupport = !True           ;Allows to change color palettes dynamically, you can use it from blocks, sprites, uberasm level code, etc.

;Very situational option, basically you can set parameters
;of DMA transfer from other code like a uberasm and it will
;start the transfer during nmi, not very usefull, but maybe
;someone need it.
!AllowsDMAMirror = !False

;Next use Hijacks: $00F636 and $00A300
;Possible incompatibilities with patches that change the GFX of mario.
;Patches with possible incompatibilities: LX5's Custom Powerups.
!OptimizeOriginalPlayerDMARoutine = !False  ;Optimize the original DMA routine of mario, saving time during NMI and decreasing slowdown a bit
!PlayerGraphicsChangeSupport = !False       ;Allows to change graphics for players of 16x32
!PlayerPaletteChangeSupport = !False        ;Allows to change player color paletts (colors between $86 and $8F)
!FullyCustomPlayerSupport = !False          ;Allows to do players of any size and that use any palette, requires custom interaction
!Include32x32PlayerPatch = !False           ;Allows to use the patch 32x32 Player, then you can do players of that size easier
!IncludeMario8x8TilesDMAerPatch = !False    ;Allows to use the Mario's 8x8 Tiles DMAer, to save some space on SP1

;Next use Hijacks: $008E1A, $008DAC, $008CFF, $008292, $00A43E, $00A4E3 and $00A3F0
;Possible incompatibilities with patches that changes status bar or change 
;default Not-Mario/Yoshi DMA from smw.
;This mode allows you to transfer 50% more data using DMA
;But meanwhile it is active, some sprites, original animations of graphics and palettes and the original status bar
;Will stop to work
;This mode can be activate using uberasm, sprites, blocks, etc.
!Mode50moreSupport = !False

;Note: Every feature can be used from uberasm, sprites, blocks, etc.
;#########################################################<-----------------
;#########################################################<-----------------
;################ END of Dynamic Z Options ###############<-----------------
;#########################################################<-----------------
;#########################################################<-----------------

;dont touch this
	!dp = $0000
	!addr = $0000
    !rom = $800000
	!sa1 = 0
    !DSXFreeRAM = $7F0B44
    !PaletteFreeRAM = $7FB700 
    !MaxSprites = $0C
    !SpriteStatus = $14C8
    !SpriteNumber = $7FAB9E
    !SpriteLoadStatus = $161A
    !SpriteLoadTable = $7FAF00
    !ExtraProp1 = $7FAB28


if read1($00FFD5) == $23
fullsa1rom
	!dp = $3000
	!addr = $6000
	!sa1 = 1
    !rom = $000000
    !DSXFreeRAM = $418000
    !PaletteFreeRAM = $418700  
    !MaxSprites = $16
    !SpriteStatus = $3242
    !SpriteNumber = $400083
    !SpriteLoadStatus = $7578
    !SpriteLoadTable = $418A00
    !ExtraProp1 = $400057
endif

    !Variables = !PaletteFreeRAM+$180

;#################################################<-----------------
;#################################################<-----------------
;################# Free Rams #####################<-----------------
;#################################################<-----------------
;#################################################<-----------------

;#################################################
;############# Dynamic Sprite Support ############
;#################################################

!DynamicTimer = !Variables
!SignalsSP4SecondHalf = !Variables+$0001
!SignalsSP4FirstHalf = !Variables+$0002
!SignalsSP3SecondHalf = !Variables+$0003
!SlotsUsedEven = !Variables+$0004
!SlotsUsedOdd = !Variables+$0005
!MaxSlots = !Variables+$0006
!NumberOfBlocks = !Variables+$0007
!VRAMDispNormalSprite = !Variables+$0008
!VRAMDispExtendedSprite = !Variables+$0008+!MaxSprites
!VRAMDispClusterSprite = !Variables+$0012+!MaxSprites
!VRAMDispOWSprite = !Variables+$0026+!MaxSprites
!TransferFrameNormalSprite = !Variables+$0036+!MaxSprites
!TransferFrameExtendedSprite = !Variables+$0036+!MaxSprites+!MaxSprites
!TransferFrameClusterSprite = !Variables+$0040+!MaxSprites+!MaxSprites
!TransferFrameOWSprite = !Variables+$0054+!MaxSprites+!MaxSprites
!SlotsUsedBySprite = !Variables+$0064+!MaxSprites+!MaxSprites
!FPSSprite = !Variables+$0070+!MaxSprites+!MaxSprites
!SlotSpriteType = !Variables+$007C+!MaxSprites+!MaxSprites
!SlotSpriteID = !Variables+$0088+!MaxSprites+!MaxSprites
!SlotSpriteNumber = !Variables+$0094+!MaxSprites+!MaxSprites
!DMAMapResource = !Variables+$00A0+!MaxSprites+!MaxSprites
!DMAMapBNK = !Variables+$0160+!MaxSprites+!MaxSprites
!DMAMapLenght = !Variables+$01C0+!MaxSprites+!MaxSprites
!DMAMapNext = !Variables+$0280+!MaxSprites+!MaxSprites
!FirstSlot = !Variables+$02E0+!MaxSprites+!MaxSprites
!LastSlot = !Variables+$02E1+!MaxSprites+!MaxSprites
!Mode50More = !Variables+$02E2+!MaxSprites+!MaxSprites

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
!Routines = (read1($0082DA+4)<<16)+read2($00823D+4)

!Reserve32x32NormalSpriteOf30FPS = read3(!Routines+0)
