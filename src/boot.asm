
	di
	rsmix
	jp.lil boot_validate_os ;$000E4F ;rst 00
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
	ex af,af' ;'
	exx
	push ix
	push iy
	ld iy, $D00080
	jp boot_interrupt_handler
paduntil $47
;$ = $47. Validate/check OS
boot_validate_os:
	ld sp,BaseSP
	jp boot_boot_os ;$0220A8

paduntil $66
nmi_handler:
	in0 a,($3D)
	and a,$03
	out0 ($3E),a
	jr z,boot_validate_os
	rst 0

paduntil $80

;follow with the jump table
include 'table.asm'
include 'table2.asm'
START_OF_CODE:

boot_interrupt_handler:
	in0 a,($06)
	bit 2,a
	jr z,.dontsetport06
	ld a,3
	out0 ($06),a
.dontsetport06:
	ld hl,($D02AD7)
	push hl
	call boot_check_os_signature
	jp z,$02010C
	ld a,($020000)
	cp a,$FF
	jq z,boot_menu

boot_interrupt_acknowledger:
	ld bc,$5015
	in a,(bc)
	jr z,handle_interrupt_2
	ld c,$09
	rla
	rla
	jq c,high_bit_6_int
	rla
	jq c,high_bit_5_int
	rla
	jq c,high_bit_4_int
	rla
	jq c,high_bit_3_int
	ld a,$FF
	out (bc),a
	jq return_from_interrupt
handle_interrupt_2:
	ld c,$14
	in a,(bc)
	jr z,return_from_interrupt
	ld c,$08
	rra
	jq c,low_bit_0_int
	rra
	jq c,low_bit_1_int
	rra
	jq c,low_bit_2_int
	rra
	jq c,low_bit_3_int
	rra
	jq c,low_bit_4_int
	ld a,$FF
	out (bc),a
return_from_interrupt:
	ld iy,$D00080
	res 6,(iy+$1B)
	pop hl
	pop iy,ix
	exx
	ex af,af'
	ei
	reti

low_bit_0_int:
	ld a,1 shl 0
	out (bc),a
	ld c,4
	in a,(bc)
	res 0,a
	out (bc),a
	jq return_from_interrupt
low_bit_1_int:
	ld a,1 shl 1
	out (bc),a
	ld c,4
	in a,(bc)
	res 1,a
	out (bc),a
	jq return_from_interrupt
low_bit_2_int:
	ld a,1 shl 2
	out (bc),a
	ld c,4
	in a,(bc)
	res 2,a
	out (bc),a
	jq return_from_interrupt
low_bit_3_int:
	ld a,1 shl 3
	out (bc),a
	ld c,4
	in a,(bc)
	res 3,a
	out (bc),a
	jq return_from_interrupt
low_bit_4_int: ;OS timer interrupt
	ld a,1 shl 4
	out (bc),a
	ld c,4
	in a,(bc)
	res 4,a
	out (bc),a
	jq return_from_interrupt
high_bit_3_int:
	ld a,1 shl 3
	out (bc),a
	ld c,5
	in a,(bc)
	res 3,a
	out (bc),a
	jq return_from_interrupt
high_bit_4_int:
	ld a,1 shl 4
	out (bc),a
	ld c,5
	in a,(bc)
	res 4,a
	out (bc),a
	jq return_from_interrupt
high_bit_5_int: ;USB interrupt
	ld a,1 shl 5
	out (bc),a
	ld c,5
	in a,(bc)
	res 5,a
	out (bc),a
	jq return_from_interrupt
high_bit_6_int:
	ld a,1 shl 6
	out (bc),a
	ld c,5
	in a,(bc)
	res 6,a
	out (bc),a
	jq return_from_interrupt



include 'menus.asm'
include 'code.asm'
include 'gfx.asm'
include 'cstd.asm'
include 'rtc_code.asm'
include 'spi_code.asm'
include 'usb_code.asm'
include 'routines.asm'

include 'hexeditor.asm'
; include 'restore.asm'

	LEN_OF_CODE strcalc $-START_OF_CODE
	display "Main code length: ",LEN_OF_CODE,$0A

START_OF_DATA:
include 'font.asm'
LCD_Controller_init_data:
	db $38,$03,$0A,$1F
	db $3F,$09,$02,$04
	db $02,$78,$EF,$00
	db $00,$00,$00,$00
	db $00,$00,$D4,$00
	db $00,$00,$00,$00
	db $2D,$09,$00,$00
	db $0C,$00,$00,$00
.len:=$-.

SpiDefaultCommands:
	db $36,$08,$3A,$66
	db $2A,$00,$00,$01
	db $3F,$2B,$00,$00
	db $00,$EF,$B2,$0C
	db $0C, $00, $33, $33, $C0, $2C, $C2, $01, $C4
	db $20, $C6, $0F, $D0, $A4, $A1, $B0, $11, $F0
	db $C0, $22, $E9, $08, $08, $08, $DC, $B7, $35
	db $BB, $17, $C3, $03, $D2, $00, $E0
	db $D0, $00, $00, $10, $0F, $1A, $2D, $54, $3F
	db $3B, $18, $17, $13, $17, $E1, $D0, $00, $00
	db $10, $0F, $09, $2B, $43, $40, $3B, $18, $17
	db $13, $17, $B1, $01, $05, $14, $26, $00
.len:=$-.


include 'strings.asm'

	LEN_OF_DATA strcalc $-START_OF_DATA
	display "Data length: ",LEN_OF_DATA,$0A



ScrapMem:=ti.scrapMem
FlashByte:=ti.flashByte
BaseSP:=ti.stackTop
textColors:=$D1887C
curHeapPtr:=$D1887C+3
asm_program_size:=$D1887C+6
start_of_dynamic_lib_ptr:=$D1887C+9
end_of_dynamic_lib:=$D3FFFF
baseHeap:=$D1887C+12
exec_memory:=$D1A881
