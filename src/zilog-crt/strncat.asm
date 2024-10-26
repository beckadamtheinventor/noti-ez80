;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;	FILE	".\strncat.asm"
;	.assume ADL=1
;	SEGMENT code
;   char *strncat(char *s1,char *s2,size_t n)
_strncat:
	ld		iy,	0
	add		iy,	sp

	ld		hl,	(iy+3)
	xor		a,	a
.loop1:
	cpi
	jr		nz,	.loop1
	dec		hl				;hl = s1+strlen(s1)

	ld		bc,	(iy+9)		;bc = n
	ld		a,	(iy+11)
	or		a,	c
	or		a,	b
	jr		z,	.done		;n==0 ? return(s1)

	ld		de,	(iy+6)
	ex		de,	hl			;hl=s2 | de = s1+strlen(s1)
	xor		a,	a
.loop2:
	cp		a,	(hl)
	jr		z,	.fillzero
	ldi
	jp		pe,	.loop2

.fillzero:
	ld		(de),	a
.done:
	ld		hl,	(iy+3)
	ret

;	XDEF _strncat
;	END
