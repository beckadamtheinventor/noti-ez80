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


;   Unknown - seems rarely used, might log data
_dbgout: ;$ = $000669
	ret ;prove riemann hypothesis for now



paduntil $23E9
;C standard library functions
file 'cstd.bin'


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
_WriteFlashA: ;probably here?
	
	; -- TODO --
	
	ret

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
	di
	call eraseSectorRaw
	ei
	ret
eraseSectorRaw:
; Flash program sequence
	ld	a, 0AAh	; First bus cycle---unlock
	ld	(0AAAh), a
	ld	a, 55h	; Second bus cycle---unlock
	ld	(0555h), a
	ld	a, 080h	; Third bus cycle---write command
	ld	(0AAAh), a
	ld	a, 0AAh	; Fourth bus cycle---unlock (again)
	ld	(0AAAh), a
	ld	a, 55h	; Fifth bus cycle---unlock (again)
	ld	(0555h), a
	ld	a, 30h ; Do not change this value. You could superbrick your calculator.
	ld	(hl), a
	ret


;   de = dest, hl = data, bc = size
_WriteFlash:

	; -- TODO --

	ret
.len:=$-.data



;   identical to _WriteFlashByte
_WriteFlashByteDuplicate:=_WriteFlashByte


;   TODO
_CleanupCertificate:=$00002EC

;   Empties out the OS heap
;   I think that only the bootcode directly accesses the heap, so you can implement it any way you want
_ClrHeap:

;   TODO: determine which registers are used
_CpyToHeap:


;   Probably returns the size of the heap in hl and the bottom of the heap in de?
_ChkHeapTop:

;   TODO: determine registers
_ExecuteInRAM:

;   Identical to _ExecuteInRAM
_ExecuteInRAMDup:

;   Identical to _ExecuteInRAM
_ExecuteInRAMDup2:


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
	ret


;   seems related to SHA and the certificate
;   maybe part of OS verification?
;   only called directly by boot code @ 12CEEh
_something_SHA_cert:
	ret


_FindAppHeaderTimestamp:


_boot_ClearVRAM:
	ld hl,vRam
	ld de,vRam+1
	ld bc,320*240*2
	ld (hl),$FF
	ldir
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

_boot_PutS:
	ld a,(hl)
	inc hl
	or a,a
	ret z
	call _boot_PutC
	jr _boot_PutS
_boot_PutC: ;taken and modified from Cesium
character_width:=8
character_height:=8
vRam:=$D40000
vRamBuffer:=vRam+ti.lcdWidth*ti.lcdHeight
	push	hl
	push	af
	push	de
	ld a,(ti.curCol)
	ld b,a
	inc a
	ld (ti.curCol),a
	ld a,b
	add a,a
	add a,a
	add a,a
	add a,b
	push	bc
	ld	a,(ti.curRow)
	inc a
	ld (ti.curRow),a
	dec a
	add a,a
	add a,a
	add a,a
	ld l,a
	ld	h,ti.lcdWidth / 2
	mlt	hl
	add	hl,hl
	ld	de,vRamBuffer
	add	hl,de
	add	hl,bc				; add x value
	push	hl
	sbc	hl,hl
	ld	l,a
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ex	de,hl
	ld	hl,boot_font
	add	hl,de				; hl -> correct character
	pop	de				; de -> correct location
	ld	a,character_width
.vert_loop:
	ld	c,(hl)
	ld	b,character_height
	ex	de,hl
;	push	de
.horiz_loop:
	rlc	c
	jr	nc,.bg
	ld	(hl),$FF
	jr .continue
.bg:
	ld	(hl),0
.continue:
	inc	hl
	djnz	.horiz_loop
	ld	(hl),$FF
	ld	bc,ti.lcdWidth - character_width
	add	hl,bc
;	pop	de
	ex	de,hl
	inc	hl
	dec	a
	jr	nz,.vert_loop
	pop	bc
	pop	de
	pop	af				; character
	pop	hl
	ret

_boot_wait_key:
	call _boot_kb_Scan
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

_boot_kb_Scan:
	di
	ld	hl,$f50200		; DI_Mode = $f5xx00
	ld	(hl),h
	xor	a,a
.loop:
	cp	a,(hl)
	jr	nz,.loop
	ret


_PutSpinner:


_boot_GetLFontPtr:


_boot_InitializeHardware:


_boot_TurnOffHardware:


_MakeColCmd:


_PutBootVersion:


_DrawSectorProtectionTable:


_boot_Set6MHzMode:


_boot_Set48MHzMode:


_boot_Set6MHzModeI:


_boot_Set48MHzModeI:


_CheckHardware:


_GetBatteryStatus:


;   wait 10 ms
_Delay10ms:


;   wait 10 * a ms
_DelayTenTimesAms:


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


_KeypadScan:


_KeypadScanFull:


_MarkOSInvalid:


_MarkOSValid:


_CheckIfEmulated:


_boot_GetOnInt:


_CheckEmulationBit:


_boot_SectorsBegin:
	ret

flash_unlock:
	ld	bc,$24
	ld	a,$8c
	out (bc),a
	ld	bc,$06
	in	a,(bc)
	or	a,4
	out (bc),a
	ld	bc,$28
	ld	a,$4
	out (bc),a
	ret

flash_lock:
	ld	bc,$28
	xor	a,a
	out (bc),a
	ld	bc,$06
	in a,(bc)
	res	2,a
	out (bc),a
	ld	bc,$24
	ld	a,$88
	out (bc),a
	ret

