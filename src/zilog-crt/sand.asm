;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Short AND.
; Input:
;	Operand1: 
;		  hl : 16 bit
;
;	Operand2: 
;		  bc : 16 bit
;
; Output:
;	Result:   hl : 16 bit
; Registers Used:
;	a
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__sand
_sand:
	push	af
	ld	a,l
	and	a,c
	ld	l,a

	ld	a,h
	and	a,b
	ld	h,a

	pop	af
	ret	
