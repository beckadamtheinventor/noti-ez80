;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract interger Multiplication Unsigned.
;
; Input:
;	Operand1: 
;		  uHL : 24 bits
;
;	Operand2: 
;		  uBC : 24 bits
;
; Output:
;	Result:   uHL : 24 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frimuls
;	.ref	__frimulu

_frimuls:
	push	af
	push	de
	push	bc
	push	hl
	;;
	;; Check sign info
	;;
	add	hl,hl
	jr	nc,.L0
	ex	de,hl
	or	a,a
	sbc	hl,hl
	sbc	hl,de
.L0:
	ex	de,hl
	or	a,a
	sbc	hl,hl
	add	hl,bc
	add	hl,hl
	jr	nc,.L1
	or	a,a
	sbc	hl,hl
	sbc	hl,bc
	add	hl,hl
.L1:
	push hl
	pop bc
	ex	de,hl
	call	_frimulu
	push	hl
	ex de,hl
	ld	hl,2
	add	hl,sp
	rr (hl)
	rr	d
	rr	e
	pop hl
	ld h,d
	ld l,e
	;;
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




