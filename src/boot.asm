
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
;pad until $700. Hopefully enough room for standard bootcode functions
paduntil $700
	jp boot_wait_key_cycle
	jp _boot_SetVRAM
	jp _boot_SetBuffer
	jp boot_gfx_compute
	jp boot_gfx_horizontal
	jp boot_gfx_vertical
	jp boot_gfx_rectangle
	jp boot_gfx_filled_rectangle
	jp boot_homeup
	jp _boot_PutS
	jp _boot_PutC
	jp _boot_puts_and_new_line
	jp _boot_drawstatusbar
	jp _boot_blit_buffer
;pad until $7F0, place OpenCE bootcode notice, so OSs can take advantage of more jumps
paduntil $7F0
	db "OpenCE bootcode",0
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
	jq boot_menu

include 'menus.asm'
include 'code.asm'
include 'cstd.asm'
include 'rtc_code.asm'
include 'spi_code.asm'
include 'usb_code.asm'
include 'hexeditor.asm'

if defined calminstruction
	LEN_OF_CODE strcalc $-START_OF_CODE
	display "Main code length: ",LEN_OF_CODE,$0A
end if

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


string_oh_no:
	db "Oh no!",0
string_something_went_wrong:
	db "Something went wrong.",0
	db "Abort and "
string_restart:
	db "Restart.",0
string_error_message:
	db "Error message:",0


string_to_go_back:
	db "Press [clear] to go back",0

string_no_os:
	db "No OS installed; cannot boot.",0
string_boot_version:
	db "OpenCE bootcode",0,"version 0.01.0008",0

string_erase_sector:
	db "This will erase the currently selected flash sector.",0
string_are_you_sure:
	db "Are you sure?",0

string_press_enter_confirm:
	db "Press [enter] to confirm",0

if defined calminstruction
	LEN_OF_DATA strcalc $-START_OF_DATA
	display "Data length: ",LEN_OF_DATA,$0A
end if
ScrapMem:=$D02AD7
FlashByte:=$D00125
BaseSP:=$D1A87E
textColors:=$D1887C-3

