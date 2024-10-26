;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long NOT.
; Input:
;	Operand1: 
;		  eHL : 32 bit
;
; Output:
;	Result:   eHL : 32 bit
; Registers Used:
;	None
;-------------------------------------------------------------------------
;	.assume adl=1
	 
;    .def    __lnot
;	.ref	__inot

_lnot:
	call	_inot	;CPL HL
	push	af
	ld		a,	e
	cpl				
	ld		e,	a	;CPL E
	pop		af

	ret	
