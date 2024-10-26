;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;	FILE	".\strcspn.asm"
;	.assume ADL=1
;	SEGMENT code

;   size_t strcspn(char *s1, char *s2)
_strcspn:
	ld		hl,	6
	add		hl,	sp
	ld		de,	(hl)		;de = s2
	dec		hl
	dec		hl
	dec		hl
	ld		hl,	(hl)		;hl = s1

.loop1:
	push	hl				;store s1
.loop2:
	ld		a,	(de)
	or		a,	a
	jr		z,	.done		;if *s2==0 then done
	cpi
	jr		z,	.done		;if the match found then done
	xor		a,	a
	cp		a,	(hl)
	jr		nz,	.loop2		;if *s1!=0 then continue
	inc		de				;else ++s2
	ld		a,	(de)
	or		a,	a
	jr		z,	.inchl		;if *s2==0 then done
	pop		hl
	jr		.loop1

.inchl:
	inc		hl
.done:
	pop		de				;restore s1
	scf
	sbc		hl,	de			;return index
	ret


;	XREF _strlen:ROM
;	XDEF _strcspn
;	END

