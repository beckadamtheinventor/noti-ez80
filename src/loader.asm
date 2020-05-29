
loader_string_version:
	db "Some Loader Version 0.1",0

loader_boot_handler:
	call loader_homeup
	ld hl,loader_crash_string
	call _boot_PutS_and_new_line
	call _boot_PutS_and_new_line
	call _boot_PutS_and_new_line
	call _boot_NewLine
	ld hl,loader_string_version
	call _boot_PutS_and_new_line
	call boot_wait_key
	jp $020108
boot_interrupt_handler:
	jp $0220A8
boot_abort_and_restart:
	call boot_homeup
	ld hl,loader_string_something_went_wrong
	call _boot_PutS_and_new_line
	ld hl,loader_string_aborted
	call _boot_PutS_and_new_line
	call guess_ill_die
	call loader_wait_key
	rst $00
boot_check_are_you_sure:
	ld hl,loader_string_are_you_sure
	call _boot_PutS_and_new_line
	ld hl,loader_string_enter_to_confirm
	call _boot_PutS
.wait:
	call boot_get_keycode
	cp a,9
	jr z,.yes
	cp a,15
	jr nz,.wait
	xor a,a
	dec a
	ret
.yes:
	xor a,a
	ret
guess_ill_die:
	ld hl,loader_string_guess_ill_die

boot_wait_key:
	call loader_get_keycode
	or a,a
	jr z,loader_wait_key
	ret

boot_get_keycode:
	call loader_scan_keypad
	ld hl,$F50012
	ld b,7
	ld c,49
.scanloop:
	ld a,(hl)
	or a,a
	jr nz,.keyispressed
	inc hl
	inc hl
	ld a,c
	sub a,8
	ld c,a
	djnz .scanloop
	xor a,a
	ret
.keyispressed:
	ld b,8
.keybitloop:
	rrca
	jr c,.this
	inc c
	djnz .keybitloop
.this:
	ld a,c
	ret

boot_scan_keypad:
	di             ; Disable interrupts
	ld hl,0F50000h
	ld (hl),2      ; Set Single Scan mode
	xor a,a
.wait:
	cp a,(hl)      ; Wait for Idle mode
	jr nz,.wait
	ret

boot_Delay250ms:
	ld b,25
.loop:
	call boot_Delay10ms
	djnz .loop
	ret

boot_homeup:
	xor a,a
	ld (ti.curCol),a
	ld (ti.curRow),a
	ret


loader_crash_string:
	db "Ouch looks like your calc",0
	db "crashed or reset!",0
	db "    :-(",0
loader_boot_tios_string:
	db "Booting OS ",0
loader_string_enter_to_confirm:
	db "Press enter to confirm",0
loader_string_are_you_sure:
	db "Are you sure?",0
loader_string_something_went_wrong:
	db "Something went wrong",0
loader_string_aborted:
	db "Abort",0
loader_string_guess_ill_die:
	db "Guess I'll die \\o/",0

