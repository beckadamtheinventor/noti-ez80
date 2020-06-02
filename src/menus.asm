boot_boot_os:
	call boot_setup_hardware
boot_menu:
	call boot_menu_draw
	call _boot_blit_buffer
.keys:
	call boot_wait_key_cycle
	cp a,15
	jr z,turn_calc_off
	cp a,31 ;[prgm] key
	jr z,.launch_hex_editor
	cp a,9
	jr z,.launch_os
	jr .keys
.launch_hex_editor:
	call hex_editor
	jr boot_menu
.launch_os:
	call boot_check_os_signature
	jp z,$020108
	ld iy,string_no_os
	rst 8
turn_calc_off:
	call _boot_TurnOffHardware
.loop:
	call boot_get_keycode
	or a,a
	jr z,.loop
	rst 0

boot_abort_and_restart:
	call boot_menu_draw
	ld a,3
	ld (ti.curRow),a
	xor a,a
	ld (ti.curCol),a
	ld a,$C0
	ld (textColors+1),a
	ld hl,string_oh_no
	call _boot_puts_and_new_line
	xor a,a
	ld (textColors+1),a
	call _boot_puts_and_new_line
	call _boot_puts_and_new_line
	call _boot_puts_and_new_line
	call _boot_blit_buffer
.keys:
	call boot_wait_key_cycle
	cp a,9
	jr nz,.keys
	call _boot_TurnOffHardware
	rst 0

boot_menu_draw:
	call _boot_ClearVRAM
	call _boot_ClearBuffer
	call _boot_homeup
	call _boot_drawstatusbar
	ld bc,$FF
	ld (textColors),bc
	call boot_check_os_signature
	jr z,.dont_say_no_os
	ld hl,string_no_os
	call _boot_puts_and_new_line
.dont_say_no_os:
	ld a,16
	ld (ti.curRow),a
	ld hl,string_key_info
	call _boot_puts_and_new_line
	call _boot_puts_and_new_line
	call _boot_puts_and_new_line
	ld a,21
	ld (ti.curRow),a
	ld hl,string_boot_version
	call _boot_puts_and_new_line
	jp _boot_puts_and_new_line
