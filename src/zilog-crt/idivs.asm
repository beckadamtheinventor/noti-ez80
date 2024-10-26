;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Signed Integer Division
; Input:
;	Operand1: 
;		  hl : 24 bits (dividend x)
; 
;	Operand2: 
;		  bc : 24 bits (divisor y)
;
; Output:
;	Result:   hl : 24 bits
;
; Registers Used:
;	a, de
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__idivs
;	.ref	__idivu
_idivs:
	push	af
	push	de
	push	bc
	push	hl
	;;
	;; Check sign info
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
	call	_idivu
	;;
	;; quotient in hl
	;; Check signs
	;;
	ex	de,hl
	ld	hl,2
	add	hl,sp
	ld	a,(hl)
	inc	hl
	ld	sp,hl
	inc	hl
	inc	hl
	xor	a,(hl)
	jp	p,.L2
	sbc	hl,hl
	sbc	hl,de
	ex	de,hl
.L2:
	ex	de,hl
	pop	bc
	pop	de
	pop	af
	ret	
