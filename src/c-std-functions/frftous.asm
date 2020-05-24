;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; float to fract unsigned short conversion.
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
;	.def	__frftous

_frftous:
	push	af
	ld	a,e
	add	hl,hl
	rla
	dec	sp
	push	hl
	inc	sp
	pop	hl
	cp	a,6Fh	;underflow
	jr	c,.L0
	cp	a,96h	;overflow
	jr	c,.L2
.L0:
	or	a,a
	sbc	hl,hl
.L1:
	pop	af
	ret
.L2:
	sub	a,7fh
	jr	z,.L1
	push	bc
	jr	c,.L4
	ld	b,a
.L3:
	add	hl,hl
	djnz	.L3
	jr	.L6
.L4:
	neg
	ld	b,a
.L5:
	rr	h
	rr	l
	or	a,a
	djnz	.L5
.L6:
	pop	bc
	pop	af
	ret
