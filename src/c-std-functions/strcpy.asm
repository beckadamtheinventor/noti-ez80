
;   char * strcpy(void * d, void * s)
_strcpy:
	pop hl
	pop bc
	push bc
	push hl
	push bc
	call _strlen
	ex (sp),hl
	pop bc
	pop hl   ;void *s
	pop de   ;void *d
	push de
	push hl
	push de
	ldir
	pop hl
	ret
