
_memclear:
	pop de,bc
	push bc,de,de
	pop hl
	xor a,a
	ld (hl),a
	inc de
	ldir
	ret
