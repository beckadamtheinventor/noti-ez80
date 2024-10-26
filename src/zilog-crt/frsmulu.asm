;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract interger Multiplication Unsigned.
;
; Input:
;	Operand1: 
;		  HL : 16 bits
;
;	Operand2: 
;		  BC : 16 bits
;
; Output:
;	Result:   HL : 16 bits
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frsmulu

_frsmulu:
	push	af
	push	de
	push	bc
	ld	d,l
	ld	e,c
	mlt	de
	ld	a,d
	ld	d,h
	ld	e,b
	ld	b,h
	ld	h,e
	mlt	hl
	mlt	bc
	mlt	de
	add	a,c
	jr	nc,.L0
	inc	de
.L0:
	ld	c,a
	xor	a,a
	add	hl,bc
	adc	a,d
	ld	d,a
	ld	l,h
	ld	h,0h
	ex	de,hl
	add	hl,de
	pop	bc
	pop	de
	pop	af
	ret

