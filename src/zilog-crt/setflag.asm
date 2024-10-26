;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Set Sign flag for signed comparison
;	s <-- s xor v
; Input:
;	Operand1: f register
;
; Output:
;	Result:  updated f register
;
; Registers Used:
;	None
;-------------------------------------------------------------------------
;	if ( V == 0)
;		S = S xor 0 -> S = S
;	if ( V != 0)
;		S = S xor V
 
;	.def	__setflag
;	.assume adl=1

_setflag:

	push	bc

	push	af
	pop	bc		; c <- flags

	bit	2,c		; if (v == 1)
	jr	z,.done		; else go to .done
	ld	a,c		; c <- c xor %80
	xor	a,$80
	ld	c,a

.done:
	push 	bc
	pop	af		; flags <- c
	pop	bc
	ret	

