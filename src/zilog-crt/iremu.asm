;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Unsigned Integer Modulus
; Input:
;	Operand1: 
;		  uHL : 24 bits (dividend x)
; 
;	Operand2: 
;		  uBC :	 24 bits (divisor y)
;
; Output:
;	Result:   uHL : 24 bits (remainder)
;
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;        .def    __iremu
;	.ref	__idvrmu

_iremu:
	push	af
	push	de
	call	_idvrmu
	pop	de
	pop	af
	ret

