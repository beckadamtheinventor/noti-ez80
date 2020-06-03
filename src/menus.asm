boot_boot_os:
	call boot_setup_hardware
boot_menu:
	ld hl,-2
	call _frameset
	xor a,a
	ld (ix-1),a
	call boot_index_os_list
	ld (ix-2),e ;previous function returns de = end of OS list buffer
.draw:
	call boot_menu_draw
	ld hl,$D00000
	ld l,(ix-1)
	ld a,(hl)
	or a,a
	jr z,.noos
	push af
	xor a,a
	ld (ti.curCol),a
	ld a,3
	ld (ti.curRow),a
	ld hl,string_boot_this_os
	call _boot_puts_and_new_line
	pop af
	ld hl,ScrapMem+2
	ld (hl),a
	dec hl
	xor a,a
	ld (hl),a
	dec hl
	ld (hl),$80
	ld hl,(ScrapMem)
	ld a,(hl)
	cp a,$80
	call c,_boot_PutS
.noos:
	call _boot_blit_buffer
.keys:
	call boot_wait_key_cycle
	cp a,1
	jq z,.curdown
	cp a,4
	jq z,.curup
	cp a,15 ;[clear] key
	jr z,.turn_off
	cp a,31 ;[prgm] key
	jr z,.launch_hex_editor
	cp a,9 ;[enter] key
	jr z,.launch_os
	jr .keys
.curdown:
	ld a,(ix-1)
	inc a
	cp a,(ix-2)
	jr nz,.setcursor
	xor a,a
	jr .setcursor
.curup:
	ld a,(ix-1)
	dec a
	jr nc,.setcursor
	ld a,(ix-2)
	dec a
.setcursor:
	ld (ix-1),a
	jq .draw
.launch_hex_editor:
	call hex_editor
	jq boot_menu
.launch_os:
	call boot_check_os_signature
	jq z,.no_os
	ld hl,$0108
	ld (ScrapMem),hl
	ld a,(ix-1)
	ld (ScrapMem+2),a
	ld hl,(ScrapMem)
	ld sp,ix
	pop ix
	jp (hl)
.no_os:
	ld iy,string_no_os
	rst 8
.turn_off:
	ld sp,ix
	pop ix
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
