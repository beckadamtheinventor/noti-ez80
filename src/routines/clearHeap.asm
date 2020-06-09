
_clearHeap:
	ld hl,baseHeap
	ld (curHeapPtr),hl
	ret
