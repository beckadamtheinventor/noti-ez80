;*          Copyright (c) 2007-2008 Zilog, Inc.
;*****************************************************************************
;*  cstartup.asm
;*
;*  ZDS II C Runtime Startup for the eZ80 and eZ80Acclaim! C Compiler
;*****************************************************************************


        xdef _errno
        xdef __c_startup
        xdef __cstartup
        xref _main

        xref __low_bss       ; Low address of bss segment
        xref __len_bss       ; Length of bss segment

        xref __low_data      ; Address of initialized data section
        xref __low_romdata   ; Addr of initialized data section in ROM
        xref __len_data      ; Length of initialized data section

        xref __copy_code_to_ram
        xref __len_code
        xref __low_code
        xref __low_romcode

		xdef _abort

        __cstartup equ %1

;*****************************************************************************
;* Startup code. Reset entry point.
;*
        define  .STARTUP, space = ROM

        segment .STARTUP       ; This should be placed properly
        .assume ADL=1

__c_startup:
_c_int0:
;--------------------------------------------------
;  Initialize the .BSS section to zero

    ld  hl, __len_bss          ; Check for non-zero length
    ld  bc, 0                  ; *
    or  a, a                   ;  clears carry bit
    sbc hl, bc                 ; *
    jr  z, _c_bss_done         ; .BSS is zero-length ...
$$:
    ld  hl, __low_bss          ; [hl]=.bss
    ld  bc, __len_bss
    ld  (hl), 0
    dec bc                     ; 1st byte's taken care of
    ld  hl, 0
    sbc hl, bc
    jr  z, _c_bss_done         ; Just 1 byte ...
    ld  hl, __low_bss          ; reset hl
    ld  de, __low_bss+1        ; [de]=.bss+1
    ldir                       ; Load Increment with Repeat
_c_bss_done:


;--------------------------------------------------
;  Copy the initialized data section
        ld      hl, __len_data         ; Check for non-zero length
    ld  bc, 0                  ; *
    or  a, a                   ; Clears carry flag
    sbc hl, bc                 ; *
    jr  z, _c_data_done        ; __len_data is zero-length ...
$$:
    ld  hl, __low_romdata      ; [hl]=.data_copy
    ld  de, __low_data         ; [de]=.data
    ld  bc, __len_data         ; [bc]= data length
    ldir                       ; Copy the data section
_c_data_done:

;--------------------------------------------------
;  Copy CODE (which may be in FLASH) to RAM if the
;  - copy_code_to_ram symbol is set in the link control file

    ld a, __copy_code_to_ram
    or a, a
    jr z, _copy_code_to_ram_done
    ld hl, __len_code          ; Check for non-zero length
    ld bc, 0                   ; *
    or a, a                    ; Clears carry flag
    sbc hl, bc                 ; *
    jr z, _copy_code_to_ram_done  ; __len_code is zero-length ...

    ld hl, __low_romcode       ; [hl]=.code_copy
    ld de, __low_code          ; [de]=.code
    ld bc, __len_code          ; [bc]= code length
    ldir                       ; Copy the code section
_copy_code_to_ram_done:

;---------------------------------------------
; prepare to go to the main system rountine
    ld hl, 0                   ; hl = NULL
    push hl                    ; argv[0] = NULL
    ld ix, 0
    add ix, sp                 ; ix = &argv[0]
    push ix                    ; &argv[0]
    pop hl
    ld de, 0                   ; argc = 0
    call _main                 ; int main( int argc, char *argv[]) )
    pop de                 ; clean the stack
__exit:
_abort:
    jr $                  ; if we return from main loop forever here

;*****************************************************************************
;* Define global system var _errno. Used by floating point libraries
;*
        segment DATA
_errno:
        ds 3                       ; extern int _errno


