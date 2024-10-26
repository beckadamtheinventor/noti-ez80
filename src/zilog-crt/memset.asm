
; void *memset(void *dest, int c, int count);
_memset:
	ld	iy,0
	add	iy,sp
	ld	de,(iy+3)	;dest
	ld	hl,(iy+9)	;count
	ld	a,(iy+6)	;c
	ld	bc,0
	or a,a
	sbc	hl,bc
	jr z,.exit
	ld (de),a
	inc bc
	or a,a
	sbc hl,bc
	jr z,.exit
	push hl
	pop bc
	push de
	inc de
	pop hl
	ldir
.exit:
	ld	hl,(iy+3)	;dest
	ret

