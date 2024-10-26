;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; float to fract unsigned integer conversion.
;
; Input:
;	Operand1: 
;		  eHL : 32 bits
;
; Output:
;	Result:   HL : 24 bits
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frftoui

_frftoui:
	push	af
	ld	a,e
	add	hl,hl
	rla
	cp	a,67h	;underflow
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
	push	hl
	ld	hl,2
	add	hl,sp
	neg
	ld	b,a
	ld	a,(hl)
	pop	hl
.L5:
	rra
	rr	h
	rr	l
	or	a,a
	djnz	.L5
	push	hl
	ld	hl,2
	add	hl,sp
	ld	(hl),a
	pop	hl
.L6:
	pop	bc
	pop	af
	ret


