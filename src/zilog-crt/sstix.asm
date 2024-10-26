;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Integer store (ix+nnnnnn),HL
; Input:
;	Operand1: 
;                 BC : 24-bit offset from ix
;                 HL : 16-bit integer to store
;
; Output:
;       
;
; Registers Used:
;      
;-------------------------------------------------------------------------
;	.assume adl=1
;        .def    __sstix
_sstix:
        push    ix
        push    af              ; Preserve flags
        add     ix,bc
        pop     af              ; Restore flags
        ld      (ix),l
        ld      (ix+1),h
        pop     ix
        ret

