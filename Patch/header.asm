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
    !PaletteFreeRAM = $7F0B44 
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
    !PaletteFreeRAM = $418000  
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
!SignalSP4SecondHalfBottomLeftQuarter = !Variables+$0001
!SignalSP4SecondHalfBottomRightQuarter = !Variables+$0002
!SignalSP4SecondHalfTopLeftQuarter = !Variables+$0003
!SignalSP4SecondHalfTopRightQuarter = !Variables+$0004
!SignalSP4FirstHalfBottomLeftQuarter = !Variables+$0005
!SignalSP4FirstHalfBottomRightQuarter = !Variables+$0006
!SignalSP4FirstHalfTopLeftQuarter = !Variables+$0007
!SignalSP4FirstHalfTopRightQuarter = !Variables+$0008
!SignalSP3SecondHalfBottomLeftQuarter = !Variables+$0009
!SignalSP3SecondHalfBottomRightQuarter = !Variables+$000A
!SignalSP3SecondHalfTopLeftQuarter = !Variables+$000B
!SignalSP3SecondHalfTopRightQuarter = !Variables+$000C
!SlotsUsedEven = !Variables+$000D
!SlotsUsedOdd = !Variables+$000E
!MaxSlots = !Variables+$000F
!NumberOfBlocks = !Variables+$0010
!VRAMDispNormalSprite = !Variables+$0011
!VRAMDispExtendedSprite = !Variables+!MaxSprites+$0011
!VRAMDispClusterSprite = !Variables+!MaxSprites+$001B
!VRAMDispOWSprite = !Variables+!MaxSprites+$002F
!TransferFrameNormalSprite = !Variables+!MaxSprites+$003F
!TransferFrameExtendedSprite = !Variables+!MaxSprites+!MaxSprites+$003F
!TransferFrameClusterSprite = !Variables+!MaxSprites+!MaxSprites+$0049
!TransferFrameOWSprite = !Variables+!MaxSprites+!MaxSprites+$005D
!SlotsUsedBySprite = !Variables+!MaxSprites+!MaxSprites+$006D
!FPSSprite = !Variables+!MaxSprites+!MaxSprites+$009D
!SlotSpriteType = !Variables+!MaxSprites+!MaxSprites+$00CD
!SlotSpriteID = !Variables+!MaxSprites+!MaxSprites+$00FD
!SlotSpriteNumber = !Variables+!MaxSprites+!MaxSprites+$012D
!DMAMapResource = !Variables+!MaxSprites+!MaxSprites+$015D
!DMAMapBNK = !Variables+!MaxSprites+!MaxSprites+$021D
!DMAMapLenght = !Variables+!MaxSprites+!MaxSprites+$027D
!DMAMapNext = !Variables+!MaxSprites+!MaxSprites+$033D
!FirstSlot = !Variables+!MaxSprites+!MaxSprites+$039D
!LastSlot = !Variables+!MaxSprites+!MaxSprites+$039E
!Mode50More = !Variables+!MaxSprites+!MaxSprites+$039F

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

!DynamicRoutine2Lines = read3(!Routines+0)
!DynamicRoutine4Lines = read3(!Routines+3)
!DynamicRoutine6Lines = read3(!Routines+6)
!Reserve16x16NormalSpriteOf30FPS = read3(!Routines+9)
!Reserve16x16NormalSpriteOf60FPS = read3(!Routines+12)
!Reserve32x16NormalSpriteOf30FPS = read3(!Routines+15)
!Reserve32x16NormalSpriteOf60FPS = read3(!Routines+18)
!Reserve32x32NormalSpriteOf30FPS = read3(!Routines+21)
!Reserve32x32NormalSpriteOf60FPS = read3(!Routines+24)
!Reserve48x48NormalSpriteOf30FPS = read3(!Routines+27)
!Reserve48x48NormalSpriteOf60FPS = read3(!Routines+30)
!Reserve64x64NormalSpriteOf30FPS = read3(!Routines+33)
!Reserve64x64NormalSpriteOf60FPS = read3(!Routines+36)
!Reserve16x16ClusterSpriteOf30FPS = read3(!Routines+39)
!Reserve16x16ClusterSpriteOf60FPS = read3(!Routines+42)
!Reserve32x16ClusterSpriteOf30FPS = read3(!Routines+45)
!Reserve32x16ClusterSpriteOf60FPS = read3(!Routines+48)
!Reserve32x32ClusterSpriteOf30FPS = read3(!Routines+51)
!Reserve32x32ClusterSpriteOf60FPS = read3(!Routines+54)
!Reserve48x48ClusterSpriteOf30FPS = read3(!Routines+57)
!Reserve48x48ClusterSpriteOf60FPS = read3(!Routines+60)
!Reserve64x64ClusterSpriteOf30FPS = read3(!Routines+63)
!Reserve64x64ClusterSpriteOf60FPS = read3(!Routines+66)
!SendSignal16x16Normal = read3(!Routines+69)
!SendSignal32x16Normal = read3(!Routines+72)
!SendSignal32x32Normal = read3(!Routines+75)
!SendSignal48x48Normal = read3(!Routines+78)
!SendSignal64x64Normal = read3(!Routines+81)
!SendSignal16x16Cluster = read3(!Routines+84)
!SendSignal32x16Cluster = read3(!Routines+87)
!SendSignal32x32Cluster = read3(!Routines+90)
!SendSignal48x48Cluster = read3(!Routines+93)
!SendSignal64x64Cluster = read3(!Routines+96)
!SendSignal16x16Extended = read3(!Routines+99)
!SendSignal32x16Extended = read3(!Routines+102)
!SendSignal32x32Extended = read3(!Routines+105)
!SendSignal48x48Extended = read3(!Routines+108)
!SendSignal64x64Extended = read3(!Routines+111)
!SendSignal16x16OW = read3(!Routines+114)
!SendSignal32x16OW = read3(!Routines+117)
!SendSignal32x32OW = read3(!Routines+120)
!SendSignal48x48OW = read3(!Routines+123)
!SendSignal64x64OW = read3(!Routines+126)

