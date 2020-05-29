
	di
	rsmix
	jp.lil boot_boot_os ;$000E4F ;rst 00
	di
	rsmix
	jp.lil boot_abort_and_restart ;rst 08
;rst 10 - 30 are handled by OS
	di
	rsmix
	jp.lil $020110 ;rst 10
	di
	rsmix
	jp.lil $020114 ;rst 18
	di
	rsmix
	jp.lil $020118 ;rst 20
	di
	rsmix
	jp.lil $02011C ;rst 28
	di
	rsmix
	jp.lil $020120 ;rst 30
handle_rst38: ;rst 38 - interrupt handler
	ex af,af'
	exx
	push ix
	push iy
	ld iy, $D00080
	jp boot_interrupt_handler
;$ = $47. Validate/check OS
boot_check_os:
	push hl
	push bc
	call boot_check_os_signature ;check the first two bytes of OS equal 0xA55A
	pop bc
	pop hl
	jp nz,boot_invalid_os
	pop af
	jp boot_boot_os ;$0220A8

paduntil $66
nmi_handler:
	push af
	in0 a,($3D)
	and a,$03
	out0 ($3E),a
	jr z,boot_check_os
	pop af
	jp boot_setup_hardware

paduntil $80

;follow with the jump table
include 'table.asm'

boot_boot_os:
	call boot_setup_hardware
	
	jp $020108
boot_setup_hardware:
	xor a,a
	out ($1D),a
	out ($1E),a
	ld a,2
	out ($1F),a
	ld bc,$1005  ;set wait states
	ld a,3
	out (bc),a
	ld c,$06
	ld a,6
	out (bc),a
	ld a,$81     ;configure stack protector
	out ($3A),a
	ld a,$98
	out ($3B),a
	ld a,$D1
	out ($3C),a
	ld a,$7C     ;configure protected memory region
	out ($20),a
	out ($23),a
	ld a,$88
	out ($21),a
	out ($24),a
	ld a,$D1
	out ($22),a
	out ($25),a
	ret
boot_check_os_signature:
	ld hl,$020100
	ld a,$5A
	cp a,(hl)
	ret nz
	add a,a ;$5A*2 = $A5
	inc hl
	cp a,(hl)
	ret
boot_invalid_os:
	ret
boot_interrupt_handler:
	ret

paduntil $1000
include 'cstd.asm'
include 'code.asm'
include 'rtc_code.asm'
include 'usb_code.asm'
include 'font.asm'
include 'loader.asm'

