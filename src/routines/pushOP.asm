
repeat 6
_pushOP#%:
	ld hl,11
	call _heapAlloc
	ex hl,de
	ld hl,ti.OP#%
	jq _mov11b
end repeat
