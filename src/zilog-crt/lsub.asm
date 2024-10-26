;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long Subtract Op1 - Op2
; Input:
;	Operand1: 
;                 EHL : 32 bits
;		  
;	Operand2: 
;                 ABC : 32 bits
;
; Output:
;	Result:   EHL :	 32 bits
; Registers Used:
;	flags
;-------------------------------------------------------------------------
;	.assume adl=1
;        .def    __lsub

_lsub:
		or		a,	a
		sbc		hl,	bc		;SUB	HL, BC
		push	bc
		ld		c,	a
		ld		a,	e
		ld		e,	c
		sbc		a,	e
		ld		e,	a		;SBC	E, A
		ld		a,	c
		pop		bc

		ret

