

;restore bootcode stored in sectors $39 and $3A
restore_bootcode:
    ld a,($390000)
    cp a,$FF
    ret z ;don't install if clearly not a bootcode lol.
    ld hl,boot_restore_bootcode_data
    ld de,$D00000
    push de
    ld bc,boot_restore_bootcode_data.len
    ldir
    ret

__string_working:
    db "Working...",0


old_org = $
boot_restore_bootcode_data:
org $D00000
	call _boot_homeup
	ld hl,__string_working
	call _boot_puts_and_new_line
	call _boot_blit_buffer
	call flash_unlock
	call _reset_all_ipbs
	or a,a
	sbc hl,hl
	ld bc,8192
.booteraseloop:
	push hl
	push bc
	call __sector_erase
	pop bc
	pop hl
	add hl,bc
	ld de,$020000
	or a,a
	sbc hl,de
	add hl,de
	jr c,.booteraseloop
	ld hl,$390000
	ld de,$000000
	ld bc,$020000
	call __flash_write
	call _set_boot_ipbs
	ld hl,$0C0000
	ld bc,$010000
.backuperaseloop:
	push hl
	push bc
	call __sector_erase
	pop bc
	pop hl
	add hl,bc
	ld de,$3B0000
	or a,a
	sbc hl,de
	add hl,de
	jr c,.backuperaseloop
	rst 08

;<taken from bootswap>
__flash_write:
	push hl
	ld hl,$AAA
	ld (hl),$AA
	ld a,$55
	ld ($555),a
	ld (hl),$A0
	pop hl
.skip_command:
	push bc
	ld a,(de)
	and a,(hl)
	ld (de),a
	ld c,a
.wait:
	ld a,(de)
	cp a,c
	jr nz,.wait
	pop bc
	inc hl
	inc de
	xor a,a
	dec bc
	ld (ScrapMem),bc
	ld a,(ScrapMem+2)
	or a,b
	or a,c
	jr nz,__flash_write
	ret

__sector_erase:
	ex hl,de
	ld hl,$AAA
	ld	c,$AA
	ld	(hl),c
	ld	a,$55
	ld	($555),a
	ld	(hl),$80
	ld	(hl),c
	ld	($555),a
	ex hl,de
	ld	(hl),$30 ; Do not change this value. You could superbrick your calculator.
	ld h,$FF
	ld l,h
.loop:
	ld a,(hl)
	cp a,$FF
	jr nz,.loop
	ret

_reset_all_ipbs:
    call    enter_ipb_program
    ld  a,$80
    ld  ($00),a
    ld  a,$30
    ld  ($00),a

    ld  hl,24000*71/33
.loop:
    dec hl
    add	hl,de
    or	a,a
    sbc	hl,de
    jr  nz,.loop
    jp  exit_ipb_program

_set_boot_ipbs:
    ld  b,9
    ld  hl,0
    ld  de,8192
.set_ipb:
    call    enter_ipb_program
    ld  a,$A0
    ld  ($000),a
    ld  a,$00
    ld  (hl),a
    add hl,de
    call    wait_500_us
    call    exit_ipb_program
    djnz    .set_ipb
    ret

wait_500_us:
    push    hl
    ld  hl,24000/33
.loop:
    dec hl
    add	hl,de
    or	a,a
    sbc	hl,de
    jr  nz,.loop
    pop hl
    ret

enter_ipb_program:
    ld  a,$AA
    ld  ($AAA),a
    ld  a,$55
    ld  ($555),a
    ld  a,$C0
    ld  ($AAA),a
    ret

exit_ipb_program:
    ld  a,$90
    ld  ($00),a
    xor a,a
    ld  ($00),a
    ret
;</bootswap>
boot_restore_bootcode_data.len:=$-$D00000
org old_org+boot_restore_bootcode_data.len

