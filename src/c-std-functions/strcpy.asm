
;   char * strcpy(void * d, void * s)
_strcpy:
	pop iy
	call _strlen
	push hl  ;ld bc,hl
	pop bc
	pop hl   ;void *s
	pop de   ;void *d
	push de
	push hl
	push de
	ldir
	pop hl
	push iy
	ret
