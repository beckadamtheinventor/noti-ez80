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
	ld hl,$010100
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
	push ix
	ld ix,write_flash_bytes_raw
	call _ExecuteInRAM
	pop ix
	jq flash_lock

write_flash_bytes_raw:
	dw .len
.code:
	ld (ScrapMem),de
	ld a,(ScrapMem+2)
	cp a,$02
	ret c
	cp a,$D0
	ccf
	ret c
	ld a,($00007E)
	bit 6,a
	jr z,.skip_command
	push hl
	ld hl,$AAA
	ld (hl),$AA
	ld a,$55
	ld ($555),a
	ld (hl),$A0
	pop hl
.skip_command:
	push bc
	ld a,(de)
	and a,(hl)
	ld (de),a
	ld c,a
.wait:
	ld a,(de)
	cp a,c
	jr nz,.wait
	pop bc
	inc hl
	inc de
	xor a,a
	dec bc
	ld (ScrapMem),bc
	ld a,(ScrapMem+2)
	or a,b
	or a,c
	jr nz,.code
	ret
.len:=$-.code

; HL = sector address to erase
_EraseFlash:
	ld (ScrapMem),hl
	ld a,(ScrapMem+2)
	;just run into the next routine for optimization
;   a = sector to erase
_EraseFlashSector:
	cp a,$02
	ret c
	cp a,$D0
	ccf
	ret c
	or a,a
	sbc hl,hl
	ld (ScrapMem),hl
	ld (ScrapMem+2),a
	ld hl,(ScrapMem)
	call flash_unlock
	push ix
	ld ix,eraseSectorRaw
	call _ExecuteInRAM
	pop ix
	jq flash_lock

eraseSectorRaw:
	dw .len
; Flash program sequence
.code:
	ex hl,de
	ld hl,$AAA
	ld	c,$AA
	ld	(hl),c
	ld	a,$55
	ld	($555),a
	ld	(hl),$80
	ld	(hl),c
	ld	($555),a
	ex hl,de
	ld	(hl),$30 ; Do not change this value. You could superbrick your calculator.
	ld h,$FF
	ld l,h
.loop:
	ld a,(hl)
	cp a,$FF
	jr nz,.loop
	ret
.len:=$-.code

;   de = dest, hl = data, bc = size
_WriteFlash:
	call flash_unlock
	push ix
	ld ix,write_flash_bytes_raw
	call _ExecuteInRAM
	pop ix
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
_ClrHeap:=_clearHeap

;   TODO: determine which registers are used
_CpyToHeap:=_heapAlloc


;   Probably returns the size of the heap in hl and the bottom of the heap in de?
_ChkHeapTop:
	ld hl,(curHeapPtr)
	ret

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


_FindAppHeaderTimestamp:
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

