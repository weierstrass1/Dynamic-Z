!LastOAM200Slot = $0DDB|!addr

!YoshiTongueTile1 = $0C
!YoshiTongueTile2 = $10
!YoshiTongueTile3 = $14
!YoshiTongueTile4 = $18
!YoshiTongueTile5 = $1C
!BounceSpritesTile = $1C
!SmokeTile1 = $20
!SmokeTile2 = $24
!SmokeTile3 = $28
!SmokeTile4 = $2C
!CoinSpriteTile1 = $30
!CoinSpriteTile2 = $34
!CoinSpriteTile3 = $38
!CoinSpriteTile4 = $3C
!CoinSpriteTile5 = $40
!CoinSpriteTile6 = $44
!CoinSpriteTile7 = $48
!CoinSpriteTile8 = $4C
!MinorExtendedTile1 = $50
!MinorExtendedTile2 = $54
!MinorExtendedTile3 = $58
!MinorExtendedTile4 = $5C
!MinorExtendedTile5 = $60
!MinorExtendedTile6 = $64
!MinorExtendedTile7 = $68
!MinorExtendedTile8 = $6C
!MinorExtendedTile9 = $70
!MinorExtendedTileA = $74
!MinorExtendedTileB = $78
!MinorExtendedTileC = $7C
!ScoreSpriteTile1 = $B0
!ScoreSpriteTile2 = $B4
!ScoreSpriteTile3 = $B8
!ScoreSpriteTile4 = $BC
!ScoreSpriteTile5 = $C0
!ScoreSpriteTile6 = $C4
!ScoreSpriteTile7 = $C8
!ScoreSpriteTile8 = $CC
!ScoreSpriteTile9 = $D0
!ScoreSpriteTileA = $D4
!ScoreSpriteTileB = $D8
!ScoreSpriteTileC = $DC
!ReserveItemTile = $E0
!FireballTile1 = $F8
!FireballTile2 = $FC
!WhiteStarTile1 = $F0
!WhiteStarTile2 = $F4
!WhiteStarTile3 = $F8
!WhiteStarTile4 = $FC

macro checkTile(tile)
	if !YoshiTongueTile1 == <tile> || !YoshiTongueTile2 == <tile> || !YoshiTongueTile3 == <tile> || !YoshiTongueTile4 == <tile> || !YoshiTongueTile5 == <tile> || !BounceSpritesTile == <tile> || !SmokeTile1 == <tile> ||  !SmokeTile2 == <tile> || !SmokeTile3 == <tile> ||  !SmokeTile4 == <tile> || !CoinSpriteTile1 == <tile> || !CoinSpriteTile2 == <tile> || !CoinSpriteTile3 == <tile> || !CoinSpriteTile4 == <tile> || !CoinSpriteTile5 == <tile> || !CoinSpriteTile6 == <tile> || !CoinSpriteTile7 == <tile> || !CoinSpriteTile8 == <tile> || !MinorExtendedTile1 == <tile> || !MinorExtendedTile2 == <tile> || !MinorExtendedTile3 == <tile> || !MinorExtendedTile4 == <tile> || !MinorExtendedTile5 == <tile> || !MinorExtendedTile6 == <tile> || !MinorExtendedTile7 == <tile> || !MinorExtendedTile8 == <tile> || !MinorExtendedTile9 == <tile> || !MinorExtendedTileA == <tile> || !MinorExtendedTileB == <tile> || !MinorExtendedTileC == <tile> || !ScoreSpriteTile1 == <tile> || !ScoreSpriteTile2 == <tile> || !ScoreSpriteTile3 == <tile> || !ScoreSpriteTile4 == <tile> || !ScoreSpriteTile5 == <tile> || !ScoreSpriteTile6 == <tile> || !ScoreSpriteTile7 == <tile> || !ScoreSpriteTile8 == <tile> || !ScoreSpriteTile9 == <tile> || !ScoreSpriteTileA == <tile> || !ScoreSpriteTileB == <tile> || !ScoreSpriteTileC == <tile> || !ReserveItemTile == <tile> || !FireballTile1 == <tile> || !FireballTile2 == <tile> || !WhiteStarTile1 == <tile> || !WhiteStarTile2 == <tile> || !WhiteStarTile3 == <tile> || !WhiteStarTile4 == <tile>
		db $01
	else
		db $00
	endif
