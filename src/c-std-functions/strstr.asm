;Edited for use with open-ce
; Copyright (C) 1999-2008 Zilog, Inc, All Rights Reserved
;-------------------------------------------------------------------------
; <string.h>
; char * strstr(char *s1, char *s2);
;-------------------------------------------------------------------------
;	.assume ADL=1
;	SEGMENT code
;	XDEF _strstr
_strstr:
	ld 	hl, 6
	add hl, sp
	ld	iy, (hl)	; bc = s2
	dec hl
	dec hl
	dec hl
	ld  de, (hl)	; de = s1
.L0:
	xor	a,a
	sbc	hl,hl
	add	hl,de
	cp	a,(hl)
	jr	z,.L3		; *s1 == '\0'
	ld	bc,iy
	inc	de
.L1:
	ld	a,(bc)
	or	a,a
	jr	z,.L2		; *s2 == '\0'
	cp	a,(hl)		; *s1 == *s2
	inc hl			; s1 ++
	inc bc			; s2 ++
	jr	z,.L1
	jr	.L0
.L2:
	ex	de,hl
	dec hl
	ret
.L3:
	sbc	hl,hl
	ret

;	END

