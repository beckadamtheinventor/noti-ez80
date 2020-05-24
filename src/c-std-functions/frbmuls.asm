;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract short Multiplication signed.
;
; Input:
;	Operand1: 
;		  H : 8 bits
;
;	Operand2: 
;		  L : 8 bits
;
; Output:
;	Result:   A : 8 bits
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frbmuls

_frbmuls:
	push	hl
	;;
	;; Check sign info
	;;
	xor	a,a
	rl	h
	jr	nc,.L0
	sub	a,h
	ld	h,a
.L0:
	xor	a,a
	rl	l
	jr	nc,.L1
	sub	a,l
	ld	l,a
.L1:
	mlt	hl
	ld	a,h
	pop	hl
	or	a,a
	rra
	adc	a,0h
	push	af
	ld	a,h
	xor	a,l
	jp	p,.L2
	pop	af
	neg
	ret
.L2:
	pop	af
	ret

