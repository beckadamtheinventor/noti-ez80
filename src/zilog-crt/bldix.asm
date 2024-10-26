;Edited for use with open-ce
; (c) Copyright 2007-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; byte load a,(ix+nnnnnn)
; Input:
;	Operand1: 
;                 BC : 24-bit offset from ix
;
; Output:
;       Result:   A : 8 bit
;
; Registers Used:
;	none
;-------------------------------------------------------------------------
;	.assume adl=1
;        .def    __bldix
_bldix:
        push    ix
        push    af              ; Preserve flags
        add     ix,bc
        pop     af              ; Restore flags
        ld      a,(ix)
        pop     ix
        ret