endmacro

macro checkRow(row)
	%checkTile($<row>0)
	db $00,$00,$00
	%checkTile($<row>4)
	db $00,$00,$00
	%checkTile($<row>8)
	db $00,$00,$00
	%checkTile($<row>C)
	db $00,$00,$00
endmacro

!Tile = !ExtendedMiscTable1
!PalAndPage = DZ_FreeRams+$0200
!DissappearTime = !ExtendedMiscTable2

print "INIT ",pc
print "MAIN ",pc
Main:
    JSR GraphicRoutine

	LDA !LockAnimationFlag				    
	BNE Return

    JSR Movement
    JSR Interaction
    JSR CheckOffScreen

    LDA !DissappearTime,x
    BNE Return

    STZ !ExtendedNumber,x
    LDA #$1B
    STA $02
    LDA #$01
    %SpawnSmoke()
    BCS Return

    LDA !ExtendedYLow,x     ; \
    SEC
    SBC #$04
    STA $17C4|!Base2,y      ; /

    LDA !ExtendedXLow,x              ; \
    SEC
    SBC #$04
    STA $17C8|!Base2,y      ; /

Return:
RTL

Movement: 

    LDA !PalAndPage,x
    AND #$10
    BEQ ++

    LDA !ExtendedXHigh,x
    XBA
    LDA !ExtendedXLow,x
    REP #$20
    CLC
    ADC #$FFF8
    CMP !PlayerX
    SEP #$20
    BCC +

    LDA !ExtendedXSpeed,x
    DEC A
    STA !ExtendedXSpeed,x
    BPL ++
    CMP #$F0
    BCS ++

    LDA #$F0
    STA !ExtendedXSpeed,x
    BRA ++
+
    LDA !ExtendedXSpeed,x
    INC A
    STA !ExtendedXSpeed,x
    BMI ++
    CMP #$10
    BCC ++

    LDA #$10
    STA !ExtendedXSpeed,x
    BRA ++
++
    LDA !PalAndPage,x
    AND #$20
    BEQ ++

    LDA !ExtendedYHigh,x
    XBA
    LDA !ExtendedYLow,x
    REP #$20
    CLC
    ADC #$FFF4
    CMP !PlayerY
    SEP #$20
    BCC +

    LDA !ExtendedYSpeed,x
    DEC A
    STA !ExtendedYSpeed,x
    BPL ++
    CMP #$F0
    BCS ++

    LDA #$F0
    STA !ExtendedYSpeed,x
    BRA ++
+
    LDA !ExtendedYSpeed,x
    INC A
    STA !ExtendedYSpeed,x
    BMI ++
    CMP #$10
    BCC ++

    LDA #$10
    STA !ExtendedYSpeed,x
    BRA ++
++
    %SpeedNoGrav()
RTS

CheckOffScreen:
    LDA !ExtendedXHigh,x
    XBA
    LDA !ExtendedXLow,x
    REP #$20
    CLC
    ADC #$0008
    BMI .kill
    CMP !Layer1X
    BCC .kill
    SEC
    SBC #$0108
    BMI +
    CMP !Layer1X
    BCS .kill
+
    SEP #$20

    LDA !ExtendedYHigh,x
    XBA
    LDA !ExtendedYLow,x
    REP #$20
    CLC
    ADC #$0008
    BMI .kill
    CMP !Layer1Y
    BCC .kill
    SEC
    SBC #$00E8
    BMI +
    CMP !Layer1Y
    BCS .kill
+
    SEP #$20
RTS
.kill
    SEP #$20
    STZ !ExtendedNumber,x
