;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Signed Byte Multiply
; Input:
;	Operand1: 
;                 A : 8 bit 
;
;	Operand2: 
;                 B : 8 bit 
;
; Output:
;	Result:   A : 8 bit product
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.def	__bmuls
;	.assume adl=1

_bmuls:
	push	bc
        ld      c,a
	mlt	bc
	ld	a,c
	pop	bc
	ret
