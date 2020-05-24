
;   char *strncpy(char *dst,char *src,size_t n)
_strncpy:
	ld iy,0
	add iy,sp
	ld hl,(iy+3)
	push hl
	call _strlen
	pop bc
	ld bc,(iy)
	add hl,bc
	or a,a
	sbc hl,bc
	jr nc,.copy
	push hl
	pop bc
.copy:
	ld hl,(iy+3)
	ld de,(iy)
	push de
	ldir
	xor a,a
	ld (de),a
	pop hl
	ret
