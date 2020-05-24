;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; float to fract integer conversion.
;
; Input:
;	Operand1: 
;		  eHL : 32 bits
;
; Output:
;	Result:   HL : 24 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frftoi
;	.ref	__frftoui

_frftoi:
	call	_frftoui
	push	hl
	ld	hl,2
	add	hl,sp
	srl	(hl)
	pop	hl
	rr	h
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

