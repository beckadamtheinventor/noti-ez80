;Edited for use with open-ce
; (c) Copyright 1999-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Integer Modulus Signed.
; Input:
;	Operand1: 
;		  HL : 24 bits (dividend)
;
;	Operand2: 
;		  BC : 24 bits (divisor)
;
; Output:
;	Result:   HL : 24 bit
; Registers Used:
;	de,af
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__irems
;	.ref	__iremu

_irems:
	push	af
	push	de
	push	bc
	push	hl
	;;
	;; Check sign
	;;
	ex	de,hl
	or	a,a
	sbc	hl,hl
	sbc	hl,de
	jp	m,.L0
	ex	de,hl
.L0:
	or	a,a
	sbc	hl,hl
	sbc	hl,bc
	jp	m,.L1
	push hl
	pop bc
.L1:
	ex	de,hl
	call	_iremu
	;;
	;; quotient in de
	;; Remainder is in hl
	;; Check signs
	;;
	ex	de,hl
	ld	hl,2
	add	hl,sp
	ld	a,(hl)
	inc	hl
	ld	sp,hl
	or	a,0
	jp	p,.L2
	;;
	;; change sign of remainder
	;;
	sbc	hl,hl
	sbc	hl,de
	ex	de,hl
.L2:
	ex	de,hl
	pop	bc
	pop	de
	pop	af
	ret

