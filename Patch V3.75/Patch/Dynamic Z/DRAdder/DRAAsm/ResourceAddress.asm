!NumberOfSprites = {3}

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