RTS
;This subroutine checks if the two hitboxes of A and B to see if they are in contact.
;Carry is set if true, else false.
;Syntax:
; $00 = X low byte position/displacement B
; $01 = Y low byte position/displacement B
; $02 = Hitbox width (8-bit) B
; $03 = Hitbox height (8-bit) B
; $04 = X low byte position/displacement A
; $05 = Y low byte position/displacement A
; $06 = Hitbox width (8-bit) A
; $07 = Hitbox height (8-bit) A
; $08 = X high byte position/displacement B
; $09 = Y high byte position/displacement B
; $0A = X high byte position/displacement A
; $0B = Y high byte position/displacement A
;Destroyed values:
; $0C = used as part of the high byte to check if they are too far
; $0F = used as the furthest distance to check if the hitboxes are at least edge
;       to edge on contact.
Interaction:

    LDA !ExtendedXHigh,x
    STA !ScratchA
    
    LDA !ExtendedXLow,x
    CLC
    ADC #$02
    STA !Scratch4
    BCC +
    INC !ScratchA
+

    LDA !ExtendedYHigh,x
    STA !ScratchB

    LDA !ExtendedYLow,x
    CLC
    ADC #$02
    STA !Scratch5
    BCC +
    INC !ScratchB
+

    LDA #$04
    STA !Scratch6
    STA !Scratch7

    JSL $03B664|!rom
    JSL $03B72B|!rom
    BCC +

    STZ !ExtendedNumber,x
    JSR Hurt

    LDA #$1B
    STA $02
    LDA #$01
    %SpawnSmoke()
    BCS +

    LDA !ExtendedYLow,x     ; \
    SEC
    SBC #$04
    STA $17C4|!Base2,y      ; /

    LDA !ExtendedXLow,x              ; \
    SEC
    SBC #$04
    STA $17C8|!Base2,y      ; /

+
RTS

Hurt:
    PHX
 
    LDA $187A|!addr     ;if the player is not riding yoshi then damage the player
    BEQ +               ;otherwise dismount yoshi
    JSR FindYoshi
    BCC +
    JSR DismountYoshi
    PLX
RTS
+
    JSL $00F5B7|!rom
    PLX
RTS
 
FindYoshi:
    LDX $18DF|!addr
    BEQ .crawlForYoshi
    DEX
    BRA .found
.crawlForYoshi:
    LDX.w $1692|!addr
    ; Start Slot according to sprite data
    LDA.l $02A773|!rom,x
    SEC
    SBC #$FE ; spaces 2 reserved slots, have to interact with them too
    TAX
.loop:
    LDA !SpriteNumber,x
    CMP #$35
    BNE .continueLoop
   
    LDA !SpriteStatus,x
    BNE .found
.continueLoop
    DEX
    BPL .loop
.returnClear:
    CLC
    RTS
.found
    SEC
    RTS
 
DismountYoshi:
    LDA #$10                
    STA !SpriteDecTimer6,x            
    LDA #$03                ; \ Play sound effect
    STA $1DFA|!addr         ; /
    LDA #$13                ; \ Play sound effect
    STA $1DFC|!addr         ; /
    LDA #$02                
    STA !SpriteMiscTable3,x    
    STZ $187A|!addr        
    LDA #$C0                
    STA !PlayerYSpeed      
    STZ !PlayerXSpeed      
    %SubHorzPos()      
    LDA XSpeedDismountTable,y      
    STA !SpriteXSpeed,X    
    STZ !SpriteMiscTable10,x            
    STZ !SpriteMiscTable6,X            
    STZ $18AE|!addr              
    STZ $0DC1|!addr      
    LDA #$30                ; \ Mario invincible timer = #$30
    STA $1497|!addr         ; /
    JSR CODE_01EDCC        
RTS                       ; Return
 
XSpeedDismountTable:
    db $E8,$18
 
CODE_01EDCC:
    LDY.B #$00                
    LDA !SpriteYLow,X      
    SEC                      
    SBC YoshiOffset,Y      
    STA !PlayerY        
    STA $D3                  
    LDA !SpriteYHigh,X    
    SBC #$00                
    STA !PlayerY+$01      
    STA $D4                  
RTS                       ; Return
 
YoshiOffset:
    db $04,$10
;>End Hitboxes Interaction Section


