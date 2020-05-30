
	di
	rsmix
	jp.lil boot_check_os ;$000E4F ;rst 00
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
	ld sp,$D1887C
	jp boot_boot_os ;$0220A8

paduntil $66
nmi_handler:
	push af
	in0 a,($3D)
	and a,$03
	out0 ($3E),a
	jr z,boot_check_os
	pop af
	ld sp,$D1887C
	jp boot_boot_os

paduntil $80

;follow with the jump table
include 'table.asm'

boot_setup_hardware:
	ld a,$03
	out0 ($00),a
	ld bc,$500C
	in a,(bc)
	set 4,a
	out (bc),a
	ld c,4
	in a,(bc)
	set 4,a
	out (bc),a
	xor a,a
	out0 ($1D),a
	out0 ($1E),a
	ld a,2
	out0 ($1F),a
	ld bc,$1005  ;set wait states
	ld a,3
	out (bc),a
	ld c,$06
	ld a,6
	out (bc),a
	ld a,$81     ;configure stack protector
	out0 ($3A),a
	ld a,$98
	out0 ($3B),a
	ld a,$D1
	out0 ($3C),a
	ld a,$7C     ;configure protected memory region
	out0 ($20),a
	out0 ($23),a
	ld a,$88
	out0 ($21),a
	out0 ($24),a
	ld a,$D1
	out0 ($22),a
	out0 ($25),a
	in0 a,($06) ;set bit 0
	set 0,a
	out0 ($06),a
	ld de,$4000
	ld hl,LCD_Controller_init_data
	ld bc,LCD_Controller_init_data.len
	oti2r
	in0 a,($07)
	set 2,a
	out0 ($07),a
	in0 a,($09)
	set 2,a
	out0 ($09),a
	call boot_Delay10ms
	in0 a,($09)
	res 2,a
	out0 ($09),a
	ld a,$05
	call boot_Delay10timesAms
	in0 a,($09)
	set 2,a
	out0 ($09),a
	ld a,$0C
	call boot_Delay10timesAms
	ld bc,$D006
	ld a,2
	out (bc),a
	ld c,$01
	ld a,$18
	out (bc),a
	ld a,$0B
	out (bc),a
	ld c,$04
	out (bc),a
	inc c
	out (bc),a
	ld c,$08
	ld a,$0C
	out (bc),a
	inc c
	ld a,$01
	out (bc),a
	ld a,$11
	call spiCmd
	ld a,$0C
	call boot_Delay10timesAms
	ld hl,SpiDefaultCommands
	ld b,SpiDefaultCommands.len
.loop:
	ld a,(hl)
	inc hl
	push hl
	push bc
	call spiCmd
	pop bc
	pop hl
	djnz .loop
	in0 a,($05)
	set 4,a
	res 6,a
	out0 ($05),a
	ld bc,$B020
	ld a,$FF
	out (bc),a
	inc c
	xor a,a
	out (bc),a
	inc c
	out (bc),a
	inc a
	out (bc),a
	in0 a,($05)
	set 6,a
	out0 ($05),a
_boot_set_8bpp_xlibc_mode:
	ld hl,$E30200				; palette mem
	ld b,0
.loop:
	ld d,b
	ld a,b
	and a,$C0
	srl d
	rra
	ld e,a
	ld a,$1F
	and a,b
	or a,e
	ld (hl),a
	inc hl
	ld (hl),d
	inc hl
	inc b
	jr nz,.loop
	ld a,$27
	ld ($E30018),a
	ret
	; Input: A = parameter
spiParam:
	scf ; First bit is set for data
	db 030h ; jr nc,? ; skips over one byte
	; Input: A = command
spiCmd:
	or a,a ; First bit is clear for commands
	ld hl,$F80818
	call spiWrite
	ld l,h
	ld (hl),$01
.spiWait:
	ld l,$0D
.spiWait1:
	ld a,(hl)
	and a,$F0
	jr nz,.spiWait1
	dec l
.spiWait2:
	bit 2,(hl)
	jr nz,.spiWait2
	ld l,h
	ld (hl),a
	ret
spiWrite:
	ld b,3
.spiWriteLoop:
	rla
	rla
	rla
	ld (hl),a ; send 3 bits
	djnz .spiWriteLoop
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

boot_boot_os:
	call boot_setup_hardware
	call boot_check_os_signature
	jp z,$0220A8

boot_invalid_os:
	ld hl,string_no_os
	call _dbgerrorputs
	call _boot_ClearVRAM
	call _boot_homeup
	ld hl,string_no_os+1
	call _boot_puts_and_new_line
	call _boot_blit_buffer
boot_trap:
	jr .
boot_interrupt_handler:
	jp $0220A8

paduntil $1000
include 'cstd.asm'
include 'code.asm'
include 'rtc_code.asm'
include 'usb_code.asm'
include 'font.asm'
include 'loader.asm'

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


string_no_os:
	db $0A,"No OS installed; cannot boot.",0

ScrapMem:=$D02AD7
