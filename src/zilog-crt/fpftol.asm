;--------------------------------------------------------------
;
;	        Code Generation Helper
;		For the Zilog eZ80 C Compiler
;	        Copyright 1992-2008 Zilog, Inc. 
;
;--------------------------------------------------------------
;--------------------------------------------------------------
;
;	  	IEEE Single precision to long.
;
; INPUTS:	abc:	32-bit	IEEE Single precision.
;
; OUTPUTS:	abc:	32-bit	signed long.
;
;--------------------------------------------------------------
OP1EXP	:= 0
OP1MAN	:= 1
LOCALIM	:= 10
;	segment	CODE
;	.assume adl=1
	
;	.ref	__fpupop1, __lshrs, __lshl
;        .def    __ftol

_ftol:
	push	ix
	ld	ix,0
	add	ix,sp
	push	iy
	lea	iy,ix-LOCALIM
	ld	sp,iy
	push	de
	push	hl
	ld	de,0
	ld	(iy+OP1MAN),d
	ld	(iy+OP1MAN+4),d
	ld	(iy+OP1MAN+1),de
	call	_fpupop1
	jr	z,.exit 
	cp	a,7FH
	jp	m,.retz		; fp value less than 1
		
	sub	a,7EH
	ld	(iy+OP1EXP),a
	cp	a,32		; fp value greater than 2**32?
	jp	p,.retmax	; too big for an int
	xor	a,a
	bit	0,d
	jr	z,.shftman	; positive sign, shift mantissa
	;;
	;; Mark as negative
	;;
	ld	(iy+OP1MAN+4),1
.shftman:
	ld	(iy+OP1MAN),bc
	ld	(iy+OP1MAN+3),a
	ld	a,(iy+OP1EXP)
	cp	a,24		; Exponent=24?
	ld	a,(iy+OP1MAN+3)
	jr	z,.exit		; done
	jp	p,.shiftl	; must shift left
	;;
	;; integer smaller than 24 bits shift right
	;;
	ld	a,24
	sub	a,(iy+OP1EXP)
	ld	l,a
	ld	a,(iy+OP1MAN+3)
	call	_lshrs
	jr	.sgntest

.shiftl:
	ld	a,(iy+OP1EXP)
	sub	a,24
	ld	l,a
	ld	a,(iy+OP1MAN+3)
	call	_lshl
	jr	.sgntest

.retz:
	xor	a,a
	ld	bc,0
	jr	.exit
.sgntest:
	bit	0,(iy+OP1MAN+4)
	jr	z,.exit
	ld	hl,0
	ld	e,a
	xor	a,a
	sbc	hl,bc
	sbc	a,e
	push hl
	pop bc
	jr	.exit

.retmax:
	ld	bc,$FFFFFF
	ld	a,$FF
	bit	0,d
	jr	nz,.exit
	ld	a,7FH

.exit:		
	pop	hl
	pop	de
	ld	iy,(ix-3)
	ld	sp,ix
	pop	ix
	ret
;	end
