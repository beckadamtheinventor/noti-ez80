;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;	FILE	".\strncmp.asm"
;	.ASSUME ADL=1
;	SEGMENT code
;   int strncmp(char *s1,char *s2,size_t n)
_strncmp:
	ld		iy,	0
	add		iy,	sp

	ld		bc, (iy+9)
	ld		a,	(iy+11)
	or		a,	c
	or		a,	b
	jr		z,	.done		; n==0 ? return(0)

	ld		hl,	(iy+6)
	ld		de,	(iy+3)

.cloop:
	ld		a,	(de)
	cpi
	jr		nz,	.diff		; return the difference value if mismatch occurs
	jp		po, .done		; if all the chars over then return(0)
	or		a,	a
	jr		z,	.done		; if *s1=='\0'	return(0)
	inc		de
	jr		.cloop

.diff:
	dec		hl
	sub		a, (hl)
	ld		b,	a
	rla
	sbc		hl,	hl
	ld		l,	b
	ret

.done:
	or		a,	a
	sbc		hl,	hl
	ret


;	XDEF _strncmp
;	END

