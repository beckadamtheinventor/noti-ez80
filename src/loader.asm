

loader_boot_handler:
	call boot_homeup
	ld hl,loader_crash_string
	call _boot_puts_and_new_line
	call _boot_puts_and_new_line
	call _boot_puts_and_new_line
	call _boot_NewLine
	call _boot_blit_buffer
	call boot_wait_key
	jp $020108
boot_abort_and_restart:
	call boot_homeup
	ld hl,loader_string_something_went_wrong
	call _boot_puts_and_new_line
	ld hl,loader_string_aborted
	call _boot_puts_and_new_line
	call _boot_blit_buffer
	call boot_wait_key
	rst $00
boot_check_are_you_sure:
	ld hl,loader_string_are_you_sure
	call _boot_puts_and_new_line
	ld hl,loader_string_enter_to_confirm
	call _boot_PutS
	call _boot_blit_buffer
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

