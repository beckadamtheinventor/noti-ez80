;Edited for use with open-ce
; (c) Copyright 2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract unsigned integer to float conversion.
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
;	.def	__fruitof

_fruitof:
	push	de
	ld	de,0h
	or	a,a
	sbc	hl,de
	pop	de
	jr	nz,.L0
	ld	e,0h
	ret
.L0:
	ld	e,7fh
.L1:
	dec	e
	add	hl,hl
	jr	nc,.L1
	push	hl
	ld	hl,2
	add	hl,sp
	sra	e
	rr	(hl)
	pop	hl
	rr	h
	rr	l
	ret

