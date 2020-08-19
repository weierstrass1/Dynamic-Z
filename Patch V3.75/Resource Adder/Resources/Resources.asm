
macro insert_resource(file, label)
pushpc
freedata cleaned
<label>
    incbin <file>
pullpc
endmacro


freedata cleaned
Resource0:
    prot .RSRC0
    dl Resource0_RSRC0
    dl $FFFFFF

    %insert_resource(Klaptrap.bin, .RSRC0)


freedata cleaned
Resource1:
    prot .RSRC0
    dl Resource1_RSRC0
    dl $FFFFFF

    %insert_resource(Klump.bin, .RSRC0)

freedata cleaned
Resource2:
    prot .RSRC0
    dl Resource2_RSRC0
    dl $FFFFFF

    %insert_resource(Butterfly.bin, .RSRC0)