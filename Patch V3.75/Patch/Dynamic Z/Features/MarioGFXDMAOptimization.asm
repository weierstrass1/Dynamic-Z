
macro CheckAndSendDMA(addr, vram, size)
    CMP <addr>|!addr
    BEQ ?+
    STA <addr>|!addr
    PHA
    SEP #$20
    %TransferToVRAM(<vram>, "<addr>|!addr", #$007E, <size>)
    REP #$20
    PLA
?+       
endmacro

PlayerDynamicRoutine:
    REP #$20                  ; Accum (16 bit) 
    LDX.B #$00                
    LDA $09                   
    ORA.W #$0800              
    CMP $09                   
    BEQ +           
    CLC                       
+
    AND.W #$F700              
    ROR                       
    LSR                       
    ADC.W #$2000              
    %CheckAndSendDMA($0D85, #$6000, #$0040)             
    CLC                       
    ADC.W #$0200     
    %CheckAndSendDMA($0D8F, #$6100, #$0040)                    
    LDX.B #$00                
    LDA $0A                   
    ORA.W #$0800              
    CMP $0A                   
    BEQ +           
    CLC                       
+
    AND.W #$F700              
    ROR                       
    LSR                       
    ADC.W #$2000 
    %CheckAndSendDMA($0D87, #$6020, #$0040)                           
    CLC                       
    ADC.W #$0200       
    %CheckAndSendDMA($0D91, #$6120, #$0040)                     
    LDA $0B                   
    AND.W #$FF00              
    LSR                       
    LSR                       
    LSR                       
    ADC.W #$2000       
    %CheckAndSendDMA($0D89, #$6040, #$0040)                     
    CLC                       
    ADC.W #$0200  
    %CheckAndSendDMA($0D93, #$6140, #$0040)                       
    LDA $0C                   
    AND.W #$FF00              
    LSR                       
    LSR                       
    LSR                       
    ADC.W #$2000       
    %CheckAndSendDMA($0D99, #$67F0, #$0020)                    

    LDA $0D82|!addr
    CMP.l DZ.PPUMirrors.CGRAMLastPlayerPal
    BEQ +
    STA.l DZ.PPUMirrors.CGRAMLastPlayerPal
    SEP #$20
    %TransferToCGRAM(#$86, $0D82|!addr, #$0000, #$0014)
+

    SEP #$20                  ; Accum (8 bit) 

    LDA.B #$0A                
    STA.W $0D84               

JML $00F63A|!rom

PodooboDMA:
    REP #$20                  ; Accum (16 bit) 
    LDA.W #$0008              
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    CLC                       
    ADC.W #$8500              
    %CheckAndSendDMA($0D8B, #$6060, #$0040)               
    CLC                       
    ADC.W #$0200   
    %CheckAndSendDMA($0D95, #$6160, #$0040)                          
    SEP #$20                  ; Accum (8 bit) 
JML $01E1B7|!rom

YoshiDMA:
    REP #$20                  ; Accum (16 bit) 
    LDA $00                   
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    CLC                       
    ADC.W #$8500              
    %CheckAndSendDMA($0D8B, #$6060, #$0040)              
    CLC                       
    ADC.W #$0200              
    %CheckAndSendDMA($0D95, #$6160, #$0040)               
    LDA $02                   
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    CLC                       
    ADC.W #$8500              
    %CheckAndSendDMA($0D8D, #$6080, #$0040)                 
    CLC                       
    ADC.W #$0200              
    %CheckAndSendDMA($0D97, #$6180, #$0040)                  
    SEP #$20                  ; Accum (8 bit) 
JML $01EED8|!rom

IDKDMA:
    REP #$20                  ; Accum (16 bit) 
    LDA $00                   
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    ASL                       
    CLC                       
    ADC.W #$8500              
    %CheckAndSendDMA($0D8B, #$6060, #$0040)               
    CLC                       
    ADC.W #$0200              
    %CheckAndSendDMA($0D95, #$6160, #$0040)                
    SEP #$20                  ; Accum (8 bit) 
JML $02EA4D|!rom