;-----------------Set As RGB-------------------------------
macro SetBaseAsRGB(Length)
    %SetBaseAsRGBWithWithDestSrcAndOffset("<Length>", DZ_PPUMirrors_CGRAM_BasePalette, "DZ_PPUMirrors_CGRAM_BasePalette+256", $0000)
endmacro

macro SetBaseAsRGBWithOffset(Length, Offset)
    %SetBaseAsRGBWithWithDestSrcAndOffset("<Length>", DZ_PPUMirrors_CGRAM_BasePalette, "DZ_PPUMirrors_CGRAM_BasePalette+256", "<Offset>")
endmacro

macro SetBaseAsRGBWithDestAndSrc(Length, Destination, Source)
    %SetBaseAsRGBWithWithDestSrcAndOffset("<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro SetBaseAsRGBWithWithDestSrcAndOffset(Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*3
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*2
    PHA
    SEP #$20
    %CallFunctionLong(!SetBaseAsRGB, $06)
    PLB
endmacro
;-----------------Set As HSV-------------------------------
macro SetBaseAsHSV(Length)
    %SetBaseAsHSVWithWithDestSrcAndOffset("<Length>", DZ_PPUMirrors_CGRAM_BasePalette, "DZ_PPUMirrors_CGRAM_BasePalette+256", $0000)
endmacro

macro SetBaseAsHSVWithOffset(Length, Offset)
    %SetBaseAsHSVWithWithDestSrcAndOffset("<Length>", DZ_PPUMirrors_CGRAM_BasePalette, "DZ_PPUMirrors_CGRAM_BasePalette+256", "<Offset>")
endmacro

macro SetBaseAsHSVWithDestAndSrc(Length, Destination, Source)
    %SetBaseAsHSVWithWithDestSrcAndOffset("<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro SetBaseAsHSVWithWithDestSrcAndOffset(Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*3
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*2
    PHA
    SEP #$20
    %CallFunctionLong(!SetBaseAsHSV, $06)
    PLB
endmacro

macro SetBaseAsHSVNoConstant(Length)
    %SetBaseAsHSVWithWithDestSrcAndOffsetNoConstant("<Length>", DZ_PPUMirrors_CGRAM_BasePalette, "#DZ_PPUMirrors_CGRAM_BasePalette+256", $0000)
endmacro

macro SetBaseAsHSVWithOffsetNoConstant(Length, Offset)
    %SetBaseAsHSVWithWithDestSrcAndOffsetNoConstant("<Length>", DZ_PPUMirrors_CGRAM_BasePalette, "#DZ_PPUMirrors_CGRAM_BasePalette+256", "<Offset>")
endmacro

macro SetBaseAsHSVWithDestAndSrcNoConstant(Length, Destination, Source)
    %SetBaseAsHSVWithWithDestSrcAndOffsetNoConstant("<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro SetBaseAsHSVWithWithDestSrcAndOffsetNoConstant(Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Source>
    PHA
    SEP #$20
    %CallFunctionLong(!SetBaseAsHSV, $06)
    PLB
endmacro

;--------------------------------HUE------------------------------------------

macro ChangePaletteHue(NewValue, Length)
    %ChangePaletteHueWithDestSrcAndOffset("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteHueWithOffset(NewValue, Length, Offset)
    %ChangePaletteHueWithDestSrcAndOffset("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteHueWithDestAndSrc(NewValue, Length, Destination, Source)
    %ChangePaletteHueWithDestSrcAndOffset("<NewValue>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteHueWithDestSrcAndOffset(NewValue, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteHue, $07)
    PLB
endmacro

macro ChangePaletteHueNoConstant(NewValue, Length)
    %ChangePaletteHueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteHueWithOffsetNoConstant(NewValue, Length, Offset)
    %ChangePaletteHueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteHueWithDestAndSrcNoConstant(NewValue, Length, Destination, Source)
    %ChangePaletteHueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteHueWithDestSrcAndOffsetNoConstant(NewValue, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteHue, $07)
    PLB
endmacro

;--------------------------------Saturation------------------------------------------

macro ChangePaletteSaturation(NewValue, Length)
    %ChangePaletteSaturationWithDestSrcAndOffset("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteSaturationWithOffset(NewValue, Length, Offset)
    %ChangePaletteSaturationWithDestSrcAndOffset("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteSaturationWithDestAndSrc(NewValue, Length, Destination, Source)
    %ChangePaletteSaturationWithDestSrcAndOffset("<NewValue>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteSaturationWithDestSrcAndOffset(NewValue, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteSaturation, $07)
    PLB
endmacro

macro ChangePaletteSaturationNoConstant(NewValue, Length)
    %ChangePaletteSaturationWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteSaturationWithOffsetNoConstant(NewValue, Length, Offset)
    %ChangePaletteSaturationWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteSaturationWithDestAndSrcNoConstant(NewValue, Length, Destination, Source)
    %ChangePaletteSaturationWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteSaturationWithDestSrcAndOffsetNoConstant(NewValue, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteSaturation, $07)
    PLB
endmacro

;--------------------------------Value------------------------------------------

macro ChangePaletteValue(NewValue, Length)
    %ChangePaletteValueWithDestSrcAndOffset("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteValueWithOffset(NewValue, Length, Offset)
    %ChangePaletteValueWithDestSrcAndOffset("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteValueWithDestAndSrc(NewValue, Length, Destination, Source)
    %ChangePaletteValueWithDestSrcAndOffset("<NewValue>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteValueWithDestSrcAndOffset(NewValue, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteValue, $07)
    PLB
endmacro

macro ChangePaletteValueNoConstant(NewValue, Length)
    %ChangePaletteValueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteValueWithOffsetNoConstant(NewValue, Length, Offset)
    %ChangePaletteValueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteValueWithDestAndSrcNoConstant(NewValue, Length, Destination, Source)
    %ChangePaletteValueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteValueWithDestSrcAndOffsetNoConstant(NewValue, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteValue, $07)
    PLB
endmacro

;--------------------------------ChangePaletteHueAndSaturation------------------------------------------

macro ChangePaletteHueAndSaturation(NewValue1, NewValue2, Length)
    %ChangePaletteHueAndSaturationWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteHueAndSaturationWithOffset(NewValue1, NewValue2, Length, Offset)
    %ChangePaletteHueAndSaturationWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteHueAndSaturationWithDestAndSrc(NewValue1, NewValue2, Length, Destination, Source)
    %ChangePaletteHueAndSaturationWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteHueAndSaturationWithDestSrcAndOffset(NewValue1, NewValue2, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteHueAndSaturation, $08)
    PLB
endmacro

macro ChangePaletteHueAndSaturationNoConstant(NewValue1, NewValue2, Length)
    %ChangePaletteHueAndSaturationWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteHueAndSaturationWithOffsetNoConstant(NewValue1, NewValue2, Length, Offset)
    %ChangePaletteHueAndSaturationWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteHueAndSaturationWithDestAndSrcNoConstant(NewValue1, NewValue2, Length, Destination, Source)
    %ChangePaletteHueAndSaturationWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteHueAndSaturationWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteHueAndSaturation, $08)
    PLB
endmacro

;--------------------------------ChangePaletteHueAndValue------------------------------------------

macro ChangePaletteHueAndValue(NewValue1, NewValue2, Length)
    %ChangePaletteHueAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteHueAndValueWithOffset(NewValue1, NewValue2, Length, Offset)
    %ChangePaletteHueAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteHueAndValueWithDestAndSrc(NewValue1, NewValue2, Length, Destination, Source)
    %ChangePaletteHueAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteHueAndValueWithDestSrcAndOffset(NewValue1, NewValue2, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteHueAndValue, $08)
    PLB
endmacro

macro ChangePaletteHueAndValueNoConstant(NewValue1, NewValue2, Length)
    %ChangePaletteHueAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteHueAndValueWithOffsetNoConstant(NewValue1, NewValue2, Length, Offset)
    %ChangePaletteHueAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteHueAndValueWithDestAndSrcNoConstant(NewValue1, NewValue2, Length, Destination, Source)
    %ChangePaletteHueAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteHueAndValueWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteHueAndValue, $08)
    PLB
endmacro

;--------------------------------ChangePaletteSaturationAndValue------------------------------------------

macro ChangePaletteSaturationAndValue(NewValue1, NewValue2, Length)
    %ChangePaletteSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteSaturationAndValueWithOffset(NewValue1, NewValue2, Length, Offset)
    %ChangePaletteSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteSaturationAndValueWithDestAndSrc(NewValue1, NewValue2, Length, Destination, Source)
    %ChangePaletteSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteSaturationAndValueWithDestSrcAndOffset(NewValue1, NewValue2, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteSaturationAndValue, $08)
    PLB
endmacro

macro ChangePaletteSaturationAndValueNoConstant(NewValue1, NewValue2, Length)
    %ChangePaletteSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro ChangePaletteSaturationAndValueWithOffsetNoConstant(NewValue1, NewValue2, Length, Offset)
    %ChangePaletteSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro ChangePaletteSaturationAndValueWithDestAndSrcNoConstant(NewValue1, NewValue2, Length, Destination, Source)
    %ChangePaletteSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro ChangePaletteSaturationAndValueWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!ChangePaletteSaturationAndValue, $08)
    PLB
endmacro

;--------------------------------Mix Hue------------------------------------------
macro MixPaletteHue(NewValue, Ratio, Length)
    %MixPaletteHueWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueWithOffset(NewValue, Ratio, Length, Offset)
    %MixPaletteHueWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueWithDestAndSrc(NewValue, Ratio, Length, Destination, Source)
    %MixPaletteHueWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueWithDestSrcAndOffset(NewValue, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHue, $08)
    PLB
endmacro

macro MixPaletteHueNoConstant(NewValue, Ratio, Length)
    %MixPaletteHueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueWithOffsetNoConstant(NewValue, Ratio, Length, Offset)
    %MixPaletteHueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueWithDestAndSrcNoConstant(NewValue, Ratio, Length, Destination, Source)
    %MixPaletteHueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueWithDestSrcAndOffsetNoConstant(NewValue, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHue, $08)
    PLB
endmacro
;--------------------------------Mix Saturation------------------------------------------
macro MixPaletteSaturation(NewValue, Ratio, Length)
    %MixPaletteSaturationWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteSaturationWithOffset(NewValue, Ratio, Length, Offset)
    %MixPaletteSaturationWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteSaturationWithDestAndSrc(NewValue, Ratio, Length, Destination, Source)
    %MixPaletteSaturationWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteSaturationWithDestSrcAndOffset(NewValue, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteSaturation, $08)
    PLB
endmacro

macro MixPaletteSaturationNoConstant(NewValue, Ratio, Length)
    %MixPaletteSaturationWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteSaturationWithOffsetNoConstant(NewValue, Ratio, Length, Offset)
    %MixPaletteSaturationWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteSaturationWithDestAndSrcNoConstant(NewValue, Ratio, Length, Destination, Source)
    %MixPaletteSaturationWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteSaturationWithDestSrcAndOffsetNoConstant(NewValue, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteSaturation, $08)
    PLB
endmacro
;--------------------------------Mix Value------------------------------------------
macro MixPaletteValue(NewValue, Ratio, Length)
    %MixPaletteValueWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteValueWithOffset(NewValue, Ratio, Length, Offset)
    %MixPaletteValueWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteValueWithDestAndSrc(NewValue, Ratio, Length, Destination, Source)
    %MixPaletteValueWithDestSrcAndOffset("<NewValue>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteValueWithDestSrcAndOffset(NewValue, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteValue, $08)
    PLB
endmacro

macro MixPaletteValueNoConstant(NewValue, Ratio, Length)
    %MixPaletteValueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteValueWithOffsetNoConstant(NewValue, Ratio, Length, Offset)
    %MixPaletteValueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteValueWithDestAndSrcNoConstant(NewValue, Ratio, Length, Destination, Source)
    %MixPaletteValueWithDestSrcAndOffsetNoConstant("<NewValue>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteValueWithDestSrcAndOffsetNoConstant(NewValue, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteValue, $08)
    PLB
endmacro
;--------------------------------Mix Hue and Saturation------------------------------------------
macro MixPaletteHueAndSaturation(NewValue1, NewValue2, Ratio, Length)
    %MixPaletteHueAndSaturationWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueAndSaturationWithOffset(NewValue1, NewValue2, Ratio, Length, Offset)
    %MixPaletteHueAndSaturationWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueAndSaturationWithDestAndSrc(NewValue1, NewValue2, Ratio, Length, Destination, Source)
    %MixPaletteHueAndSaturationWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueAndSaturationWithDestSrcAndOffset(NewValue1, NewValue2, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHueAndSaturation, $09)
    PLB
endmacro

macro MixPaletteHueAndSaturationNoConstant(NewValue1, NewValue2, Ratio, Length)
    %MixPaletteHueAndSaturationWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueAndSaturationWithOffsetNoConstant(NewValue1, NewValue2, Ratio, Length, Offset)
    %MixPaletteHueAndSaturationWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueAndSaturationWithDestAndSrcNoConstant(NewValue1, NewValue2, Ratio, Length, Destination, Source)
    %MixPaletteHueAndSaturationWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueAndSaturationWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHueAndSaturation, $09)
    PLB
endmacro
;--------------------------------Mix Hue and Value------------------------------------------
macro MixPaletteHueAndValue(NewValue1, NewValue2, Ratio, Length)
    %MixPaletteHueAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueAndValueWithOffset(NewValue1, NewValue2, Ratio, Length, Offset)
    %MixPaletteHueAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueAndValueWithDestAndSrc(NewValue1, NewValue2, Ratio, Length, Destination, Source)
    %MixPaletteHueAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueAndValueWithDestSrcAndOffset(NewValue1, NewValue2, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHueAndValue, $09)
    PLB
endmacro

macro MixPaletteHueAndValueNoConstant(NewValue1, NewValue2, Ratio, Length)
    %MixPaletteHueAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueAndValueWithOffsetNoConstant(NewValue1, NewValue2, Ratio, Length, Offset)
    %MixPaletteHueAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueAndValueWithDestAndSrcNoConstant(NewValue1, NewValue2, Ratio, Length, Destination, Source)
    %MixPaletteHueAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueAndValueWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHueAndValue, $09)
    PLB
endmacro
;--------------------------------Mix Hue and Saturation------------------------------------------
macro MixPaletteSaturationAndValue(NewValue1, NewValue2, Ratio, Length)
    %MixPaletteSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteSaturationAndValueWithOffset(NewValue1, NewValue2, Ratio, Length, Offset)
    %MixPaletteSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteSaturationAndValueWithDestAndSrc(NewValue1, NewValue2, Ratio, Length, Destination, Source)
    %MixPaletteSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteSaturationAndValueWithDestSrcAndOffset(NewValue1, NewValue2, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteSaturationAndValue, $09)
    PLB
endmacro

macro MixPaletteSaturationAndValueNoConstant(NewValue1, NewValue2, Ratio, Length)
    %MixPaletteSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteSaturationAndValueWithOffsetNoConstant(NewValue1, NewValue2, Ratio, Length, Offset)
    %MixPaletteSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteSaturationAndValueWithDestAndSrcNoConstant(NewValue1, NewValue2, Ratio, Length, Destination, Source)
    %MixPaletteSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteSaturationAndValueWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteSaturationAndValue, $09)
    PLB
endmacro
;--------------------------------Mix Hue, Saturation and Value------------------------------------------
macro MixPaletteHueSaturationAndValue(NewValue1, NewValue2, NewValue3, Ratio, Length)
    %MixPaletteHueSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueSaturationAndValueWithOffset(NewValue1, NewValue2, NewValue3, Ratio, Length, Offset)
    %MixPaletteHueSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueSaturationAndValueWithDestAndSrc(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source)
    %MixPaletteHueSaturationAndValueWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueSaturationAndValueWithDestSrcAndOffset(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue3>
    PHA
    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHueSaturationAndValue, $0A)
    PLB
endmacro

macro MixPaletteHueSaturationAndValueNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length)
    %MixPaletteHueSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixPaletteHueSaturationAndValueWithOffsetNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length, Offset)
    %MixPaletteHueSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixPaletteHueSaturationAndValueWithDestAndSrcNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source)
    %MixPaletteHueSaturationAndValueWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixPaletteHueSaturationAndValueWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue3>
    PHA
    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixPaletteHueSaturationAndValue, $0A)
    PLB
endmacro

;--------------------------------Mix with Color------------------------------------------
macro MixWithColor(NewValue1, NewValue2, NewValue3, Ratio, Length)
    %MixWithColorWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixWithColorWithOffset(NewValue1, NewValue2, NewValue3, Ratio, Length, Offset)
    %MixWithColorWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixWithColorWithDestAndSrc(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source)
    %MixWithColorWithDestSrcAndOffset("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixWithColorWithDestSrcAndOffset(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue3>
    PHA
    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA.w #<Destination>
    CLC
    ADC.w #<Offset>*2
    PHA
    LDA.w #<Source>
    CLC
    ADC.w #<Offset>*3
    PHA
    SEP #$20
    %CallFunctionLong(!MixWithColor, $0A)
    PLB
endmacro

macro MixWithColorNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length)
    %MixWithColorWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, $0000)
endmacro

macro MixWithColorWithOffsetNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length, Offset)
    %MixWithColorWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", DZ_PPUMirrors_CGRAM_PaletteWriteMirror, DZ_PPUMirrors_CGRAM_BasePalette, "<Offset>")
endmacro

macro MixWithColorWithDestAndSrcNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source)
    %MixWithColorWithDestSrcAndOffsetNoConstant("<NewValue1>", "<NewValue2>", "<NewValue3>", "<Ratio>", "<Length>", "<Destination>", "<Source>", $0000)
endmacro

macro MixWithColorWithDestSrcAndOffsetNoConstant(NewValue1, NewValue2, NewValue3, Ratio, Length, Destination, Source, Offset)
    PHB

    LDA.b #<Destination>>>16
    PHA
    PLB

    LDA <NewValue3>
    PHA
    LDA <NewValue2>
    PHA
    LDA <NewValue1>
    PHA
    LDA <Ratio>
    PHA

    REP #$20
    LDA.w #<Length>
    PHA
    LDA <Offset>
    CLC
    ASL
    CLC
    ADC.w #<Destination>
    PHA
    LDA <Offset>
    STA $0E
    CLC
    ASL
    CLC
    ADC $0E
    CLC
    ADC.w #<Source>
    PHA
    SEP #$20
    %CallFunctionLong(!MixWithColor, $0A)
    PLB
endmacro