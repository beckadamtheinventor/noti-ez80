; Copyright (C) 1999-2008 Zilog, Inc, All Rights Reserved
;-------------------------------------------------------------------------
; <memory.h> <string.h>
; void *memset( void *dest, int c, size_t count );
;-------------------------------------------------------------------------
	.assume ADL=1
	XDEF _memset
_memset:
	ld	iy,0
	add	iy,sp
	ld	de,(iy+3)	;dest
	ld	hl,(iy+9)	;count
	ld	a,(iy+6)	;c
	ld	bc,0
	jr	_L0
_Loop:
	ld	(de),a
	inc	de
	dec	hl
_L0:
	sbc	hl,bc
	jr	nz,_Loop
	ld	hl,(iy+3)	;dest
	ret

	END

