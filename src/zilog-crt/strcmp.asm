;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;	FILE	".\strcmp.asm"
;	.assume ADL=1
;	SEGMENT code

;   int strcmp(register char *s1, register char *s2)
_strcmp:
	ld		hl,	3
	add		hl,	sp
	ld		de,	(hl)
	inc		hl
	inc		hl
	inc		hl
	ld		hl,	(hl)

.loop:
	ld		a,	(de)
	or		a,	a
	jr		z,	.done
	cpi
	inc		de
	jr		z,	.loop

	dec		hl
.done:
	sub		a,	(hl)

	ld		b,	a
	rla
	sbc		hl,	hl
	ld		l,	b
	ret

	
;	XDEF _strcmp
;	END

