
;   char * strcpy(void * d, void * s)
_strcpy:
	call _frameset0
	ld bc,(ix+6)   ;void *s
	push bc
	call _strlen
	push hl
	pop bc
	ld hl,(ix+6)   ;void *s
	ld de,(ix+3)   ;void *d
	push de
	ldir
	pop hl
	ld sp,ix
	pop ix
	ret
