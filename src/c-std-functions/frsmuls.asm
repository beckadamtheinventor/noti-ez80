;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract short Multiplication signed.
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
;	.def	__frsmuls
;	.ref	__frsmulu

_frsmuls:
	push	af
	push	de
	push	bc
	push	hl
	;;
	;; Check sign info
	;;
	add.s	hl,hl
	jr	nc,.L0
	ex	de,hl
	or	a,a
	sbc	hl,hl
	sbc	hl,de
.L0:
	rl	c
	rl	b
	jr	nc,.L1
	ex	de,hl
	or	a,a
	sbc	hl,hl
	sbc	hl,bc
	ld	b,h
	ld	c,l
	ex	de,hl
.L1:
	call	_frsmulu
	srl	h
	rr	l
	pop	af
	pop	bc
	xor	a,b
	jp	p,.L2
	ex	de,hl
	sbc	hl,hl
	sbc	hl,de
.L2:
	pop	de
	pop	af
	ret

