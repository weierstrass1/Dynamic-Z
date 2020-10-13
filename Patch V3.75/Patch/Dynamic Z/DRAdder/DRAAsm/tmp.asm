!NumberOfSprites = 7

if read1($00FFD5) == $23
    sa1rom
endif

!__main_clean = read3((read1($0082DA+4)<<16+read2($00823D+4))+$0C)

if !__main_clean != $000000 
    print "dl $FFFFFF detectado: $", hex(read3(!__main_clean-3))
    !i = 0
    while !i < !NumberOfSprites
	!__current_clean = read3(!__main_clean+(!i*3))
        autoclean !__current_clean
        !i #= !i+1
    endif

    autoclean !__main_clean

endif

org (read1($0082DA+4)<<16+read2($00823D+4))+$0C
    dl SpriteNumberToGraphics

freedata cleaned

print "dl $FFFFFF insertado: $", pc
    dl $FFFFFF
SpriteNumberToGraphics:
    !i = 0
    while !i < !NumberOfSprites
        dl Resource!i
        !i #= !i+1
    endif

macro insert_resource(file, label)
pushpc
freedata cleaned
<label>
    incbin "<file>"
pullpc
print "Resource <file>", ": Inserted At $", hex(<label>)
endmacro


freedata cleaned
    prot Resource0_RSRC0

Resource0:

    dl Resource0_RSRC0

    %insert_resource("../Dynamic Resources/Klaptrap.bin", .RSRC0)


freedata cleaned
    prot Resource1_RSRC0

Resource1:

    dl Resource1_RSRC0

    %insert_resource("../Dynamic Resources/Klump.bin", .RSRC0)


freedata cleaned
    prot Resource2_RSRC0

Resource2:

    dl Resource2_RSRC0

    %insert_resource("../Dynamic Resources/Zinger.bin", .RSRC0)


freedata cleaned
    prot Resource3_RSRC0,Resource3_RSRC1,Resource3_RSRC2,Resource3_RSRC3,Resource3_RSRC4,Resource3_RSRC5

Resource3:

    dl Resource3_RSRC0
    dl Resource3_RSRC1
    dl Resource3_RSRC2
    dl Resource3_RSRC3
    dl Resource3_RSRC4
    dl Resource3_RSRC5

    %insert_resource("../Dynamic Resources/Met.bin", .RSRC0)
    %insert_resource("../Dynamic Resources/MetPal1.bin", .RSRC1)
    %insert_resource("../Dynamic Resources/MetPal2.bin", .RSRC2)
    %insert_resource("../Dynamic Resources/MetPal3.bin", .RSRC3)
    %insert_resource("../Dynamic Resources/MetPal4.bin", .RSRC4)
    %insert_resource("../Dynamic Resources/MetDamagePal.bin", .RSRC5)


freedata cleaned
    prot Resource4_RSRC0

Resource4:

    dl Resource4_RSRC0

    %insert_resource("../Dynamic Resources/Butterfly.bin", .RSRC0)


freedata cleaned
    prot Resource5_RSRC0

Resource5:

    dl Resource5_RSRC0

    %insert_resource("../Dynamic Resources/SmallFish.bin", .RSRC0)


freedata cleaned
    prot Resource6_RSRC0,Resource6_RSRC1

Resource6:

    dl Resource6_RSRC0
    dl Resource6_RSRC1

    %insert_resource("../Dynamic Resources/MMXExplosion.bin", .RSRC0)
    %insert_resource("../Dynamic Resources/MMXExplosionPal.bin", .RSRC1)

!i = 0

while !i < !NumberOfSprites
    print "Resource ",hex(!i), ": Inserted At $", hex(Resource!i)
    !i #= !i+1
endif