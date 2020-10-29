;####################################################################################################
;############################################ Find Space ############################################
;####################################################################################################
;X = Slot
;!ScratchF = Space used
FindFreeSpace:
    TXA                     ;
    CMP.l DZ_DS_FirstSlot    ;
    BNE +                   ;if(X == first)
RTS                         ;   return
+
    
    PHX                     ;
    LDA.l DZ_DS_FirstSlot    ;i = first
    TAX                     ;
-
    LDA.l DZ_DS_Loc_UsedBy,x      ;
    CMP #$FF                    ;if(i.UsedBy == null || !i.isValid())
    BEQ +                       ;{
                                ;
    PHX                         ;
    JSR CallCheck2              ;
    BCS ++                      ;
                                ;
    PLX                         ;
+                               ;
    LDA.l DZ_DS_Loc_NextSlot,x    ;
    PHA                         ;
    JSR RemoveAt                ;   RemoveAt(i);
    PLX                         ;   i = i.next;
    TXA                         ;   
    CMP $01,s                   ;   if(i == X)
    BEQ +                       ;       return;
    BPL -                       ;
+                               ;
    PLX                         ;}
RTS                             ;else
++                              ;{
    PLX                         ;
                                ;
    LDA.l DZ_DS_Loc_PreviewSlot,x ;   if(i == first)
    BPL +                       ;   {
                                ;
    LDA.l DZ_DS_FindSpaceMethod  ;       if(FindSpaceMethod == Top To Bottom)
    BNE ++                      ;
    LDA #$00                    ;           InitialOffset = 0;
    BRA +++                     ;       
++                              ;       else
    LDA.l DZ_DS_MaxSpace         ;           IntitialOffset = Max Space;
    BRA +++                     ;   }
+                               ;   else
    PHX                         ;   {
    TAX                         ;
                                ;       if(FindSpaceMethod == Top To Bottom)
    LDA.l DZ_DS_FindSpaceMethod  ;       
    BNE ++                      ;
                                ;
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x ;       InitialOffset = i.preview.OffSet + i.preview.SpaceUsed;
    CLC                             ;
    ADC.l DZ_DS_Loc_SpaceUsed,x       ;
    PLX                             ;
    BRA +++                         ;   else
++                                  ;
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x ;       InitialOffset = i.preview.OffSet;
    PLX                         ;   }
+++                             ;
    PHA                         ;

    LDA.l DZ_DS_FindSpaceMethod  ;    if(FindSpaceMethod == Top To Bottom)
    BNE ++                          ;{
                                    ;
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x ;   if(i.OffSet - InitialOffset < RequiredSpace)
    SEC                             ;   
    SBC $01,s                       ;       Go To Next
    CMP !ScratchF                   ;
    BCC .next                       ;   else
                                    ;   {
    PHX                             ;
    LDA $01,s                       ;
    TAX                             ;
    LDA.l DZ_DS_Loc_PreviewSlot,x     ;                  
    JSR MoveAt                      ;       MoveAt(X, i.preview);
    PLX                             ;   
    PLX                             ;       return;
RTS                                 ;   }
++                                  ;
    PLA                             ;else
    SEC                             ;{
    SBC.l DZ_DS_Loc_SpaceUsedOffset,x ;   if(InitialOffset - i.OffSet - i.SpaceUsed < RequiredSpace)       
    SEC
    SBC.l DZ_DS_Loc_SpaceUsed,x       ;
    CMP !ScratchF                   ;       Go To Next
    BCC .next                       ;
                                    ;   else
    PHX                             ;   {
    LDA $01,s                       ;       
    TAX                             ;   
    LDA.l DZ_DS_Loc_PreviewSlot,x     ;       MoveAt(X, i.preview);
    JSR MoveAt                      ;
    PLX                             ;
    PLX                             ;       return;
RTS                                 ;   }
                                    ;}

.next                               ;Next:
    LDA.l DZ_DS_Loc_NextSlot,x        ;
    CMP $01,s                       ;if(i.next == X)
    BEQ +                           ;   return;
    TAX                             ;i = i.next
    BMI +                           ;if(i < 0)
    JMP -                           ;   return;
+
    PLX
RTS

;X = Slot
GetFirstSpace:
    LDA.l DZ_DS_FindSpaceMethod          ;if(FindSpaceMethod == Top To Bottom)
    BNE +
    LDA #$00
    STA.l DZ_DS_Loc_SpaceUsedOffset,x     ;   X.Offset = 0;
RTS
+
    LDA.l DZ_DS_MaxSpace                 ;else
    SEC
    SBC.l DZ_DS_Loc_SpaceUsed,x
    STA.l DZ_DS_Loc_SpaceUsedOffset,x     ;   X.Offset = MaxSpace - X.SpaceUsed;
RTS
;X = Slot
AssignSpaceBasedOnSlot2:
    LDA.l DZ_DS_Loc_PreviewSlot,x         ;if(X == first)
    BPL +                               ;{
                                        ;
    JSR GetFirstSpace                   ;   GetFirstSpace(X);
    SEC                                 ;   return CarrySet;
RTS                                     ;}

+
    STX !ScratchE                       ;

    BRA AssignSpaceBasedOnSlot_Start
;X = Slot
AssignSpaceBasedOnSlot:
    LDA.l DZ_DS_Loc_PreviewSlot,x
    BPL +

    JSR GetFirstSpace
    SEC
RTS
+
    PHA
    PHX
    STX !ScratchE
    LDA.l DZ_DS_Loc_SpaceUsed,x
    STA !ScratchF
    JSR FindFreeSpace                   ;FindFreeSpace(X, X.SpaceUsed);
    PLX
    PLA

.Start

    PHX                                 ;
    TAX                                 ;i = X.preview;
-
    LDA.l DZ_DS_Loc_UsedBy,x              ;if(i.UsedBy == null || !i.isValid())
    CMP #$FF                            ;{
    BEQ +                               ;
                                        ;
    PHX                                 ;
    JSR CallCheck2                      ;
    BCS ++                              ;
                                        ;
    PLX                                 ;
+                                       ;
    LDA.l DZ_DS_Loc_PreviewSlot,x         ;
    PHA                                 ;
    JSR RemoveAt                        ;   RemoveAt(i);
    PLX                                 ;   i = i.preview;
    BPL -                               ;   if(i<0)
                                        ;
    PLX                                 ;    
    JSR GetFirstSpace                   ;       GetFirstSpace(X);  
    SEC                                 ;   return Carry Set;
RTS                                     ;}
                                        ;else
++                                      ;{
    PLX                                 ;
                                        ;
    LDA.l DZ_DS_FindSpaceMethod          ;   if(FindSpaceMethod == Top To Bottom)
    BNE +                               ;
                                        ;       
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x     ;       
    CLC                                 ;
    ADC.l DZ_DS_Loc_SpaceUsed,x           ;
    PLX                                 ;
    STA.l DZ_DS_Loc_SpaceUsedOffset,x     ;       X.Offset = i.Offset + i.SpaceUsed;
                                        ;
    BRA ++                              ;
+                                       ;   else
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x     ;
    SEC                                 ;       X.Offset = i.Offset - X.SpaceUsed;
    PLX                                 ;
    SBC.l DZ_DS_Loc_SpaceUsed,x           ;
    STA.l DZ_DS_Loc_SpaceUsedOffset,x     ;}
++                                      ;
                                        ;
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x     ;
    BMI +                               ;if(X.Offset < 0 || X.Offset + X.SpaceUsed > MaxSpace)
    CLC                                 ;   return Carry Clear;
    ADC.l DZ_DS_Loc_SpaceUsed,x           ;
    CMP.l DZ_DS_MaxSpace                 ;
    BCC ++                              ;
    BEQ ++                              ;
    BRA +                               ;
++                                      ;
    SEC                                 ;return Carry Set
RTS
+
    CLC
RTS

;####################################################################################################
;########################################### Linked List ############################################
;####################################################################################################
;A = UsedBy
FindSlot:
    PHA
    LDX #$2F                    ;\X = 2F
-                               ;|
    LDA.l DZ_DS_Loc_UsedBy,x      ;|check if slot is used or clear
    CMP #$FF                    ;|
    BEQ +                       ;|
    BIT #$80
    BNE ++
    CMP $01,s
    BEQ +

++
    DEX                         ;|Next slot
    BPL -                       ;|
                                ;|
    PLA
    CLC                         ;|if didn't find slot then ret and clear carry
RTS                             ;|
+                               ;|
    STX !Scratch0               ;|if slot is unused then !Scratch0 = unused slot

    PLA
    
    JSR RemoveAt

    SEC                         ;|Set Carry
RTS                             ;/
;X = New Slot
;summary:
;
;if(X < 0 || X >= 0x30)
;   return;
;
;Length++;
;
;if(Length == 1)
;{
;   first = last = X;
;   X.next = X.preview = null;
;}
;else
;{
;   X.next = first;
;   first.preview = X;
;   X.preview = null;
;   first = X;
;}
AddFirst:

    TXA             ;
    BPL +           ;
RTS                 ;
+                   ;if X is a valid value
    CMP #$30        ;
    BCC +           ;
RTS                 ;
+

    LDA.l DZ_DS_Length   ;
    INC A               ;Length++;
    STA.l DZ_DS_Length   ;
    CMP #$01
    BNE +

    TXA                         ;if(Length == 1)
    STA.l DZ_DS_FirstSlot        ;first = last = X;
    STA.l DZ_DS_LastSlot         ;
    LDA #$FF                    ;
    STA.l DZ_DS_Loc_NextSlot,x    ;X.next = X.preview = null;
    STA.l DZ_DS_Loc_PreviewSlot,x ;
RTS
+
    PHX                         ;else                   //Preserve X
    LDA.l DZ_DS_FirstSlot        ;                       
    STA.l DZ_DS_Loc_NextSlot,x    ;X.next = first;

    TAX                         ;                       //X reg = First Slot
    PLA                         ;first.preview = X;     //A = X
    STA.l DZ_DS_Loc_PreviewSlot,x ;                       //first.Preview = X
    TAX                         ;                       //X reg = X

    LDA #$FF                    ;
    STA.l DZ_DS_Loc_PreviewSlot,x ;X.preview = null;      

    TXA                         ;                       //A = X
    STA.l DZ_DS_FirstSlot        ;first = X;             //first = X

RTS
;X = New Slot
;summary:
;
;if(X < 0 || X >= 0x30)
;   return;
;
;Length++;
;
;if(Length == 1)
;{
;   first = last = X;
;   X.next = X.preview = null;
;}
;else
;{
;   X.preview = last;
;   last.next = X;
;   X.next = null;
;   last = X;
;}
AddLast:

    TXA             ;
    BPL +           ;
RTS                 ;
+                   ;if X is a valid value
    CMP #$30        ;
    BCC +           ;
RTS                 ;
+

    LDA.l DZ_DS_Length   ;
    INC A               ;Length++;
    STA.l DZ_DS_Length   ;
    CMP #$01
    BNE +

    TXA                         ;if(Length == 1)
    STA.l DZ_DS_FirstSlot        ;first = last = X;
    STA.l DZ_DS_LastSlot         ;
    LDA #$FF                    ;
    STA.l DZ_DS_Loc_NextSlot,x    ;X.next = X.preview = null;
    STA.l DZ_DS_Loc_PreviewSlot,x ;
RTS
+
    PHX                         ;else
    LDA.l DZ_DS_LastSlot         ;
    STA.l DZ_DS_Loc_PreviewSlot,x ;X.preview = last;

    TAX                         ;
    PLA                         ;last.next = X;
    STA.l DZ_DS_Loc_NextSlot,x    ;
    TAX                         ;

    LDA #$FF                    ;
    STA.l DZ_DS_Loc_NextSlot,x    ;X.next = null;

    TXA                         ;
    STA.l DZ_DS_LastSlot         ;last = X;

RTS


;X = Slot to Remove
;summary:
;
;if(X < 0 || X >= 0x30)
;   return;
;
;if(X.next == null && X.preview == null && X != first)
;   return;
;
;Length--;
;
;if(Length == 0)
;{
;   X.next = X.preview = null;
;   first = last = null;
;   X.UsedBy = FF;
;}
;else
;{
;   if(X.preview != null)
;       X.preview.next = X.next;
;   else
;       first = X.next;
;
;   if(X.next != null)
;       X.next.preview = X.preview;
;   else
;       last = X.preview;
;
;   X.next = X.preview = null;
;   X.UsedBy = FF;
;}
RemoveAt:
    TXA                     ;
    BPL +                   ;
RTS                         ;
+                           ;if X is a valid value
    CMP #$30                ;
    BCC +                   ;
RTS                         ;
+

    LDA.l DZ_DS_Loc_NextSlot,x        ;
    BPL +                           ;
    LDA.l DZ_DS_Loc_PreviewSlot,x     ;
    BPL +                           ;
    TXA                             ;if(X.next == null && X.preview == null && X != first)
    CMP.l DZ_DS_FirstSlot            ;   return;
    BEQ +                           ;
RTS                                 ;
+                                   ;

    LDA.l DZ_DS_Length   ;
    DEC A               ;Length--;
    STA.l DZ_DS_Length   ;
    BNE +

    LDA #$FF                    ;
    STA.l DZ_DS_Loc_NextSlot,x    ;X.next = X.preview = null;
    STA.l DZ_DS_Loc_PreviewSlot,x ;
    STA.l DZ_DS_FirstSlot        ;first = last = null;
    STA.l DZ_DS_LastSlot         ;
    STA.l DZ_DS_Loc_UsedBy,x      ;X.UsedBy = FF;
RTS
+
    LDA.l DZ_DS_Loc_PreviewSlot,x
    BMI +

    PHX                             ;if(X.preview != null)          //Preserve X
    PHA                             ;   X.preview.next = X.next;    //Preserve X.preview
    LDA.l DZ_DS_Loc_NextSlot,x        ;                               //A = X.next                     
    PLX                             ;                               //X reg = X.preview
    STA.l DZ_DS_Loc_NextSlot,x        ;                               //X.preview.next = X.next;
    PLX                             ;                               //X reg = X
    BRA ++
+
    LDA.l DZ_DS_Loc_NextSlot,x        ;else
    STA.l DZ_DS_FirstSlot            ;   first = X.next;
++

    LDA.l DZ_DS_Loc_NextSlot,x
    BMI +

    PHX                             ;if(X.next != null)                 //Preserve X
    PHA                             ;   X.next.preview = X.preview;     //Preserve X.next
    LDA.l DZ_DS_Loc_PreviewSlot,x     ;                                   //A = X.preview                     
    PLX                             ;                                   //X reg = X.preview
    STA.l DZ_DS_Loc_PreviewSlot,x     ;                                   //X.next.preview = X.preview;
    PLX                             ;                                   //X reg = X
    BRA ++
+
    LDA.l DZ_DS_Loc_PreviewSlot,x     ;else
    STA.l DZ_DS_LastSlot             ;   last = X.preview;
++

    LDA #$FF                    ;
    STA.l DZ_DS_Loc_NextSlot,x    ;X.next = X.preview = null;
    STA.l DZ_DS_Loc_PreviewSlot,x ;
    STA.l DZ_DS_Loc_UsedBy,x      ;X.UsedBy = FF;
RTS

;X = Slot to Move
;A = Position - 1
;
;summary:
;
;aux = X.UsedBy;
;RemoveAt(X);
;X.UsedBy = aux;
;
;if(position - 1 == null)
;   AddFirst(X);
;else
;{
;   X.next = position - 1.next;
;   if(X.next == null)
;       last = X;
;   else
;       X.next.preview = X;
;   X.preview = position - 1;
;   position - 1.next = X
;   Length++;
;}
MoveAt:
    PHA
    LDA.l DZ_DS_Loc_UsedBy,x  ;
    PHA                     ;aux = X.UsedBy;
    JSR RemoveAt            ;RemoveAt(X);
    PLA                     ;
    STA.l DZ_DS_Loc_UsedBy,x  ;X.UsedBy = aux;

    LDA $01,s
    BPL +
                                ;if(position - 1 == null)
    JSR AddFirst                ;       AddFirst(X);
    PLA                         ;
RTS                             ;
+                               ;
                                ;else
                                ;{
    PHX                         ;                                   //preserve X
    TAX                         ;                                   //X reg = position - 1
    LDA.l DZ_DS_Loc_NextSlot,x    ;                                   //A = position -1.next
    PLX                         ;                                   //X reg = X
    STA.l DZ_DS_Loc_NextSlot,x    ;   X.next = position - 1.next;     //X.next = position - 1.next
                                ;
    CMP #$80                    ;
    BCC +                       ;   if(X.next == null)
                                ;
    TXA                         ;                                   //A = X
    STA.l DZ_DS_LastSlot         ;       last = X;                   /last = X
    BRA ++                      ;
+                               ;   else
    PHA                         ;                                   //A = X.next, preserve A
    TXA                         ;                                   //A = X
    PLX                         ;                                   //X reg = X.next
    STA.l DZ_DS_Loc_PreviewSlot,x ;       X.next.preview = X;         //x.next.preview = X;
    TAX                         ;                                   //X reg = X
++                              ;
                                ;
    LDA $01,s                   ;                                   //A = position - 1
    STA.l DZ_DS_Loc_PreviewSlot,x ;   X.preview = position - 1        //X.preview = position - 1 

    TXA                         ;                                   //A = X
    PLX                         ;                                   //X reg = position - 1
    STA.l DZ_DS_Loc_NextSlot,x    ;   position - 1.next = X           //position - 1.next = X
    TAX                         ;                                   //X reg = X

    LDA.l DZ_DS_Length           ;
    INC A                       ;   Length++;
    STA.l DZ_DS_Length           ;
                                ;}
RTS

;####################################################################################################



!MustFindSpace = !Scratch0
!totalSpace = !Scratch1
!ind = !Scratch2
!typ = !Scratch3
!sn = !Scratch8
!lastpos = !Scratch9
!lastusedPos = !ScratchA
ClearSlot:
    LDA #$00
    STA.l DZ_DS_TotalDataSentOdd
    STA.l DZ_DS_TotalDataSentEven
    STA.l DZ_DS_TotalSpaceUsedOdd
    STA.l DZ_DS_TotalSpaceUsedEven
    STA.l DZ_DS_TotalSpaceUsed

    LDA.l DZ_DS_FirstSlot        ;\
    BPL +                       ;|if last slot is negative negative then return because there aren't 
RTL                             ;|used slots
+                               ;/

    LDA #$FF                    ;\
    STA !MustFindSpace          ;/mark the slot that was cleared
    STA !lastpos

    PHX                     ;\
    LDA.l DZ_DS_FirstSlot    ;| x = last slot
    TAX                     ;|
-                           ;/
    LDA.l DZ_DS_Loc_UsedBy,x      ;\
    CMP #$FF                    ;|if slot is unused then skip
    BEQ +                   ;/

    PHX
    JSR .CallCheck
    BCS ++

    PLX
+

    LDA.l DZ_DS_Loc_NextSlot,x      ;\
    PHA
    JSR RemoveAt
    PLX
    BMI .ret                            ;|if is the last slot then return
    BRA -                               ;/go to the next slot

++
    PLX                         ;\
    JSR .IsUsed                 ;/Update total space used and fix links on the linked list

    STX !lastpos

    LDA.l DZ_DS_Loc_NextSlot,x     ;\
    BMI .ret                    ;|if is the last slot then return
    TAX                         ;|
    BRA -                       ;/go to the next slot

.ret
    PLX

    LDA.l DZ_DS_TotalSpaceUsed       ;\
    CLC                         ;|
    ADC.l DZ_DS_TotalSpaceUsedOdd    ;|
    CLC
    ADC.l DZ_DS_TotalSpaceUsedEven   ;|
    STA.l DZ_DS_TotalSpaceUsed       ;/Total Space Used = Space used by 60fps sprites + space used by 30fps sprites

RTL

.IsUsed

    LDA.l DZ_DS_Loc_SpaceUsed,x          ;\
    PHA                         ;/$02,s = space used used

    LDA.l DZ_DS_Loc_FrameRateMethod,x    ;\
    BEQ +                       ;|Check if is any frame (60fps) or not (30fps)
    DEC A                       ;/

    PHX                         ;\
    TAX                         ;|X = 0 (only odd frames) or 1 (only even frames)
    LDA.l DZ_DS_TotalSpaceUsedOdd,x  ;| 
    CLC                         ;|
    ADC $02,s                   ;|
    STA.l DZ_DS_TotalSpaceUsedOdd,x  ;|DZ_DS_TotalSpaceUsedOdd (or DSTotalSpaceUsedEven) += Space used                          ;/

    LDA $02,s                   ;\
    CLC                         ;|
    ADC.l DZ_DS_TotalDataSentOdd,x   ;|Total data += space used
    STA.l DZ_DS_TotalDataSentOdd,x   ;/
    PLX
    PLA

RTS
+
    LDA $01,s                   ;\
    CLC                         ;|
    ADC.l DZ_DS_TotalSpaceUsed       ;|
    STA.l DZ_DS_TotalSpaceUsed       ;/DZ_DS_TotalSpaceUsed += space used

    LDA $01,s                   ;\
    CLC                         ;|
    ADC.l DZ_DS_TotalDataSentOdd     ;|Total data += space used
    STA.l DZ_DS_TotalDataSentOdd     ;/

    PLA                         ;\
    CLC                         ;|
    ADC.l DZ_DS_TotalDataSentEven    ;|Total data += space used
    STA.l DZ_DS_TotalDataSentEven    ;/
RTS

.CallCheck:

    AND #$1F            ;\
    STA !ind            ;/!ind = index of the sprite.

    LDA.l DZ_DS_Loc_SpriteNumber,x    ;\
    STA !sn                         ;/!sn = sprite number

    LDA.l DZ_DS_Loc_UsedBy,x      ;\
    CLC                         ;|
    ROL                         ;|
    ROL                         ;|x = Sprite Type
    ROL                         ;|0 = Normal, 1 = Cluster, 2 = extended, 3 = overworld
    ROL                         ;|4 = Shared Normal, 5 = Shared Cluster, 6 = Shared extended, 7 = Shared overworld
    AND #$07
    ASL                         ;|
    TAX                         ;/x = Sprite Type*2

    JSR (.Check,x)              ;\
RTS

.Check
    dw .Normal
    dw .Cluster
    dw .Extended
    dw .OW
    dw .NormalShared
    dw .ClusterShared
    dw .ExtendedShared
    dw .OWShared

.Normal                    
    LDX !ind
    LDA DZ_DS_Loc_US_Normal,x
    CMP #$FF
    BEQ +

    LDA !SpriteNumberNormal,x
    CMP !sn
    BNE +
    LDA !SpriteStatus,x
    BEQ +

    SEC
RTS
+
    CLC
RTS

.Cluster                            ;\
    LDX !ind                        ;|
    LDA DZ_DS_Loc_US_Cluster,x
    CMP #$FF
    BEQ +
    LDA !ClusterSpriteNumber,x      ;|
    CMP !sn                         ;|
    BEQ +                           ;|
    CLC                             ;|Check if the sprite number is equals to registered sprite number
RTS                                 ;|
+                                   ;|
    SEC                             ;|
RTS                                 ;/

.Extended                           ;\
    LDX !ind                        ;|
    LDA DZ_DS_Loc_US_Extended,x
    CMP #$FF
    BEQ +
    LDA !ExtendedSpriteNumber,x     ;|
    CMP !sn                         ;|
    BEQ +                           ;|
    CLC                             ;|Check if the sprite number is equals to registered sprite number
RTS                                 ;|
+                                   ;|
    SEC                             ;|
RTS                                 ;/

.OW                                 ;\
    LDX !ind                        ;|
    LDA DZ_DS_Loc_US_OW,x
    CMP #$FF
    BEQ +
    LDA !OWSpriteNumber,x           ;|
    CMP !sn                         ;|
    BEQ +                           ;|
    CLC                             ;|Check if the sprite number is equals to registered sprite number
RTS                                 ;|
+                                   ;|
    SEC                             ;|
RTS                                 ;/

.NormalShared                       
    LDX #!MaxSprites-1                 
-
    LDA !SpriteNumberNormal,x
    CMP !sn
    BNE +
    LDA !SpriteStatus,x
    BEQ +
    LDA DZ_DS_Loc_US_Normal,x
    CMP #$FF
    BEQ +
    PHX
    TAX
    LDA DZ_DS_Loc_UsedBy,x
    PLX
    AND #$80
    BEQ +

    SEC
RTS
+
    DEX
    BPL -
    CLC
RTS

.ClusterShared
    LDX #$13
-
    LDA !ClusterSpriteNumber,x
    CMP !sn
    BNE +

    LDA DZ_DS_Loc_US_Cluster,x
    CMP #$FF
    BEQ +
    PHX
    TAX
    LDA DZ_DS_Loc_UsedBy,x
    PLX
    AND #$80
    BEQ +

    SEC
RTS
+
    DEX
    BPL -
    CLC
RTS

.ExtendedShared
    LDX #$09
-
    LDA DZ_DS_Loc_US_Extended,x
    CMP #$FF
    BEQ +
    LDA !ExtendedSpriteNumber,x
    CMP !sn
    BNE +

    LDA DZ_DS_Loc_US_Extended,x
    CMP #$FF
    BEQ +
    PHX
    TAX
    LDA DZ_DS_Loc_UsedBy,x
    PLX
    AND #$80
    BEQ +

    SEC
RTS
+
    DEX
    BPL -
    CLC
RTS

.OWShared
    LDX #$0F
-
    LDA DZ_DS_Loc_US_OW,x
    CMP #$FF
    BEQ +
    LDA !OWSpriteNumber,x
    CMP !sn
    BNE +
    LDA DZ_DS_Loc_US_OW,x
    CMP #$FF
    BEQ +
    PHX
    TAX
    LDA DZ_DS_Loc_UsedBy,x
    PLX
    AND #$80
    BEQ +

    SEC
RTS
+
    DEX
    BPL -
    CLC
RTS

;###############################################################################################################

!csSpriteTypeAndSlot = $07,s
!csFrameRateMode = $06,s
!csSpriteNumber = $05,s
!csNumberOf16x16Tiles = $04,s

CheckSlot:
    LDA !csNumberOf16x16Tiles   ;\
    CLC                         ;|
    ADC.l DZ_DS_TotalSpaceUsed   ;|
    CMP.l DZ_DS_MaxSpace         ;|if Total Space + space used for this sprite > max space then ret
    BEQ +                       ;|
    BCC +                       ;|
                                ;|
    CLC                         ;|
RTL                             ;|
+                               ;/
    LDA !csSpriteTypeAndSlot
    JSR FindSlot               ;!Scratch0 = Free slot
    BCS +

    CLC
RTL
+
    LDA !csFrameRateMode        ;\ 
    BNE +                       ;/if FrameRateMode == 0 then decide odd or even automatically 

    LDX #$01                    ;by default is even (1)
    LDA.l DZ_DS_TotalSpaceUsedOdd    ;if off is less than even then x = 0
    CMP.l DZ_DS_TotalSpaceUsedEven
    BCS +++
    DEX  
+++
    BRA ++                      ;Jump to check

+
    CMP #$03
    BCS +

    DEC A                      ;if FrameRateMode == 1 or 2, use odd (1) or even (2)
    TAX
++

    LDA !csNumberOf16x16Tiles
    CLC
    ADC.l DZ_DS_TotalDataSentOdd,x
    CMP.l DZ_MaxDataPerFrameIn16x16Tiles      ;check if is safe increase data
    BCC ++
    BEQ ++

    CLC
RTL
++
    STA.l DZ_DS_TotalDataSentOdd,x

    LDA !csNumberOf16x16Tiles
    CLC
    ADC.l DZ_DS_TotalSpaceUsedOdd,x
    STA.l DZ_DS_TotalSpaceUsedOdd,x  ;update space used and data send for 30fps sprite

    INX
    BRA ++
+

    LDA !csNumberOf16x16Tiles
    CLC
    ADC.l DZ_DS_TotalDataSentOdd
    CMP.l DZ_MaxDataPerFrameIn16x16Tiles      ;check if is safe increase data
    BCC +
    BEQ +

    CLC
RTL
+
    STA !Scratch2
    LDA !csNumberOf16x16Tiles
    CLC
    ADC.l DZ_DS_TotalDataSentEven
    CMP.l DZ_MaxDataPerFrameIn16x16Tiles      ;check if is safe increase data
    BCC +
    BEQ +

    CLC
RTL
+
    STA.l DZ_DS_TotalDataSentEven    ;update space used and data send for 60fps sprite

    LDA !Scratch2
    STA.l DZ_DS_TotalDataSentOdd

    LDA !csNumberOf16x16Tiles
    CLC
    ADC.l DZ_DS_TotalSpaceUsed
    STA.l DZ_DS_TotalSpaceUsed

    LDX #$00  
++
    TXA
    LDX !Scratch0
    STA.l DZ_DS_Loc_FrameRateMethod,x    ;Set Frame rate Method (any, odd or even)

    LDA !csSpriteNumber
    STA.l DZ_DS_Loc_SpriteNumber,x       ;Set sprite number

    LDA !csSpriteTypeAndSlot
    STA.l DZ_DS_Loc_UsedBy,x             ;Set type and slot
    AND #$1F
    STA !Scratch45
    LDA !csSpriteTypeAndSlot
    CLC                         ;|
    ROL                         ;|
    ROL                         ;|$46 = Sprite Type
    ROL                         ;|0 = Normal, 1 = Cluster, 2 = extended, 3 = overworld
    ROL                         ;|4 = Shared Normal, 5 = Shared Cluster, 6 = Shared extended, 7 = Shared overworld
    AND #$07
    ASL                         ;|
    STA !Scratch46


    LDA #$FF
    STA.l DZ_DS_Loc_NextSlot,x     ;set as last slot

    LDA #$00
    STA.l DZ_DS_Loc_IsValid,x            ;Sprite is Invalid, must wait dynamic routine
    STA.l DZ_DS_Loc_SharedUpdated,x      ;If the sprite is Shared Dynamic, it is not updated yet

    LDA !csNumberOf16x16Tiles
    STA.l DZ_DS_Loc_SpaceUsed,x          ;Set number of 16x16 tiles

    JSR AddLast

    JSR AssignSpaceBasedOnSlot
    BCS +

    CLC
RTL
+

    SEC
RTL

CallCheck2:
    AND #$1F            ;\
    STA !ind            ;/!ind = index of the sprite.

    CPX !ScratchE
    BNE +               ;if slot to check is this slot then return carry set
    SEC
RTS
+
    LDA.l DZ_DS_Loc_SpriteNumber,x    ;\
    STA !sn                         ;/!sn = sprite number

    LDA.l DZ_DS_Loc_UsedBy,x      ;\
    CLC                         ;|
    ROL                         ;|
    ROL                         ;|x = Sprite Type
    ROL                         ;|0 = Normal, 1 = Cluster, 2 = extended, 3 = overworld
    ROL                         ;|4 = Shared Normal, 5 = Shared Cluster, 6 = Shared extended, 7 = Shared overworld
    AND #$07
    ASL                         ;|
    TAX                         ;/x = Sprite Type*2

    LDA !Scratch46
    CMP #$80
    BNE +                       ;if this slot is a shared dynamic sprite skip to check routine

    LDA !ind                    ;otherwise check if type and slot is the same then return carry clear.
    CMP !Scratch45
    BNE +
    CPX !Scratch46
    BNE +
    CLC
RTS
+

    JSR (ClearSlot_Check,x)    ;\check if the sprite is alive.
RTS


;###############################################################################################################

FindSpace:
    PHX
    LDX !Scratch0

    LDA.l DZ_DS_Loc_UsedBy,x             ;Set type and slot
    AND #$1F
    STA !Scratch45
    LDA.l DZ_DS_Loc_UsedBy,x
    CLC                         ;|
    ROL                         ;|
    ROL                         ;|$46 = Sprite Type
    ROL                         ;|0 = Normal, 1 = Cluster, 2 = extended, 3 = overworld
    ROL                         ;|4 = Shared Normal, 5 = Shared Cluster, 6 = Shared extended, 7 = Shared overworld
    AND #$07
    ASL                         ;|
    STA !Scratch46

    LDA.l DZ_DS_Loc_SpaceUsedOffset,x
    PHA

    JSR AssignSpaceBasedOnSlot2
    BCS +
-
    PLA
    PLX
    CLC
RTL
+
    STZ !ScratchB
    LDA $01,s
    CMP.l DZ_DS_Loc_SpaceUsedOffset,x
    BEQ +
    LDA #$01
    STA !ScratchB
+
    LDA.l DZ_DS_Loc_SpaceUsedOffset,x
    BMI -
    CLC
    ADC.l DZ_DS_Loc_SpaceUsed,x
    CMP.l DZ_DS_MaxSpace
    BCC +
    BEQ +
    BRA -
+
    PLA
    PLX
    SEC
RTL 

;###############################################################################################################

macro Transfer(offset, size, srcOffset)
    LDY <offset>
    REP #$20
    LDA Sizes,y
    CLC
    ADC.l DZ_DS_StartingVRAMOffset
    STA.l DZ_PPUMirrors_VRAM_Transfer_Offset,x

    LDY <srcOffset>
    LDA Sizes,y
    CLC
    ASL
    ADC !drAddr
    STA.l DZ_PPUMirrors_VRAM_Transfer_Source,x

    LDY <size>
    LDA Sizes,y
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceLength,x
    SEP #$20

    LDA !drBNK                  
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK,x
    LDA #$00
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK+$01,x

endmacro

Sizes: 
    dw $0000,$0020,$0040,$0060,$0080,$00A0,$00C0,$00E0,$0100,$0120,$0140,$0160,$0180,$01A0,$01C0,$01E0
    dw $0200,$0220,$0240,$0260,$0280,$02A0,$02C0,$02E0,$0300,$0320,$0340,$0360,$0380,$03A0,$03C0,$03E0
    dw $0400,$0420,$0440,$0460,$0480,$04A0,$04C0,$04E0,$0500,$0520,$0540,$0560,$0580,$05A0,$05C0,$05E0
    dw $0600,$0620,$0640,$0660,$0680,$06A0,$06C0,$06E0,$0700,$0720,$0740,$0760,$0780,$07A0,$07C0,$07E0
    dw $0800,$0820,$0840,$0860,$0880,$08A0,$08C0,$08E0,$0900,$0920,$0940,$0960,$0980,$09A0,$09C0,$09E0
    dw $0A00,$0A20,$0A40,$0A60,$0A80,$0AA0,$0AC0,$0AE0,$0B00,$0B20,$0B40,$0B60,$0B80,$0BA0,$0BC0,$0BE0
    dw $0C00,$0C20,$0C40,$0C60,$0C80,$0CA0,$0CC0,$0CE0,$0D00,$0D20,$0D40,$0D60,$0D80,$0DA0,$0DC0,$0DE0
    dw $0E00,$0E20,$0E40,$0E60,$0E80,$0EA0,$0EC0,$0EE0,$0F00,$0F20,$0F40,$0F60,$0F80,$0FA0,$0FC0,$0FE0
    dw $1000,$1020,$1040,$1060,$1080,$10A0,$10C0,$10E0,$1100,$1120,$1140,$1160,$1180,$11A0,$11C0,$11E0
    dw $1200,$1220,$1240,$1260,$1280,$12A0,$12C0,$12E0,$1300,$1320,$1340,$1360,$1380,$13A0,$13C0,$13E0
    dw $1400,$1420,$1440,$1460,$1480,$14A0,$14C0,$14E0,$1500,$1520,$1540,$1560,$1580,$15A0,$15C0,$15E0
    dw $1600,$1620,$1640,$1660,$1680,$16A0,$16C0,$16E0,$1700,$1720,$1740,$1760,$1780,$17A0,$17C0,$17E0
    dw $1800,$1820,$1840,$1860,$1880,$18A0,$18C0,$18E0,$1900,$1920,$1940,$1960,$1980,$19A0,$19C0,$19E0
    dw $1A00,$1A20,$1A40,$1A60,$1A80,$1AA0,$1AC0,$1AE0,$1B00,$1B20,$1B40,$1B60,$1B80,$1BA0,$1BC0,$1BE0
    dw $1C00,$1C20,$1C40,$1C60,$1C80,$1CA0,$1CC0,$1CE0,$1D00,$1D20,$1D40,$1D60,$1D80,$1DA0,$1DC0,$1DE0
    dw $1E00,$1E20,$1E40,$1E60,$1E80,$1EA0,$1EC0,$1EE0,$1F00,$1F20,$1F40,$1F60,$1F80,$1FA0,$1FC0,$1FE0
    dw $2000,$2020,$2040,$2060,$2080,$20A0,$20C0,$20E0,$2100,$2120,$2140,$2160,$2180,$21A0,$21C0,$21E0
    dw $2200,$2220,$2240,$2260,$2280,$22A0,$22C0,$22E0,$2300,$2320,$2340,$2360,$2380,$23A0,$23C0,$23E0
    dw $2400,$2420,$2440,$2460,$2480,$24A0,$24C0,$24E0,$2500,$2520,$2540,$2560,$2580,$25A0,$25C0,$25E0
    dw $2600,$2620,$2640,$2660,$2680,$26A0,$26C0,$26E0,$2700,$2720,$2740,$2760,$2780,$27A0,$27C0,$27E0
    dw $2800,$2820,$2840,$2860,$2880,$28A0,$28C0,$28E0,$2900,$2920,$2940,$2960,$2980,$29A0,$29C0,$29E0
    dw $2A00,$2A20,$2A40,$2A60,$2A80,$2AA0,$2AC0,$2AE0,$2B00,$2B20,$2B40,$2B60,$2B80,$2BA0,$2BC0,$2BE0
    dw $2C00,$2C20,$2C40,$2C60,$2C80,$2CA0,$2CC0,$2CE0,$2D00,$2D20,$2D40,$2D60,$2D80,$2DA0,$2DC0,$2DE0
    dw $2E00,$2E20,$2E40,$2E60,$2E80,$2EA0,$2EC0,$2EE0,$2F00,$2F20,$2F40,$2F60,$2F80,$2FA0,$2FC0,$2FE0
    dw $3000,$3020,$3040,$3060,$3080,$30A0,$30C0,$30E0,$3100,$3120,$3140,$3160,$3180,$31A0,$31C0,$31E0
    dw $3200,$3220,$3240,$3260,$3280,$32A0,$32C0,$32E0,$3300,$3320,$3340,$3360,$3380,$33A0,$33C0,$33E0
    dw $3400,$3420,$3440,$3460,$3480,$34A0,$34C0,$34E0,$3500,$3520,$3540,$3560,$3580,$35A0,$35C0,$35E0
    dw $3600,$3620,$3640,$3660,$3680,$36A0,$36C0,$36E0,$3700,$3720,$3740,$3760,$3780,$37A0,$37C0,$37E0
    dw $3800,$3820,$3840,$3860,$3880,$38A0,$38C0,$38E0,$3900,$3920,$3940,$3960,$3980,$39A0,$39C0,$39E0
    dw $3A00,$3A20,$3A40,$3A60,$3A80,$3AA0,$3AC0,$3AE0,$3B00,$3B20,$3B40,$3B60,$3B80,$3BA0,$3BC0,$3BE0
    dw $3C00,$3C20,$3C40,$3C60,$3C80,$3CA0,$3CC0,$3CE0,$3D00,$3D20,$3D40,$3D60,$3D80,$3DA0,$3DC0,$3DE0
    dw $3E00,$3E20,$3E40,$3E60,$3E80,$3EA0,$3EC0,$3EE0,$3F00,$3F20,$3F40,$3F60,$3F80,$3FA0,$3FC0,$3FE0


!drSize = $0A,s
!drVRAMOffset = $09,s
!drBNK = $08,s
!drAddr = $06,s

DynamicRoutine:

    PHX
    PHB
    PHK
    PLB

    LDA !drVRAMOffset           ;\
    CLC                         ;|
    ADC #$10                    ;|!Scratch0 = First Limit
    AND #$F0                    ;|
    STA !Scratch0               ;/


    LDA !drVRAMOffset           ;\
    CLC                         ;|
    ADC !drSize                 ;|if VRAM Offset + Size <= First Limit then require 1 transfer
    CMP !Scratch0               ;|
    BCC .OneTransfer            ;|
    BEQ .OneTransfer            ;|
                                ;|
    LDA !drVRAMOffset           ;|if don't start at 0 then requires 2 or more transfers
    AND #$0F
    BNE .TwoOrThreeTransfer     

.OneTransfer

    LDA.l DZ_PPUMirrors_VRAM_Transfer_Length   ;\
    INC A                       ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_Length   ;|Number of transfer ++
    ASL                         ;|
    TAX                         ;/X = number of transfer*2

    LDA !drBNK                  ;\
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK,x            ;|BNK (low byte) = source bnk
    LDA #$00                    ;|BNK (high byte) = 0
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK+$01,x        ;/

    LDA !drVRAMOffset           ;\      
    TAY                         ;/

    LDA !drSize                 ;\
    ASL                         ;|Push Size
    PHA                         ;/

    REP #$20

    LDA Sizes,y                 ;\
    CLC                         ;|
    ADC.l DZ_DS_StartingVRAMOffset   ;|MapVRAMOffset = Starting VRAM Offset + VRAM Offset
    STA.l DZ_PPUMirrors_VRAM_Transfer_Offset,x     ;/

    PLY                         ;\
    LDA Sizes,y                 ;|MapLength = Size
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceLength,x         ;/
    
    LDA !drAddr                 ;\
    STA.l DZ_PPUMirrors_VRAM_Transfer_Source,x       ;/MapAddr = Addr
    SEP #$20

    PLB
    PLX
RTL

.TwoOrThreeTransfer
    LDA !drSize             ;\
    CMP #$11                ;|check if use more than one line.
    BCC +
    JMP .moreThanOneLine    ;/
+
    LDA !Scratch0           ;\
    SEC                     ;|!Scratch1 = size to transfer on the first transfer
    SBC !drVRAMOffset       ;|
    STA !Scratch1           ;/

    LDA.l DZ_PPUMirrors_VRAM_Transfer_Length   ;\
    INC A                       ;|X = Index of current transfer
    ASL                         ;|
    TAX                         ;/
    LSR
    INC A
    STA.l DZ_PPUMirrors_VRAM_Transfer_Length 

    LDA !drBNK                  ;\
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK,x            ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK+$02,x        ;|Set bank for both transfers
    LDA #$00                    ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK+$01,x        ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceBNK+$03,x        ;/

    LDA !Scratch0               ;\
    CLC                         ;|Push VRAM Offset for second transfer
    ADC #$10                    ;|
    STA !Scratch2               ;/

    LDA !drSize                 ;\
    SEC                         ;|
    SBC !Scratch1               ;|Push Size of the second transfer
    CLC
    ASL                         ;|
    STA !Scratch3               ;/

    LDA !drVRAMOffset           ;\Y = Vram Offset of first transfer
    TAY                         ;/

    LDA !Scratch1               ;\
    ASL                         ;|Push Size of the first line
    PHA                         ;/

    REP #$20
    LDA Sizes,y                 ;\
    CLC                         ;|MAPVRAMOffset of first transfer = Starting VRAM Offset + Vram Offset of first transfer
    ADC.l DZ_DS_StartingVRAMOffset   ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_Offset,x     ;/

    PLY                         ;\
    LDA Sizes,y                 ;|MAPLength = Size of first transfer
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceLength,x         ;/

    LDA !drAddr                 ;\
    STA.l DZ_PPUMirrors_VRAM_Transfer_Source,x       ;|MAPResourceOffset of first transfer = Addr of first transfer
    CLC                         ;|
    ADC Sizes,y                 ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_Source+$02,x   ;/MAPResourceOffset of second transfer = Addr of second transfer
    
    LDY $0003|!dp               ;\
    LDA Sizes,y                 ;|MAPLength = Size of second transfer
    STA.l DZ_PPUMirrors_VRAM_Transfer_SourceLength+$02,x     ;/

    LDY $0002|!dp
    LDA Sizes,y                 ;\
    CLC                         ;|;|MAPVRAMOffset of second transfer = Starting VRAM Offset + Vram Offset of second transfer
    ADC.l DZ_DS_StartingVRAMOffset   ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_Offset+$02,x ;/

    SEP #$20

    PLB
    PLX
RTL

.moreThanOneLine
    LDA.l DZ_PPUMirrors_VRAM_Transfer_Length   ;\
    INC A                       ;|
    ASL                         ;|X = last Transfer Slot
    TAX                         ;/

    LDA !drSize                 ;\!Scratch4 = Last position on the vram
    STA !Scratch4               ;/

    LDA !Scratch0           ;\
    SEC                     ;|!Scratch1 = size to transfer on the first and second transfer
    SBC !drVRAMOffset       ;|
    STA !Scratch1           ;/

    STZ !ScratchE
    LDA !Scratch1
    STA !ScratchF

    LDA !Scratch0
    CLC
    ADC #$10
    STA !Scratch0

    LDA #$10                ;\
    SEC                     ;|!Scratch3 = size to transfer on the third and fourth transfer
    SBC !Scratch1           ;|
    STA !Scratch3           ;/

    LDA !drVRAMOffset       ;\
    STA !Scratch2           ;/!Scratch2 = offset of first transfer

-
    LDA !ScratchF           ;\
    CMP !Scratch4           ;|Check if must do third transfer
    BCC +                   ;|
    JMP .StartFromFirstLine ;/if not then skip third and fourth transfer
+
    CLC                     ;\
    ADC #$10                ;|Check if must do fourth transfer
    CMP !Scratch4           ;|
    BCC +                   ;/

    LDA !ScratchF           ;\
    CLC                     ;|
    ADC !Scratch3           ;|check if offset + size of third transfer is more than last position then recalculate size
    CMP !Scratch4           ;|otherwise keep same size, then skip fourth transfer
    BCC ++                  ;/
    STA !Scratch7

    LDA !Scratch4
    SEC
    SBC !ScratchF
    BRA .skipLastLine
++
    LDA !Scratch3
    BRA .skipLastLine
+
    STA !Scratch5
    LDA !Scratch0 
    CLC
    ADC #$10
    STA !Scratch7

    LDA !Scratch5           ;\
    CLC                     ;|
    ADC !Scratch3           ;|check if offset + size of fourth transfer is more than last position then recalculate size
    CMP !Scratch4           ;|otherwise keep same size
    BCC .noLast             ;/
    BEQ .noLast
    LDA !Scratch4
    SEC
    SBC !Scratch5
    BRA +
.noLast
    LDA !Scratch3
+
    CLC
    ASL
    STA !Scratch6

    LDA !ScratchF
    CLC
    ADC #$10
    STA !ScratchC

    %Transfer($0007|!dp, $0006|!dp, $000C|!dp) ;fourth transfer

    INX
    INX

    LDA !Scratch3

.skipLastLine
    CLC
    ASL
    STA !Scratch6

    %Transfer($0000|!dp, $0006|!dp, $000F|!dp) ;third transfer

    INX
    INX

    LDA !Scratch1 
    CLC
    ASL
    STA !Scratch6

    LDA !ScratchE
    CLC
    ADC #$10
    STA !ScratchC

    CMP !Scratch4
    BCS +

    LDA !Scratch2
    CLC
    ADC #$10
    STA !Scratch5

    %Transfer($0005|!dp, $0006|!dp, $000C|!dp) ;second transfer

    INX
    INX

+

    %Transfer($0002|!dp, $0006|!dp, $000E|!dp) ;first transfer

    LDA !Scratch2       ;|
    CLC                 ;|
    ADC #$20            ;|
    STA !Scratch2       ;|Update third line offset
                        ;|
    LDA !Scratch0       ;|
    CLC                 ;|
    ADC #$20            ;|
    STA !Scratch0       ;/Update first line offset

    LDA !ScratchE
    CLC
    ADC #$20
    STA !ScratchE

    LDA !ScratchF
    CLC
    ADC #$20
    STA !ScratchF

    INX
    INX

    JMP -               ;Go to next transfer

.StartFromFirstLine

    LDA !ScratchE       ;\
    CMP !Scratch4       ;|Check if must do more transfer
    BCC +               ;/

    DEX                         ;\
    DEX                         ;|
    TXA                         ;|Updates number of transfers
    LSR                         ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_Length   ;/

    PLB
    PLX
RTL

+
    CLC                 ;\
    ADC #$10            ;|Check if must do second transfer
    CMP !Scratch4       ;|
    BCC +               ;/

    LDA !ScratchE           ;\
    CLC                     ;|
    ADC !Scratch1           ;|check if offset + size of first transfer is more than last position then recalculate size
    CMP !Scratch4           ;|otherwise keep same size, then skip second transfer
    BCC ++                  ;/
    STA !Scratch7
    LDA !Scratch4
    SEC
    SBC !ScratchE
    BRA .skipSecondLine
++
    LDA !Scratch1
    BRA .skipSecondLine
+
    STA !Scratch5

    LDA !Scratch2
    CLC
    ADC #$10
    STA !Scratch7

    LDA !Scratch5           ;\
    CLC                     ;|
    ADC !Scratch1           ;|check if offset + size of second transfer is more than last position then recalculate size
    CMP !Scratch4           ;|otherwise keep same size
    BCC .noThird            ;/
    BEQ .noThird
    LDA !Scratch4
    SEC
    SBC !Scratch5
    BRA +
.noThird
    LDA !Scratch1
+
    CLC
    ASL
    STA !Scratch6

    LDA !ScratchE
    CLC
    ADC #$10
    STA !ScratchC
    
    %Transfer($0005|!dp, $0006|!dp, $000C|!dp) ;second transfer

    INX
    INX

    LDA !Scratch1

.skipSecondLine
    CLC
    ASL
    STA !Scratch6

    %Transfer($0002|!dp, $0006|!dp, $000E|!dp) ;first transfer

    TXA                         ;|Updates number of transfers
    LSR                         ;|
    STA.l DZ_PPUMirrors_VRAM_Transfer_Length   ;/

    PLB
    PLX
RTL

;###############################################################################################################

CheckEvenOrOdd:
    PHX
	TAX
	LDA.l DZ_DS_Loc_FrameRateMethod,x
	DEC A
	STA !Scratch0

    PLX

	LDA.l DZ_Timer					;\
	AND #$01						;|if frame rate method is == dynamicTimer%2
	CMP !Scratch0					;|
RTL

;###############################################################################################################

VramDisp:
    db $00,$02,$04,$06,$08,$0A,$0C,$0E
    db $20,$22,$24,$26,$28,$2A,$2C,$2E
    db $40,$42,$44,$46,$48,$4A,$4C,$4E
    db $60,$62,$64,$66,$68,$6A,$6C,$6E
    db $80,$82,$84,$86,$88,$8A,$8C,$8E
    db $A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
    db $C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
    db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE

GetVramDisp:
    PHX
    TAX
    LDA DZ_DS_Loc_SpaceUsedOffset,x
    TAX
    LDA.l VramDisp,x
    CLC
    ADC DZ_DS_StartingVRAMOffset8x8Tiles
    PLX
RTL

GetVramDispDynamicRoutine:
    PHX
    TAX
    LDA DZ_DS_Loc_SpaceUsedOffset,x
    TAX
    LDA.l VramDisp,x
    PLX
RTL

;###############################################################################################################

!Return = $07,s
!Tile = $07,s
!Offset = $06,s
!Threshold = $01,s

RemapOamTile:
    AND #$0F
    PHA
    
    LDA #$10
    SEC
    SBC $01,s
    PHA

    LDA !Tile
    CMP !Threshold
    BCC +

    AND #$0F
    CMP !Threshold
    BCS ++
    LDA !Tile
    BRA +
++
    LDA !Tile
    CLC
    ADC !Offset
    CLC
    ADC #$10
    STA !Return
    PLA
    PLA 
RTL
+
    CLC
    ADC !Offset
    STA !Return
    PLA
    PLA
RTL

;###############################################################################################################

macro CheckSharedDynamicExisted(type)
if <type> == $00
    LDA !SpriteNumberNormal,x
elseif <type> == $20
    LDA !ClusterSpriteNumber,x
elseif <type> == $40
    LDA !ExtendedSpriteNumber,x
else
    LDA !OWSpriteNumber,x
endif
    PHA
    LDA #<type>|$80
    PHA
    JSR CheckSharedDynamicExisted
    BCS ?+
    PLA
    PLA
    CLC
RTL
?+
if <type> == $00
    STA.l DZ_DS_Loc_US_Normal,x
elseif <type> == $20
    STA.l DZ_DS_Loc_US_Cluster,x
elseif <type> == $40
    STA.l DZ_DS_Loc_US_Extended,x
else
    STA.l DZ_DS_Loc_US_OW,x
endif
    PLA
    PLA
    SEC
RTL
endmacro

CheckNormalSharedDynamicExisted:
    %CheckSharedDynamicExisted($00)

CheckClusterSharedDynamicExisted:
    %CheckSharedDynamicExisted($20)

CheckExtendedSharedDynamicExisted:
    %CheckSharedDynamicExisted($40)

CheckOWSharedDynamicExisted:
    %CheckSharedDynamicExisted($60)

!spnum = $05,s
!typ = $04,s
CheckSharedDynamicExisted:

    LDA.l DZ_DS_FirstSlot
    BPL +
    CLC
RTS
+
    PHX
    TAX
-
    LDA.l DZ_DS_Loc_UsedBy,x
    AND #$E0
    CMP !typ
    BNE +

    LDA.l DZ_DS_Loc_SpriteNumber,x
    CMP !spnum
    BNE +

    TXA
    PLX
    SEC
RTS
+
    LDA.l DZ_DS_Loc_NextSlot,x
    TAX
    BPL -

    PLX
    CLC
RTS

;###############################################################################################################

macro CheckIfLastSharedProcessed(type)
if <type> == $00
    LDA !SpriteNumberNormal,x
elseif <type> == $20
    LDA !ClusterSpriteNumber,x
elseif <type> == $40
    LDA !ExtendedSpriteNumber,x
else
    LDA !OWSpriteNumber,x
endif
    STA !Scratch0
    LDA #<type>|$80
    STA !Scratch1

    PHX
    DEX
?-
if <type> == $00
    LDA !SpriteNumberNormal,x
elseif <type> == $20
    LDA !ClusterSpriteNumber,x
elseif <type> == $40
    LDA !ExtendedSpriteNumber,x
else
    LDA !OWSpriteNumber,x
endif
    CMP !Scratch0
    BNE ?+

    PHX
if <type> == $00
    LDA.l DZ_DS_Loc_US_Normal,x
elseif <type> == $20
    LDA.l DZ_DS_Loc_US_Cluster,x
elseif <type> == $40
    LDA.l DZ_DS_Loc_US_Extended,x
else
    LDA.l DZ_DS_Loc_US_OW,x
endif
    TAX
    LDA.l DZ_DS_Loc_UsedBy,x
    PLX
    AND #$E0
    CMP !Scratch1
    BNE ?+
    
    PLX
RTL
?+
    DEX
    BPL ?-
    PLX

    PHX
if <type> == $00
    LDA.l DZ_DS_Loc_US_Normal,x
elseif <type> == $20
    LDA.l DZ_DS_Loc_US_Cluster,x
elseif <type> == $40
    LDA.l DZ_DS_Loc_US_Extended,x
else
    LDA.l DZ_DS_Loc_US_OW,x
endif
    TAX
    LDA #$00
    STA.l DZ_DS_Loc_SharedUpdated,x
    PLX
RTL

endmacro

CheckIfLastNormalSharedProcessed:  
    LDA !SpriteNumberNormal,x
    STA !Scratch0
    LDA #$80
    STA !Scratch1

    PHX
    DEX
-
    LDA !SpriteNumberNormal,x
    CMP !Scratch0
    BNE +

    LDA !SpriteStatus,x
    BEQ +

    LDA.l DZ_DS_Loc_US_Normal,x
    CMP #$30
    BCS +
    PHX
    TAX
    LDA.l DZ_DS_Loc_UsedBy,x
    PLX
    AND #$E0
    CMP !Scratch1
    BNE +
    
    PLX
RTL
+
    DEX
    BPL -
    PLX

    PHX
    LDA.l DZ_DS_Loc_US_Normal,x
    TAX
    LDA #$00
    STA.l DZ_DS_Loc_SharedUpdated,x
    PLX
RTL

CheckIfLastClusterSharedProcessed:
    %CheckIfLastSharedProcessed($20)

CheckIfLastExtendedSharedProcessed:
    %CheckIfLastSharedProcessed($40)

CheckIfLastOWSharedProcessed:
    %CheckIfLastSharedProcessed($60)