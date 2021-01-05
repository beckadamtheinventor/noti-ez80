boot_boot_os:
	call boot_setup_hardware

boot_menu:
	ld hl,-2
	call _frameset
	ld a,1
	ld (ix-1),a
	inc a
	ld (ix-2),a

.draw:
	call boot_menu_draw
	xor a,a
	ld (ti.curCol),a
	ld a,3
	ld (ti.curRow),a
	ld hl,string_boot_this_os
	call _boot_puts_and_new_line
	ld a,(ix-1)
	ld hl,string_RecoveryMode
	or a,a
	jq z,.print
	ld hl,string_OS
.print:
	call _boot_PutS

.noos:
	call _boot_blit_buffer

.keys:
	call boot_wait_key_cycle
	cp a,1
	jq z,.curdown
	cp a,4
	jq z,.curup
	cp a,15 ;[clear] key
	jq z,.turn_off
	cp a,31 ;[prgm] key
	jq z,.launch_hex_editor
	cp a,9 ;[enter] key
	jq z,.launch_os
	cp a,52 ;[window] key
	jq z,.restore_bootcode
	jr .keys

.curdown:
	ld a,(ix-1)
	inc a
	cp a,(ix-2)
	jr c,.setcursor
	xor a,a
	jr .setcursor

.curup:
	ld a,(ix-1)
	or a,a
	jr z,.cursorseekend
	dec a

.setcursor:
	ld (ix-1),a
	jq .draw

.cursorseekend:
	ld a,(ix-2)
	dec a
	jq .setcursor

.launch_hex_editor:
	call hex_editor
	jq boot_menu

.launch_os:
	ld a,(ix-1)
	or a,a
	jp z,$010108
	call _boot_ZeroVRAM
	ld a,ti.lcdBpp16
	ld (ti.mpLcdCtrl),a
	jp $020108

.restore_bootcode:
	call restore_bootcode
;we won't get here if the installation succeeds
	ld hl,string_failed_to_restore
	call _boot_puts_and_new_line
	call _boot_blit_buffer
	jp boot_wait_key_cycle

.no_os:
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


test_aubc_routine:
	ld a,$C3
	ld ($D00000),a
	ld ($D00001),hl
	ld hl,-7
	call _frameset
	ld hl,string_testing_function
	call _boot_PutS
	xor a,a
	sbc hl,hl
	ld (ix-7),hl
	ld (ix-4),a
	ld hl,($D00001)
	call _print24h
	call _boot_NewLine
	ld bc,(ti.curRow)
	ld (ix-3),bc
	jr .test_entry
.test_loop:
	ld bc,(ix-3)
	ld hl,ti.curRow
	ld (hl),c
	inc hl
	ld (hl),b
.test_entry:
	ld hl,(ix-7)
	ld a,(ix-4)
	push af
	push hl
	ld e,a
	call _print32h
	ld a,'='
	call _boot_PutC
	pop bc
	pop af
	call _ltof
	call $D00000
	ld bc,$10000
	ld a,c
	call _fmul
	call _ftol
	push bc
	pop hl
	ld e,a
	call _print32h
	call _boot_blit_buffer
	xor a,a
	ld bc,(ix+6)
	ld hl,(ix-7)
	ld e,(ix-4)
	call _ladd
	ld (ix-7),bc
	ld (ix-4),a
	ld hl,(ix+9)
	ld e,(ix+12)
	call _fcmp
	jp m,.exit
	call boot_scan_keypad
	ld a,($F50014+6*2)
	bit 6,a
	jr z,.test_loop
.exit:
	call boot_wait_key_cycle
	ld sp,ix
	pop ix
	ret


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

boot_menu_clear:
	call _boot_ClearVRAM
	call _boot_ClearBuffer
	call _boot_homeup
	ld bc,$FF
	ld (textColors),bc
	jp _boot_drawstatusbar

boot_menu_draw:
	call boot_menu_clear
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
