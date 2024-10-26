;--------------------------------------------------------------
;
;	        Code Generation Helper
;		For the  Zilog eZ80 C Compiler
;	        Copyright 1992-2008 Zilog, Inc. 
;
;--------------------------------------------------------------
;--------------------------------------------------------------
;
;	  	Unpack IEEE op1 of dyadic operations.
;
; INPUTS:	AuBC:	32bits
;
;		A AAAAAAAB BBBBBBBBBBBBBBBCCCCCCCC
;		S EEEEEEEE FFFFFFFFFFFFFFFFFFFFFFF
;		0 1      8 9                    31
; 
; OUTPUTS:	uBC:		Mantissa
;		A:		Exponent
;		D:		Sign Bit
;		ZERO FLAG	Set if op was zero.
; 
; MODIFIES:
;		flags
;--------------------------------------------------------------

;	segment	CODE
;
;	.def	__fpupop1
;	.assume adl=1

_fpupop1:
	push	ix
	ld	ix,0
	add	ix,sp
	push	bc
	rlc	(ix-1)		;move high-bit to low-bit
	scf
	rr	(ix-1)		;carry = exponent low-bit, high-bit = 1
	pop	bc		;restore modified mantissa
	rl	a		;compute exponent, carry = sign
	ld	d,0
	jr	nz,.nzero	;skip if exponent non-zero

	ld	bc,0		;clear mantissa
	or	a,a		;clear carry
.nzero:
	rl	d		;set 1 if negative operand
	or	a,a		;set Z/NZ
	pop	ix
	ret

