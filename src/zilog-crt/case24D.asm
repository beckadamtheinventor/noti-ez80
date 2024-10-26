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
;	Result:   hl : 24 bit address of case jp to take
; Registers Used:
; 
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__case24D

_case24D:
	ex		(sp),iy		;store iy and take table address into iy
	push	iy			;store return address
	push	af
	push	bc
	push	de
	
	lea		iy,iy+3		;table address starts after JP (HL) instruction and 16-bit count
	ld		de,(iy-2)	;count

.loop:
	ld		bc,(iy)		;case value
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
	pop		iy			;return address
	ex		(sp),iy		;exchange return address with the actual value of IY at entry
	ret

