
repeat 6
_popOP#%:
	ld bc,-11
	ld hl,(curHeapPtr)
	add hl,bc
	ld de,ti.OP#%
	jq _mov11b
end repeat
