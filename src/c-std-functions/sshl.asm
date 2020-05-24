;Edited for use with open-ce
; Created 12/2001: G.Loegel
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Short Shift Left
; Input:
;	Operand1: 
;		  BC : 16 bit number of bits to shift
;			Assume B=0 C=shift count
;	Operand2: 
;		  HL : 16 bit value to be shifted by C
;
; Output:
;	Result:   HL : 16 bit 
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.def	__sshl, __sshl_b
;	.assume adl=1

_sshl_b:
	push bc
	ld c,a
	call _sshl
	pop bc
	ret


_sshl:
	push	bc
	ld	b,c
	inc	b
	jr	.test
.loop:
	add	hl,hl
.test:
	djnz	loop
	pop	bc
	ret	

