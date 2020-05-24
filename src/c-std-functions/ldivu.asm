;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long Division Unsigned
; Input:
;	Operand1: 
;		  EuHL : 32 bits
; 
;	Operand2: 
;		  AuBC : 32 bits
; Output:
;	Result:   EuHL : 32 bits
;
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__ldivu,__ldvrmu

_ldivu:
	push	ix
	push	iy
	call	_ldvrmu
	ld	a,iyh
	push	ix
	pop	hl
	pop	iy
	pop	ix
	ret

; Input:
;	EuHL = dividend
;	AuBC = divisor
; Output:
;	EuIX = quotient
;	AuHL = remainder
_ldvrmu:
	push	hl
	pop	ix
	ld	iyh,a
	ld	iyl,32
	xor	a,a
	sbc	hl,hl
.loop:
	add	ix,ix		;shift AuHLEuIX left
	rl	e
	adc	hl,hl
	rla
	sbc	hl,bc
	sbc	a,iyh
	jr	nc,.L1
	add	hl,bc
	adc	a,iyh
	jr	.L2
.L1:
	inc	ix
.L2:
	dec	iyl
	jr	nz,.loop
	ret


