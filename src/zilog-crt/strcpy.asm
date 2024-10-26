
;   char * strcpy(void * d, void * s)
_strcpy:
	pop bc,de
	ex (sp),hl
	push de,bc
.loop:
	ld a,(hl)
	ldi
	or a,a
	jq nz,.loop
	ret
