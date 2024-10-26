;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract integer to float conversion.
;
; Input:
;	Operand1: 
;		  HL : 24 bits
;
; Output:
;	Result:   eHL : 32 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__fritof
;	.ref	__fruitof

_fritof:
	push	de
	ex	de,hl
	ld	hl,$800000
	or	a,a
	sbc	hl,de
	jr	c,.L0
	ex	de,hl
.L0:
	jr	nz,.L1
	pop	de
	ld	e,$BF
	ret
.L1:
	add	hl,hl
	call	_fruitof
	ex	de,hl
	add	hl,hl
	ex	de,hl
	rr	e
	ex	(sp),hl
	ex	de,hl
	ld	e,l
	pop	hl
	ret

