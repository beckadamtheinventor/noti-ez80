;Edited for use with open-ce
; (c) Copyright 1999-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long Modulus Unsigned.
; Input:
;	Operand1: 
;		  EuHL : 32 bits (dividend x)
;
;	Operand2: 
;		  AuBC : 32 bits (divisor y)
;
; Output:
;	Result:   EuHL : 32 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__lremu
;	.ref	__ldvrmu

_lremu:
	push	ix
	push	iy
	call	_ldvrmu
	ld	e,a
	ld	a,iyh
	pop	iy
	pop	ix
	ret

