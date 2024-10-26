;Edited for use with open-ce
; (c) Copyright 2001-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; Integer load hl,(iy+nnnnnn)
; Input:
;	Operand1: 
;                 BC : 24-bit offset from iy
;
; Output:
;	Result:   hl : 24 bit
;
; Registers Used:
;      
;-------------------------------------------------------------------------
;	.assume adl=1
;        .def    __ildiy
_ildiy:
        push    iy
        push    af              ; Preserve flags
        add     iy,bc
        pop     af              ; Restore flags
        ld      hl,(iy)
        pop     iy
        ret

