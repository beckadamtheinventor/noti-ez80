;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; float to fract short conversion.
;
; Input:
;	Operand1: 
;		  eHL : 32 bits
;
; Output:
;	Result:   HL : 16 bits
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frftos
;	.ref	__frftous

_frftos:
	call	_frftous
	srl	h
	rr	l
	push	de
	rl	e
	jr	nc,.L0
	ex	de,hl
	or	a,a
	sbc	hl,hl
	sbc	hl,de
.L0:
	pop	de
	ret

