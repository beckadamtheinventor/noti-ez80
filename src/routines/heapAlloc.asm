
_heapAlloc:
	ld de,(curHeapPtr)
	add hl,de
	ld (curHeapPtr),hl
	ex hl,de
	ret

