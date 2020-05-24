;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Indirect Call 
; Input:
;	Operand1: 
;                 iy : 24 bit
;
; Output:
; Registers Used:
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def	__indcall
_indcall:
        jp      (iy)

