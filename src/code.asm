;$ = $000654

;   Gets boot code major version in a
;   Gets boot code minor version in b
_boot_maj_min_ver:
	ld a,5
	ld b,1
_riemann:
	ret

;   Gets hardware version (7) in a
_boot_GetHardwareVers:
	ld a,7
	ret

;   Gets key ID into hl (It's 1370h for me)
_boot_GetKeyID: ;$ = $00065C
	ld hl,$1370
	ret

;   Gets boot code revision version in a
_boot_GetBootVerMinor: ;$ = $000661
	ld a,1
	ret

;   Gets boot code build number in ab
_boot_GetBootVerBuild: ;$ = $000664
	ld a,0
	ld b,0
	ret

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
	xor a,a      ;set priviledged memory region ($<0x100000)
	out0 ($1D),a
	out0 ($1E),a
	ld a,$10
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
	call spi.WriteCmd
	ld a,$0C
	call boot_Delay10timesAms
	ld hl,SpiDefaultCommands
	ld b,SpiDefaultCommands.len
.loop:
	ld a,(hl)
	inc hl
	push hl
	push bc
	call spi.WriteCmd
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

boot_check_os_signature:
	ld hl,$020100
	ld a,$5A
	cp a,(hl)
	ret nz
	ld a,$A5
	inc hl
	cp a,(hl)
	ret

;log data to emulator console
_dbgout:
_dbgputs:
	ld de,$FB0000
	jr _dbgerrorputs.puts
_dbgerrorputs:
	ld de,$FC0000
.puts:
	xor a,a
	ld (de),a
.loop:
	ldi
	cp a,(hl)
	jr nz,.loop
	ret

_boot_OutBC_s:
	out (bc),l
	inc c
	out (bc),h
	inc c
	ret

_boot_InBC_s:
	in l,(bc)
	inc c
	in h,(bc)
	inc c
	ret

boot_memset:
	push hl
	pop de
	inc de
	ldir
	ret



include 'routines/strtok.asm'
;include 'routines/printf.asm'
;include 'routines/sprintf.asm'
include 'routines/FLTMAX.asm'


;   Doesn't seem to be used by TI-OS - breakpoint did nothing
;   Is only called directly in the bootcode by a function at 32F4h
;   TODO: investigate more
_ResetPorts:
	ret


;   Checks if OS is valid and ready to receive an interrupt
;   Returns nz if not ready or z if ready
_ChkIfOSInterruptAvailable:
	ret

; https://www.winbond.com/resource-files/w29gl032c_revh%20v3.0.pdf
; these normally contain some safety measures
; but who cares about those
; some notes about flash:
; you have to set a port, then read a special sequence from flash itself - see wikiti
; also, while programming flash, you can't read code from flash, so you have to copy to RAM
; also, CEmu doesn't emulate flash remotely close to perfectly - either PR a fix or use CEmu's mem.c as a reference



; B = byte to write
; DE = Address to write to
_WriteFlashByte:
	ld a,b
_WriteFlashA:
	push af
	call flash_unlock
	pop af
	ld hl,FlashByte
	ld (hl),a
	ld bc,1
	ld ix,write_flash_bytes_raw
	call _ExecuteInRAM
	jp flash_lock

write_flash_bytes_raw:
	dw .len
	ld (ScrapMem),hl
	ld a,(ScrapMem+2)
	cp a,$02
	ret c
	cp a,$D0
	ccf
	ret c
.byte_loop:
	ld a,($00007E)
	bit 6,a
	jr z,.skip_command
	ld hl,$AAA
	ld (hl),$AA
	ld a,$55
	ld ($000555),a
	ld (hl),$A0
.skip_command:
	ld a,(hl)
	ld (de),a
	push bc
	ld c,a
.wait:
	ld a,(de)
	cp a,c
	jr nz,.wait
	pop bc
	inc de
	inc hl
	xor a,a
	dec bc
	ret po
	jr .byte_loop
.len:=$-.

; HL = sector address to erase
_EraseFlash:
	ld (ti.scrapMem),hl
	ld a,(ti.scrapMem+2)
	;just run into the next routine for optimization
;   a = sector to erase
;   there's a bug in here where it pops one item too many from flash, I think
_EraseFlashSector:
	or a,a
	sbc hl,hl
	ld l,a
	call flash_unlock
	ld ix,eraseSectorRaw
	call _ExecuteInRAM
	jp flash_lock
eraseSectorRaw:
	dw .len
; Flash program sequence
	ex hl,de
	ld hl,$AAA
	ld	c, $AA
	ld	(hl), c
	ld	a, $55
	ld	($555), a
	ld	(hl), $80
	ld	(hl), c
	ld	a, $55
	ld	($555), a
	ld	a, $30 ; Do not change this value. You could superbrick your calculator.
	ld	(de), a
	ret
.len:=$-.

;   de = dest, hl = data, bc = size
_WriteFlash:
	call flash_unlock
	ld ix,write_flash_bytes_raw
	call _ExecuteInRAM
flash_lock:
	xor a,a
	out0 ($1D),a
	out0 ($1E),a
	ld a,$10
	out0 ($1F),a
	in0 a,($28)
	and a,3
	out0 ($28),a
	ret
flash_unlock:
	ld a,$FF
	out0 ($1D),a
	out0 ($1E),a
	out0 ($1F),a
	in0 a,($06)
	set 2,a
	out0 ($06),a
	ld a,$04
    di
    jr $+2
    di
    rsmix
    im 1
    out0 ($28),a
    in0 a,($28)
    bit 2,a
    ret

;   identical to _WriteFlashByte
_WriteFlashByteDuplicate:=_WriteFlashByte


;   TODO
_CleanupCertificate:;=$00002EC

;   Empties out the OS heap
;   I think that only the bootcode directly accesses the heap, so you can implement it any way you want
_ClrHeap:

;   TODO: determine which registers are used
_CpyToHeap:


;   Probably returns the size of the heap in hl and the bottom of the heap in de?
_ChkHeapTop:

; input ix routine to execute.
; routine must begin with two-byte length of routine
_ExecuteInRAM:
	push af
	push hl
	push de
	push bc
	lea hl,ix
	ld bc,0
	ld c,(hl)
	inc hl
	ld b,(hl)
	inc hl
	ex hl,de
	ld hl,$D18C7C
	or a,a
	sbc hl,bc
	ex hl,de
	push de
	ldir
	pop ix
	pop bc
	pop de
	pop hl
	pop af
	jp (ix)
	

;   Identical to _ExecuteInRAM
_ExecuteInRAMDup:=_ExecuteInRAM

;   Identical to _ExecuteInRAM
_ExecuteInRAMDup2:=_ExecuteInRAM


_ChkCertSpace:


_GetFieldSizeFromType:


_FindFirstCertField:


_FindField:


_FindNextField:


_GetCertificateEnd:


_GetFieldFromSize:


_NextFieldFromSize:


_NextFieldFromType:


_GetOffsetToNextField:


_WriteFlashUnsafe:


_boot_GetCertCalcString:


_boot_GetCertCalcID:


_GetSerial:

;   called from within bootcode at 1057h
;   called at 40D55h
;   seems to have something to do with the certificate
_something_cert_related:
	ret

_Mult16By8: ; DE * A
	ld l,a
	ld h,d
	mlt hl ;hl = d*a
	ld d,a
	mlt de ;de = e*a
	push hl
	inc sp
	pop hl ;hl = hl<<8 + l
	dec sp
	ld l,0 ;hl = hl - l
	add hl,de ;hl = hl + de
	ret

_Div16By8: ; DE / A --> HL rem DE (?)
	cp a,2
	ret c
.rr_loop:
	srl a
	jr c,.next
	bit 0,e
	jr nz,.next
	srl d
	rr e
	jr .rr_loop
.next:
	rlca
	or a,a
	sbc hl,hl
	ex hl,de
	ld e,a
	or a,a
.div_entry:
	ld bc,0
.div_loop:
	inc bc
	sbc hl,de
	jr nc,.div_loop
	add hl,de
	ex hl,de
	push bc
	pop hl
	ret

_Div16By16: ; DE / HL --> HL rem DE (?)
	xor a,a
	cp a,h
	jr nz,.rr_loop
	inc a
	cp a,l
	ret nc
.rr_loop:
	srl h
	rr l
	jr c,.next
	bit 0,e
	jr nz,.next
	srl d
	rr e
	jr .rr_loop
.next:
	rl l
	rl h
	or a,a
	ex hl,de
	jr _Div16By8.div_entry


_Div32By16:


_CmpStr:
	ret


_boot_Sha256Init:
_boot_Sha256Part:
_boot_Sha256Hash:
	ret
_FindAppHeaderSubField:
_FindSimpleGroupedField:
	ret


;   seems related to SHA and the certificate
;   maybe part of OS verification?
;   only called directly by boot code @ 12CEEh
_something_SHA_cert:
	ret


_FindAppHeaderTimestamp:

_boot_ZeroVRAM:
	xor a,a
	jr _boot_SetVRAM
_boot_ClearVRAM:
	ld a,$FF
_boot_SetVRAM:
	ld hl,vRam
	ld de,vRam+1
	ld bc,320*240
	ld (hl),a
	ldir
	ret
_boot_ZeroBuffer:
	xor a,a
	jr _boot_SetBuffer
_boot_ClearBuffer:
	ld a,$FF
_boot_SetBuffer:
	ld hl,vRamBuffer
	ld de,vRamBuffer+1
	ld bc,320*240
	ld (hl),a
	ldir
	ret

_boot_homeup:
	xor a,a
	ld (ti.curCol),a
	ld (ti.curRow),a
	ret

_boot_drawstatusbar:
	push ix
	ld a,$9D
	ld (textColors+2),a
	or a,a
	sbc hl,hl
	ld e,l
	ld a,18
	ld bc,ti.lcdWidth
	call boot_gfx_filled_rectangle
	or a,a
	sbc hl,hl
	ld e,18
	ld bc,ti.lcdWidth
	ld a,$7D
	call boot_gfx_horizontal
	pop ix
	ret
_PutSpinner:
	ld hl,vRam+317
	ld de,ti.lcdWidth-1
	ld b,17
	ld a,(hl)
	or a,a
	jr z,.loop
	cp a,$E5
	jr z,.loop
	ld a,$E5
.setloop:
	ld (hl),a
	inc hl
	ld (hl),a
	xor a,$E5
	add hl,de
	djnz .setloop
	ret
.loop:
	ld a,(hl)
	xor a,$E5
	ld (hl),a
	inc hl
	ld (hl),a
	add hl,de
	djnz .loop
	ret

_boot_puts_and_new_line:
	call _boot_PutS
_boot_NewLine:
	xor a,a
	ld (ti.curCol),a
	ld a,(ti.curRow)
	inc a
	ld (ti.curRow),a
	ret

_boot_blit_buffer:
	ld hl,vRamBuffer
	ld de,vRam
	ld bc,ti.lcdWidth*ti.lcdHeight
	ldir
	ret

_boot_PutS:
	ld a,(hl)
	inc hl
	or a,a
	ret z
	call _boot_PutC
	jr _boot_PutS

_boot_PutC: ;taken and modified from Cesium
	push	hl
character_width:=8
character_height:=8
vRam:=$D40000
vRamBuffer:=vRam+ti.lcdWidth*ti.lcdHeight
	push af
	ld a,(ti.curCol)
	ld b,a
	inc a
	ld (ti.curCol),a
	ld c,9
	mlt bc
	inc bc
	inc bc
	ld	a,(ti.curRow)
	add a,3
	ld l,a
	add a,a
	add a,a
	add a,a
	add a,l
	ld l,a
	ld	h,ti.lcdWidth / 2
	mlt	hl
	add	hl,hl
	ld	de,vRamBuffer
	add	hl,de
	add	hl,bc				; add x value
	pop		af
	push	hl
	or a,a
	sbc	hl,hl
	ld	l,a
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	de,boot_font
	add	hl,de				; hl -> correct character
	pop	de				; de -> correct location
	ld	a,character_width
.vert_loop:
	ld	c,(hl)
	ld	b,character_height
	ex	de,hl
	push	de
	ld de,(textColors) ;text colors
.horiz_loop:
	rlc	c
	jr c,.fg
	ld (hl),e
	db $38 ;jr c
.fg:
	ld	(hl),d
	inc	hl
	djnz	.horiz_loop
	ld	(hl),e
	ld	bc,ti.lcdWidth - character_width
	add	hl,bc
	pop	de
	ex	de,hl
	inc	hl
	dec	a
	jr	nz,.vert_loop
	ld a,(ti.curCol)
	cp a,30
	call nc,_boot_NewLine
	pop hl
	ret

_boot_wait_key:
	call boot_scan_keypad
_boot_get_key:
	ld hl,$F50012
	ld b,7
	ld c,49
.scanloop:
	ld a,(hl)
	or a,a
	jr nz,.keyispressed
	inc hl
	inc hl
	ld a,c
	sub a,8
	ld c,a
	djnz .scanloop
	xor a,a
	ret
.keyispressed:
	ld b,8
.keybitloop:
	rrca
	jr c,.this
	inc c
	djnz .keybitloop
.this:
	ld a,c
	ret



_boot_GetLFontPtr:
	ld hl,boot_font
	ret

_boot_TurnOffHardware:
	call _boot_BacklightOff
	ld a,$10
	call spi.WriteCmd
	call boot_Delay10ms
	ld bc,$4019
	ld a,1
	out (bc),a
	ld a,$0A
	call boot_Delay10timesAms
	dec c
	ld a,$2C
	out (bc),a
	ld bc,$D000
	ld a,$09
	out (bc),a
	ret
_boot_BacklightOff:
	ld bc, $B024
	ld a, $FF
	out (bc),a
	call boot_Delay10ms
	in0 a, ($05)
	res 6, a
	res 4, a
	out0 ($05), a
	ret

_MakeColCmd:


_PutBootVersion:
	call _boot_homeup
	ld hl,string_boot_version
	jp _boot_puts_and_new_line

_DrawSectorProtectionTable:


_boot_Set6MHzMode:
	ret

_boot_Set48MHzMode:
	ret

_boot_Set6MHzModeI:
	xor a,a
	out ($01),a
	ret

_boot_Set48MHzModeI:
	ld a,3
	out ($01),a
	ret

_CheckHardware:


_GetBatteryStatus:




boot_Delay10timesAms:
	or a,a
	ret z
	call boot_Delay10ms
	dec a
	jr .

; bunch of undocumented functions that crash the calc if ports are wrong
;                          equ 00003BCh
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
;                          equ 00003C0h
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
;                          equ 00003C4h
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting and after turning off
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
;                          equ 00003C8h
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong


_MarkOSInvalid:


_MarkOSValid:


_CheckIfEmulated:


_boot_GetOnInt:


_CheckEmulationBit:


_boot_SectorsBegin:
	ret

boot_wait_key_cycle:
	call boot_wait_key
	push af
.loop:
	call boot_get_keycode
	or a,a
	jr nz,.loop
	pop af
	ret
boot_wait_key:
	call boot_get_keycode
	or a,a
	jr z,.
	ret

boot_get_keycode:
	call boot_scan_keypad
	ld hl,$F50012
	ld b,7
	ld c,49
.scanloop:
	ld a,(hl)
	or a,a
	jr nz,.keyispressed
	inc hl
	inc hl
	ld a,c
	sub a,8
	ld c,a
	djnz .scanloop
	xor a,a
	ret
.keyispressed:
	ld b,8
.keybitloop:
	rrca
	jr c,.this
	inc c
	djnz .keybitloop
.this:
	ld a,c
	ret

_KeypadScan:
_KeypadScanFull:
boot_scan_keypad:
	di             ; Disable interrupts
	ld hl,$F50000
	ld (hl),2      ; Set Single Scan mode
.wait:
	call _PutSpinner
	ld hl,$F50000
	xor a,a
	cp a,(hl)      ; Wait for Idle mode
	jr nz,.wait
	ret

boot_Delay250ms:
	ld b,25
.loop:
	call boot_Delay10ms
	djnz .loop
	ret

boot_Delay10ms:
	push bc
	ld c,100
.outer:
	ld b,0
.inner:
repeat 12
	nop
end repeat
	djnz .inner
	ld b,44
	dec c
	jr nz,.inner
	pop bc
	ret

boot_homeup:
	xor a,a
	ld (ti.curCol),a
	ld (ti.curRow),a
	ret

; bc = width
; hl = x coordinate
; e = y coordinate
; a = height
boot_gfx_filled_rectangle:
	ld	d,ti.lcdWidth / 2
	mlt	de
	add	hl,de
	add	hl,de
	ex	de,hl
.computed:
	ld	ix,vRamBuffer			; de -> place to begin drawing
.loop:
	add	ix,de
	lea	de,ix
	ld	hl,textColors+2		; always just fill with the primary color
	ldi					; check if we only need to draw 1 pixel
	jp	po,.skip
	inc bc
	scf
	sbc	hl,hl
	add	hl,de
	push bc
	ldir					; draw the current line
	pop bc
.skip:
	ld	de,ti.lcdWidth			; move to next line
	dec	a
	jr	nz,.loop
	ret

boot_gfx_rectangle:
	push	bc
	push	hl
	push	de
	call	boot_gfx_horizontal			; top horizontal line
	pop	bc
	push	bc
	call	boot_gfx_vertical.computed		; left vertical line
	pop	bc
	pop	hl
	ld	e,c
	call	boot_gfx_vertical			; right vertical line
	pop	bc
	jr	boot_gfx_horizontal.computed		; bottom horizontal line

; hl = x
; e = y
; a = color
; bc = length
boot_gfx_horizontal:
	call	boot_gfx_compute			; hl -> drawing location
.computed:
	jp	boot_memset

; hl = x
; e = y
; a = color
; b = length
boot_gfx_vertical:
	dec	b
	call	boot_gfx_compute			; hl -> drawing location
.computed:
	ld	de,ti.lcdWidth
.loop:
	ld	(hl),a				; loop for height
	add	hl,de
	djnz	.loop
	ret

boot_gfx_compute:
	ld	d,ti.lcdWidth / 2
	mlt	de
	add	hl,de
	add	hl,de
	ld	de,vRamBuffer
	add	hl,de
	ret

