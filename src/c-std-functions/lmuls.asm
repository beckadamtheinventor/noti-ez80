;Edited for use with open-ce
; (c) Copyright 1999-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Long Multiplication Signed.
; Input:
;	Operand1: 
;		  ABC : 32 bits 
;
;	Operand2: 
;		  EHL : 32 bits 
;
; Output:
;	Result:   ABC : 32 bit
; Registers Used:
;	de,af
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__lmuls
;	.ref	__lmulu
_lmuls:
	push	ix
	ld	ix,0
	add	ix,sp
	;; 
	;; Save working registers/multiplicands
	;;
	push	hl		; 1-3
	push	de		; 4-6
	ld	d,a
	push	de		; 7-9
	push	bc		; 10-12
	push	af		; 13-15
	;; 
	;; Check the sign
	;; 
	xor	a,e		; HOB Op1
	jp	p,.ssign
	;;
	;; Different signs
	;;
	xor	a,e		; S-bit sign of Op2
	jp	p,.op2neg
	;;
	;; Op1 is negative
	;;
	ld	hl,0
	or	a,a
	sbc	hl,bc
	push hl
	pop bc
	ld	a,0
	sbc	a,d		; ABC has negated Op1
	ld	hl,(ix-3)
	jp	.ustart	
.op2neg:
	ex	de,hl		; put Op2 in de
	ld	hl,0
	or	a,a
	sbc	hl,de
	ld	d,a
	ld	a,0
	sbc	a,(ix-6)
	ld	e,a		; EHL has negated Op2
	ld	a,d
	jp	.ustart
	;;
	;; same sign, but which?
	;; 
.ssign:
	xor	a,e
	jp	p,.ustart
	;;
	;; both negative
	;;
	ex	de,hl
	ld	hl,0
	or	a,a
	sbc	hl,bc
	push hl
	pop bc
	ld	a,0
	sbc	a,(ix-8)		; ABC positive
	ex	de,hl
	jp	.op2neg
.ustart:
	;;
	;; Call unsigned multiply
	;;
	call	__lmulu
	;;
	;; abc has results
	;; set sign of result
	;;
	ld	d,a
	ld	a,(ix-8)	; HOB Op1
	xor	a,(ix-9)	; HOB Op2
	ld	a,d
	jp	p,.restregs	; same sign, we're done
	;;
	;; flip sign of abc
	;;
	ld	hl,0
	or	a,a
	sbc	hl,bc
	ld	a,0
	sbc	a,d
	push hl
	pop bc
	;; restore working regs
	;;
.restregs:
	ld	(ix-14),a
	pop	af
	pop	hl		; discard  old bc
	pop	de		; discard de
	pop	de		; restore de
	pop	hl		; restore old hl
	pop 	ix
	ret	






