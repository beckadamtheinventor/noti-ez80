;Edited for use with open-ce
; Copyright (C) 1999-2008 Zilog, Inc, All Rights Reserved
;-------------------------------------------------------------------------
; <string.h>
; void *memmove( void *dest, const void *src, size_t count );
;-------------------------------------------------------------------------
;	.assume ADL=1
;	XDEF _memmove
_memmove:
	ld	iy,0
	add	iy,sp
	ld	bc,(iy+9)	;count
	sbc	hl,hl
	sbc	hl,bc	;count==0?
	jr	z,_L1
	ld	hl,(iy+6)	;src
	ld	de,(iy+3)	;dest
	or	a,a
	sbc	hl,de
	ld	hl,(iy+6)	;src
	jr	c,.L0	;src < dest?
	ldir
	jr	.L1
.L0:
	add	hl,bc
	dec	hl
	ex	de,hl
	add	hl,bc
	dec	hl
	ex	de,hl
	lddr
.L1:
	ld	hl,(iy+3)	;dest
	ret

;	END
