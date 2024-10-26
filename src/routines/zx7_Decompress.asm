;modified for use with Open-CE

; ---
; void zx7_Decompress(void *dest, void *src)
; ---
; Dec 2012 by Einar Saukas & Urusergi
; "Turbo" version (89 bytes, 25% faster)
; ---
;	assume	adl=1

; enter : hl = void *src
;         de = void *dst
;
; exit  : hl = & following uncompressed block
;
; uses  : af, bc, de, hl

;	public	_zx7_Decompress
_zx7_Decompress:
        pop     bc
        pop     de
        pop     hl
        push    hl
        push    de
        push    bc

        ld      a, 128

zx7t_copy_byte_loop:

        ldi                             ; copy literal byte

zx7t_main_loop:

        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        jr      nc, zx7t_copy_byte_loop ; next bit indicates either literal or sequence

; determine number of bits used for length (Elias gamma coding)

        push    de
        ld      de, 0
        ld      bc, 1

zx7t_len_size_loop:

        inc     d
        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        jr      nc, zx7t_len_size_loop
        jp      zx7t_len_value_start

; determine length

zx7t_len_value_loop:

        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        rl      c
        rl      b
        jr      c, zx7t_exit           ; check end marker

zx7t_len_value_start:

        dec     d
        jr      nz, zx7t_len_value_loop
        inc     bc                      ; adjust length

; determine offset

        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl

        sla e
        inc e

        jr      nc, zx7t_offset_end    ; if offset flag is set, load 4 extra bits
        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        rl      d                       ; insert first bit into D
        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        call    z, zx7t_load_bits      ; no more bits left?
        ccf
        jr      c, zx7t_offset_end
        inc     d                       ; equivalent to adding 128 to DE

zx7t_offset_end:

        rr      e                       ; insert inverted fourth bit into E

; copy previous sequence

        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
        ldir

zx7t_exit:

        pop     hl                      ; restore source address (compressed data)
        jp      nc, zx7t_main_loop

zx7t_load_bits:

        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        ret
