;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Short Shift Right Unsigned
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
;	.def	__sshru, __sshru_b
;	.assume adl=1
	
_sshru_b:
	push bc
	ld c,a
	call _sshru
	pop bc
	ret

_sshru:
	push	bc
	ld	b,c
	inc	b
	jr	.test
.loop:
	srl	h
	rr	l
.test:
	djnz	.loop
	pop	bc
	ret	

