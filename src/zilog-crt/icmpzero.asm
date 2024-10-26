;Edited for use with open-ce
; (c) Copyright 2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Set flag for comparison of 24-bit scalar with constant value zero
; Input:
;	Operand1: HL register
;
; Output:
;	Result:  f register
;
; Registers Used:
;	None
;-------------------------------------------------------------------------
 
;	.def	__icmpzero
;	.assume adl=1

_icmpzero:
	push hl
	push de

	ld de,0
	or a,a
	sbc hl,de

	pop de	
	pop hl
	ret
