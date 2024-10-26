;Edited for use with open-ce
; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract unsigned char to float conversion.
;
; Input:
;	Operand1: 
;		  A : 8 bits
;
; Output:
;	Result:   eHL : 32 bit
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__frbtof
;	.ref	__frubtof

_frbtof:
	or	a,a
	rla
	jr	nc,.L1
	jr	nz,.L0
	rra	
	ld	hl,$800000
	ld	e,$BF
	ret
.L0:
	neg
.L1:
	push	af
	call	_frubtof
	pop	af
	ret nc
	rra
	rl	e
	scf
	rr	e
	ret

