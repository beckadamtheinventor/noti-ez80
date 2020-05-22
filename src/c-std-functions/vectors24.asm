;*     Copyright (c) 2007-2008 Zilog, Inc.
;*****************************************************************************
;*  vectors24.asm
;*
;*  eZ80's Reset, RST and 2nd generation interrupt arrangement
;*****************************************************************************

        xref __init

        xdef _reset
        xdef __default_nmi_handler
        xdef __default_mi_handler
        xdef __nvectors
        xdef _init_default_vectors
        xdef __init_default_vectors
        xdef _set_vector
        xdef __set_vector
        xdef __vector_table

NVECTORS EQU 256               ; number of potential interrupt vectors

;************************************************************************
;*  Reset and all RST nn's
;*  1. diaable interrupts
;*  2. clear mixed memory mode (MADL) flag
;*  3. jump to initialization procedure with jp.lil to set ADL
        define .RESET, space = ROM
        segment .RESET
_reset:
_rst0:
    di
    rsmix
    jp.lil __init
_rst8:
    di
    rsmix
    jp.lil __init
_rst10:
    di
    rsmix
    jp.lil __init
_rst18:
    di
    rsmix
    jp.lil __init
_rst20:
    di
    rsmix
    jp.lil __init
_rst28:
    di
    rsmix
    jp.lil __init
_rst30:
    di
    rsmix
    jp.lil __init
_rst38:
    di
    rsmix
    jp.lil __init
        ds %26
_nmi:
    di
    rsmix
    jp.lil __default_nmi_handler


        segment CODE
        .assume ADL = 1
;*****************************************************************************
;*  Default Non-Maskable Interrupt handler
;*
__default_nmi_handler:
    retn

;*****************************************************************************
;*  Default Maskable Interrupt handler
;*
__default_mi_handler:
    ei
    reti

;*****************************************************************************
;*  void _init_default_vectors( void );
;*
;*  initialize all potential interrupt vector locations with a known
;*  default handler.
;*
__init_default_vectors:
_init_default_vectors:
    push af
    di                         ; disable interrupts while loading table

    ld hl, __vector_table
    ld b, NVECTORS-1
    ld iy, __default_mi_handler
$load_hndlr:
    ld (hl), iy                ; load default handler
    inc hl                     ;
    inc hl                     ; move to next location
    inc hl                     ;
    inc hl                     ;
    djnz $load_hndlr

    im 2                       ; interrtup mode 2
    ld hl, __vector_table >> 8 & 0ffffh
    ld i, hl                   ; load interrupt vector base

    pop af
    ei                         ; it is safe to enable interrupts now
    ret

;*****************************************************************************
;*  void _set_vector( unsigned short vector, void( *handler )( void ) );
;*
;*  installs a user interrupt handler in the vector table
;*
;*  (IX+9)  handler - address of user interrupt handler
;*  (IX+6)  vector  - vector offset
;*
__set_vector:
_set_vector:
    push ix                    ; Standard prologue
    ld ix,0
    add ix,sp           
    push af
    di
    
    ld hl, 0
    ld hl, (ix+6)              ; load vector offset
    ld bc, __vector_table      ; load base address for vector table
    add hl, bc                 ; calculate vector location
    ld bc, (ix+9)              ; handler
    ld (hl), bc                ; store new vector address
        
    ei
    pop af                     ; Standard epilogue
    ld sp, ix
    pop ix
    ret


;*****************************************************************************
;*  this segment must be aligned on a 512 byte boundary anywhere in RAM
;*  each entry will be a 3-byte address in a 4-byte space 
;*
        define .IVECTS, space = RAM, align = 200h
        segment .IVECTS
__vector_table:
        ds NVECTORS * 4


        segment DATA
;*****************************************************************************
;*  number of vectors supported
;*
__nvectors:
        dw NVECTORS         ; extern unsigned short _num_vectors;

        end