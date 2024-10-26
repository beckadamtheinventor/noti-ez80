;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Set flag for comparison of 32-bit scalar with constant value zero
; Input:
;	Operand1: E:HL register
;
; Output:
;	Result:  f register
;
; Registers Used:
;	None
;-------------------------------------------------------------------------
 
;	.def	__lcmpzero
;	.ref	__lcmpu
;	.assume adl=1

_lcmpzero:
	push	iy
	push	bc
	
	ld		iyh,a
	xor		a,a
	ld		bc,0
	call	_lcmpu
	ld		a,iyh
	
	pop		bc
	pop		iy
	ret
