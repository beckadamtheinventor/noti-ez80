;*         Copyright (c) 2007-2008 Zilog, Inc.
;*****************************************************************************
;*  vectors16.asm
;*
;*  eZ80's Reset, RST and first generation interrupt vector arrangement
;*****************************************************************************

        xref __init
        xref __low_rom

        xdef _reset
        xdef __default_nmi_handler
        xdef __default_mi_handler
        xdef __nvectors
        xdef _init_default_vectors
        xdef __init_default_vectors
        xdef _set_vector
        xdef __set_vector
        xdef __2nd_jump_table
        xdef __1st_jump_table
        xdef __vector_table


NVECTORS EQU 128               ; number of interrupt vectors

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

    ld hl, __2nd_jump_table
    ld b, NVECTORS
    ld iy, __default_mi_handler
$2:
    ld (hl), %c3               ; place jp opcode
    inc hl
    ld (hl), iy                ; __default_hndlr
    inc hl
    inc hl
    inc hl
    djnz $2

    im 2                       ; Interrtup mode 2
    ld a, __vector_table >> 8 & 0ffh
    ld i, a                    ; Load interrtup vector base

    pop af
    ret

;*****************************************************************************
;*  void _set_vector( unsigned short vector, void( *handler )( void ) );
;*
;*  installs a user interrupt handler in the 2nd interrupt vector jump table
;*
;*  (IX+9)  handler - address of user interrupt handler
;*  (IX+6)  vector  - used to calculate the __2nd_jump_table offset
;*
__set_vector:
_set_vector:
    push ix
    ld ix, 0
    add ix, sp                 ; Standard prologue
    push af
    di

    ld bc, 0                   ; clear bc
    ld b, 2                    ; calculate 2nd jump table offset
    ld c, (ix+6)               ; vector offset
    mlt bc                     ; bc is 2nd jp table offset
    ld hl, __2nd_jump_table
    add hl, bc                 ; hl is location of jp in 2nd jp table
    ld (hl), %c3               ; place jp opcode just in case
    inc hl                     ; hl is jp destination address
    ld bc, (ix+9)              ; bc is isr address
    ld (hl), bc                ; store new isr address

    ei
    pop af
    ld sp, ix                  ; Standard epilogue
    pop ix
    ret


        segment DATA
;*****************************************************************************
;*  number of vectors supported
;*
__nvectors:
        dw NVECTORS         ; extern unsigned short _num_vectors;

        segment BSS
;*****************************************************************************
;*  2nd Interrupt Vector Jump Table
;*   - this table must reside in RAM anywhere in the 16M byte range
;*   - each 4-byte entry is a jump to an interrupt handler
;*
__2nd_jump_table:
        ds NVECTORS * 4

;*****************************************************************************
;*  Interrupt Vector Table
;*   - this segment must be aligned on a 256 byte boundary anywhere below
;*     the 64K byte boundry
;*   - each 2-byte entry is a 2-byte vector address
;*
        define .IVECTS, space = ROM, align = 100h
        segment .IVECTS
__vector_table:
    dw __1st_jump_table + %00
    dw __1st_jump_table + %04
    dw __1st_jump_table + %08
    dw __1st_jump_table + %0c
    dw __1st_jump_table + %10
    dw __1st_jump_table + %14
    dw __1st_jump_table + %18
    dw __1st_jump_table + %1c
    dw __1st_jump_table + %20
    dw __1st_jump_table + %24
    dw __1st_jump_table + %28
    dw __1st_jump_table + %2c
    dw __1st_jump_table + %30
    dw __1st_jump_table + %34
    dw __1st_jump_table + %38
    dw __1st_jump_table + %3c
    dw __1st_jump_table + %40
    dw __1st_jump_table + %44
    dw __1st_jump_table + %48
    dw __1st_jump_table + %4c
    dw __1st_jump_table + %50
    dw __1st_jump_table + %54
    dw __1st_jump_table + %58
    dw __1st_jump_table + %5c
    dw __1st_jump_table + %60
    dw __1st_jump_table + %64
    dw __1st_jump_table + %68
    dw __1st_jump_table + %6c
    dw __1st_jump_table + %70
    dw __1st_jump_table + %74
    dw __1st_jump_table + %78
    dw __1st_jump_table + %7c
    dw __1st_jump_table + %80
    dw __1st_jump_table + %84
    dw __1st_jump_table + %88
    dw __1st_jump_table + %8c
    dw __1st_jump_table + %90
    dw __1st_jump_table + %94
    dw __1st_jump_table + %98
    dw __1st_jump_table + %9c
    dw __1st_jump_table + %a0
    dw __1st_jump_table + %a4
    dw __1st_jump_table + %a8
    dw __1st_jump_table + %ac
    dw __1st_jump_table + %b0
    dw __1st_jump_table + %b4
    dw __1st_jump_table + %b8
    dw __1st_jump_table + %bc
;*****************************************************************************
;*  1st Interrupt Vector Jump Table
;*   - this table must reside in the first 64K bytes of memory
;*   - each 4-byte entry is a jump to the 2nd jump table plus offset
;*
__1st_jump_table:
    jp __2nd_jump_table + %00
    jp __2nd_jump_table + %04
    jp __2nd_jump_table + %08
    jp __2nd_jump_table + %0c
    jp __2nd_jump_table + %10
    jp __2nd_jump_table + %14
    jp __2nd_jump_table + %18
    jp __2nd_jump_table + %1c
    jp __2nd_jump_table + %20
    jp __2nd_jump_table + %24
    jp __2nd_jump_table + %28
    jp __2nd_jump_table + %2c
    jp __2nd_jump_table + %30
    jp __2nd_jump_table + %34
    jp __2nd_jump_table + %38
    jp __2nd_jump_table + %3c
    jp __2nd_jump_table + %40
    jp __2nd_jump_table + %44
    jp __2nd_jump_table + %48
    jp __2nd_jump_table + %4c
    jp __2nd_jump_table + %50
    jp __2nd_jump_table + %54
    jp __2nd_jump_table + %58
    jp __2nd_jump_table + %5c
    jp __2nd_jump_table + %60
    jp __2nd_jump_table + %64
    jp __2nd_jump_table + %68
    jp __2nd_jump_table + %6c
    jp __2nd_jump_table + %70
    jp __2nd_jump_table + %74
    jp __2nd_jump_table + %78
    jp __2nd_jump_table + %7c
    jp __2nd_jump_table + %80
    jp __2nd_jump_table + %84
    jp __2nd_jump_table + %88
    jp __2nd_jump_table + %8c
    jp __2nd_jump_table + %90
    jp __2nd_jump_table + %94
    jp __2nd_jump_table + %98
    jp __2nd_jump_table + %9c
    jp __2nd_jump_table + %a0
    jp __2nd_jump_table + %a4
    jp __2nd_jump_table + %a8
    jp __2nd_jump_table + %ac
    jp __2nd_jump_table + %b0
    jp __2nd_jump_table + %b4
    jp __2nd_jump_table + %b8
    jp __2nd_jump_table + %bc

        end