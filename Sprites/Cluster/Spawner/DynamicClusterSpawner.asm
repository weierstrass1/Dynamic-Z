!ResourceIndex = $02
!FreeRams = $7FB880

if !sa1
	!FreeRams = $418B80
endif

;Constant
!MinRespawnTime = $10
!MaxRespawnTime = $40
!MaxSpawnTime = $80
!MaxSpawn = $13

;######################################
;############## Defines ###############
;######################################

!Started = !ClusterMiscTable1
!FrameIndex = !ClusterMiscTable2
!AnimationTimer = !ClusterMiscTable3
!AnimationIndex = !ClusterMiscTable4
!AnimationFrameIndex = !ClusterMiscTable5
!LocalFlip = !ClusterMiscTable6
!GlobalFlip = !ClusterMiscTable7
!LastFrameIndex = !ClusterMiscTable9
!Properties = DZ_FreeRams
!CurrentRespawnTime = !Properties+$14
!CurrentSpawnTime = !CurrentRespawnTime+$14
!SpawnCounter = !CurrentSpawnTime+$14
!YTimer = !SpawnCounter+$14
!YAdder = !YTimer+$14
!Properties2 = !YAdder+$14
!Palette = !Properties2+$14

print "INIT ",pc
RTL
print "MAIN ",pc

    LDA !SpriteXLow,x
    STA !Scratch0
    LDA !SpriteXHigh,x
    STA !Scratch1
    LDA !SpriteYLow,x
    STA !Scratch2
    LDA !SpriteYHigh,x
    STA !Scratch3
    STZ !Scratch4
    STZ !Scratch5

    LDA !ExtraByte1,x
    %SpawnCluster()
    BCC +
    
    STZ !SpriteStatus,x

    PHX
    LDA !ExtraByte3,x
    STA !Scratch0
    LDA !ExtraByte2,x
    TYX
    STA.l !Properties,x

    LDA !Scratch0
    STA.l !Properties2,x
    
    LDA #$00
    STA !Started,x
	JSL $01ACF9|!rom
	LDA $148D|!addr
    EOR !TrueFrameCounter
    AND #$01
    STA !GlobalFlip,x
    PLX
+
RTL