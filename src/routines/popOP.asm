
repeat 6
_popOP#%:
	ld bc,-11
	ld hl,(curHeapPtr)
	add hl,bc
	ld de,$D005F8+(%*11)
	jq _mov11b
end repeat
