macro insert_resource(file, label)
pushpc
freedata cleaned
<label>
    incbin "<file>"
pullpc
print "Resource <file>", ": Inserted At $", hex(<label>)
endmacro