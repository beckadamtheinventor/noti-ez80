
	di
	rsmix
	jp.lil loader_rst00_handler ;$000E4F ;rst 00
	di
	rsmix
	jp.lil loader_abort_and_restart ;rst 08
	di
	rsmix
	jp.lil loader_rst10_handler ;$020110 ;rst 10
	di
	rsmix
	jp.lil loader_rst18_handler ;$020114 ;rst 18
	di
	rsmix
	jp.lil loader_rst20_handler ;$020118 ;rst 20
	di
	rsmix
	jp.lil loader_rst28_handler ;$02011C ;rst 28
	di
	rsmix
	jp.lil loader_rst30_handler ;$020120 ;rst 30
handle_rst38: ;rst 38
	ex af,af'
	exx
	push ix
	push iy
	ld iy, $D00080
	jp $000654
;$ = $47. Not sure what this does
	push hl
	push bc
	call $0006C6 ;--!-- fix this --!--
	pop bc
	pop hl
	jp nz,$00140C
	pop af
	jp loader_bcall_handler ;$0220A8 ;OS bcall handler?

paduntil $66
flash_nmi_handler:
	push af
	in0 a,($3D)
	and a,$03
	out0 ($3E),a
	jr z,$000047
	pop af
	jp $0015F5

paduntil $80

;follow with the jump table
include 'table.asm'

paduntil $1000
include 'code.asm'
include 'rtc_code.asm'
include 'usb_code.asm'
include 'font.asm'

