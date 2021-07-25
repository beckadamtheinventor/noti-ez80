
;   char *strncpy(char *dst,char *src,size_t n)
_strncpy:
	ld iy,0
	add iy,sp
	ld de,(iy+3)
	ld hl,(iy+6)
	ld bc,(iy+9)
	push de
.loop:
	ld a,(hl)
	or a,a
	jq z,.pad
	ldi
	jp pe,.loop
	pop hl
	ret
.pad:
	ldi
	dec hl
	jp pe,.pad
	pop hl
	ret
