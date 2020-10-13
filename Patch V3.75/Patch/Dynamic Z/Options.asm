!True = 1
!False = 0

!GFXFeatures = !{0}
!DynamicSpriteSupport = !{1}
!SharedDynamicSpriteSupport = !{2}
!SemiDynamicSpriteSupport = !{3}
!TwoPhaseDynamicSpriteSupport = !{4}
!BlockChange = !{5}
!PlayerGFX = !{6}
!Mode50 = !{7}
!PaletteFeatures = !{8}
!HSVSystem = !{9}
!RGBSystem = !{10}
!PlayerPalette = !{11}
!OAMSystem = !{12}
!Widescreen = !{13}


if !GFXFeatures == !False
!DynamicSpriteSupport = !False
!SharedDynamicSpriteSupport = !False
!SemiDynamicSpriteSupport = !False
!TwoPhaseDynamicSpriteSupport = !False
!PlayerGFX  = !False
endif

if !DynamicSpriteSupport == !False
!SharedDynamicSpriteSupport = !False
endif

if !PaletteFeatures == !False
!HSVSystem = !False
!RGBSystem = !False
!PlayerPalette = !False
endif