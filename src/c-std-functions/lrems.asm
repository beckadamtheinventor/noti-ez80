;Edited for use with open-ce
; (c) Copyright 1999-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long Modulus Signed.
; Input:
;	Operand1: 
;		  EHL : 32 bits (dividend)
;
;	Operand2: 
;		  ABC : 32 bits (divisor)
;
; Output:
;	Result:   EHL : 32 bit
; Registers Used:
;	de,af
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__lrems
;	.ref	__lremu, __lneg
_lrems:
	push	af
	push	bc
	push	de

	bit	7,a
	jr	z,.L1
	push	hl
	sbc	hl,hl
	sbc	hl,bc
	adc	a,0
	neg
	push	hl
	pop	bc
	pop	hl
.L1:
	bit	7,e
	jr	z,.L2
	call	_lneg
.L2:
	call	_lremu
	pop	bc
	bit	7,c
	jr	z,.L3
	call	_lneg
.L3:
	pop	bc
	pop	af
	ret

