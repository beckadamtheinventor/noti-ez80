
_print4h:
	cp a,10
	jr nc,.putA
	add a,$30
	jr .put
.putA:
	add a,$41-10
.put:
	jp _boot_PutC
	
	
