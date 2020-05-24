;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long Division Signed
; Input:
;	Operand1: 
;		  eHL : 32 bits
; 
;	Operand2: 
;		  aBC :	 32 bits
; Output:
;	Result:   eHL : 24 bits
;
; Registers Used:
;	
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__ldivs
;	.ref	__ldivu, __lneg
_ldivs:
	push	bc
	push	af
	push	de
	bit	7,a
	jr	z,.L1
	push	hl
	or	a,a		; CR 7885
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
	call	_ldivu
	pop	bc
	pop	af
	ld	b,a
	xor	a,c
	jp	p,.L3
	call	_lneg
.L3:
	ld	a,b
	pop	bc
	ret

