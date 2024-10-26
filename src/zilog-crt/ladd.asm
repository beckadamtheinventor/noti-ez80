;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long ADD.
; Input:
;	Operand1: 
;                 ehl : 32 bit
;
;	Operand2: 
;                 abc : 32 bit
;
; Output:
;	Result:   ehl : 32 bit
; Registers Used:

;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__ladd, __ladd_b

_ladd_b:
	push bc
	ld bc,0
	ld c,a
	ld a,0
	call _ladd
	ld a,c
	pop bc
	ret
	

_ladd:
		push	af
		add		hl, bc		;ADD HL, BC
		adc		a,	e
		ld		e,	a		;ADC E, A
		pop		af
		ret
