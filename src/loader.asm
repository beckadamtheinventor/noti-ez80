loader_rst00_handler:
	call _boot_InitializeHardware
	xor a,a
	ld (ti.curCol),a
	ld (ti.curRow),a
	ld hl,loader_boot_tios_string
	call _boot_puts_and_new_line
	jp ti.bootOS
loader_rst10_handler:
	jp $020110
loader_rst18_handler:
	jp $020114
loader_rst20_handler:
	jp $020118
loader_rst28_handler:
	jp $02011C
loader_rst30_handler:
	jp $020120
loader_interrupt_handler:
	jp $0220A8
loader_abort_and_restart:
	ld hl,loader_string_something_went_wrong
	call _boot_puts_and_new_line
	ld hl,loader_string_aborted
	call _boot_puts_and_new_line
	call guess_ill_die
	call _boot_wait_key
	rst $00
loader_check_are_you_sure:
	ld hl,loader_string_are_you_sure
	call _boot_puts_and_new_line
	ld hl,loader_string_enter_to_confirm
	call _boot_puts_and_new_line
	call _boot_wait_key
	cp a,9
	jr z,.yes
	xor a,a
	dec a
	ret
.yes:
	xor a,a
	ret
guess_ill_die:
	ld hl,loader_string_guess_ill_die
	jp _boot_puts_and_new_line

loader_boot_tios_string:
	db "Booting TI-OS",0
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