IgnoreList: 
	%checkRow(0)
	%checkRow(1)
	%checkRow(2)
	%checkRow(3)
	%checkRow(4)
	%checkRow(5)
	%checkRow(6)
	%checkRow(7)
	%checkRow(8)
	%checkRow(9)
	%checkRow(A)
	%checkRow(B)
	%checkRow(C)
	%checkRow(D)
	%checkRow(E)
	%checkRow(F)
	
FindOAM:
-	
	LDA.w IgnoreList,y
	BNE ++
	LDA !TileYPosition200,y
	CMP #$F0
	BEQ +
++

	DEY
	DEY
	DEY
	DEY

	BPL -

	CLC
RTS
+	
	SEC
RTS

TopOrLeftLimit:
	dw $FFF8,$FFF0

!YScreenPos = $01,s
!XScreenPos = $03,s
!TopOrLeftLimit = $05,s
!StackPointer = $07,s

macro ReturnCheckPosition()
	LDA !XScreenPos
	STA !Scratch49
	LDA !YScreenPos
	STA !Scratch4B

    LDA !StackPointer
    TCS
	SEP #$20
endmacro
CheckPosition:
	PHX
	TAX

	REP #$20

    TSC
    PHA             

	LDA.l TopOrLeftLimit,x
	PHA

	LDA !Scratch45
	CLC
	ADC !Scratch49
	SEC
	SBC !Layer1X
	PHA

	LDA !Scratch47
	CLC
	ADC !Scratch4B
	SEC
	SBC !Layer1Y
	PHA

	LDA !XScreenPos
	CMP !TopOrLeftLimit
	BCC +

	INX
	BRA .CheckVertical
+
	CMP #$0100
	BCC .CheckVertical
	%ReturnCheckPosition()
	PLX
	CLC
RTS
.CheckVertical

	LDA !YScreenPos
	CMP !TopOrLeftLimit
	BCC +
	STX !Scratch4D
	%ReturnCheckPosition()
	PLX
	SEC
RTS
+
	CMP #$00E0
	BCC +
	%ReturnCheckPosition()
	PLX
	CLC
RTS
+
	STX !Scratch4D
	%ReturnCheckPosition()
	PLX
	SEC
RTS

SelectStartSlot:

	LDY #$00EC
	LDA !TileYPosition200,y
	CMP #$F0
	BEQ +

	LDY !LastOAM200Slot
+

RTS

;>Routine: GraphicRoutine
;>Description: Updates tiles on the oam map
;results will be visible the next frame.
;>RoutineLength: Short
GraphicRoutine:
    LDA !Tile,x
    STA !Scratch52

    LDA !PalAndPage,x
    AND #$0F
    STA !Scratch51

	LDA !ExtendedXLow,x
	STA !Scratch45
	LDA !ExtendedXHigh,x
	STA !Scratch46

	LDA !ExtendedYLow,x
	STA !Scratch47
	LDA !ExtendedYHigh,x
	STA !Scratch48

    PHX
    REP #$10
	JSR SelectStartSlot

	JSR FindOAM
	BCC .return

	STZ !Scratch4A
	STZ !Scratch49

	STZ !Scratch4C
	STZ !Scratch4B


	LDA #$00
    XBA
    LDA #$00
	JSR CheckPosition
	BCC .return

	LDA !Scratch52
    STA !TileCode200,y                     ;Set the Tile code of the tile Y

	LDA #$20
    ORA !Scratch51
    STA !TileProperty200,y                 ;Set the Tile property of the tile Y

	LDA !Scratch49
	STA !TileXPosition200,y

	LDA !Scratch4B
	STA !TileYPosition200,y

    PHY
	REP #$20                                 
    TYA
    LSR
    LSR
    TAY                                 ;Y = Y/4 because size directions are not continuous to map 200 and 300
	SEP #$20
    LDA !Scratch4D
    STA !TileSize420,y                  ;Set the Tile size of the tile Y
    PLY

    DEY
	DEY
	DEY
	DEY

	JSR FindOAM
    STY !LastOAM200Slot
    SEP #$10
    PLX
RTS
.return
    SEP #$10
    PLX
    STZ !ExtendedNumber,x
RTS