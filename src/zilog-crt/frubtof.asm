;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract unsigned char to float conversion.
;
; Input:
;	Operand1: 
;		  A : 8 bits
;
; Output:
;	Result:   eHL : 32 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frubtof

_frubtof:
	or	a,a
	jr	nz,.L0
	sbc	hl,hl
	ld	e,a
	ret
.L0:
	ld	l,a
	ld	e,7fh
.L1:
	dec	e
	add	a,a
	jr	nc,.L1
	sra	e
	rra
	push	af
	dec	sp
	ld	a,l
	pop	hl
	inc	sp
	sbc.s	hl,hl
	ret

