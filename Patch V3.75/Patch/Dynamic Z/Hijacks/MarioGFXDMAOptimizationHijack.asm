if !PlayerFeatures == !True

org $00F636
	autoclean JML PlayerDynamicRoutine
	RTS
	NOP

org $01E19D	
	autoclean JML PodooboDMA
	NOP

org $01EEAA
	autoclean JML YoshiDMA

org $02EA34
	autoclean JML IDKDMA	

org $00A300
	RTS
	NOP
else
org $00F636
	REP #$20                  ; Accum (16 bit) 
	LDX.B #$00                
	LDA $09

org $01E19D
	REP #$20                  ; Accum (16 bit) 
	LDA.W #$0008 

org $01EEAA
	REP #$20                  ; Accum (16 bit) 
	LDA $00      

org $02EA34
	REP #$20                  ; Accum (16 bit) 
	LDA $00  

org $00A300
	REP #$20                  ; 16 bit A ; Accum (16 bit) 
	
endif