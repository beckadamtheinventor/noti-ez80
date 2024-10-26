;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; float to fract unsigned char conversion.
;
; Input:
;	Operand1: 
;		  eHL : 32 bits
;
; Output:
;	Result:   A : 8 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frftoub

_frftoub:
	push	hl
	ld	a,e
	add	hl,hl
	rla
	cp	a,77h	;underflow
	jr	c,.L0
	cp	a,96h	;overflow
	jr	c,.L1
.L0:
	xor	a,a
	pop	hl
	ret
.L1:
	sub	a,7fh
	jr	nz,.L2
.L7:
	push	hl
	ld	hl,1
	add	hl,sp
	rl	(hl)
	inc	hl
	ld	a,(hl)
	adc	a,0h
	inc	hl
	ld	sp,hl
	pop	hl
	ret
.L2:
	push	bc
	jr	c,.L4
	ld	b,a
.L3:
	add	hl,hl
	djnz	.L3
	pop	bc
	jr	.L7
.L4:
	ld	hl,5
	add	hl,sp
	neg
	ld	b,a
	ld	a,(hl)
	or	a,a
	rla
	scf
	jr	.L6
.L5:
	or	a,a
.L6:
	rra
	djnz	.L5
	adc	a,0h
	pop	bc
	pop	hl
	ret
