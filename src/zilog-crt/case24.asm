;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; CASE branch resolution.
;
; Input:
;	Operand3: 
;		  hl : 24 bit value to match in table
; 
; Output:
;
; Registers Used:
; 
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__case24

_case24:
	ex		(sp),iy		;store iy and take table address into iy
	push	af
	push	bc
	push	de
	
	lea		iy,iy+2		;table address starts after 16-bit count
	ld		de,(iy-2)	;count

.loop:
	ld		bc,(iy)		;case value (24-bit)
	lea		iy,iy+3		;case label
	push	hl
	or		a,a
	sbc		hl,bc
	pop		hl
	jr		z, .done
	
	dec.s	de			;decrement count
	ld		b,0
	ld		c,0
	ex		de,hl
	or		a,a
	sbc.s	hl,bc
	ex		de,hl
	lea		iy,iy+3
	jr		nz,.loop

.done:	
	ld		hl,(iy)

	pop		de
	pop		bc
	pop		af
	ex		(sp),iy		;restore iy
	ex		(sp),hl		;store jump target as return address on stack
	ret
