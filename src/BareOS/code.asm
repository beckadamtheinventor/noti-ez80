
interruptHandler:
; in current state of openCE, this is needed (extra push from boot)
	pop hl
; acknowledge interrupt
	ld hl, $F00014
	ld bc, (hl)
	ld l, $F00008 and $FF
	ld (hl), bc
	pop iy
	pop ix
	exx
	ex af,af'
	ei
	ret
rst10Handler:
rst18Handler:
rst20Handler:
rst28Handler:
rst30Handler:
bootOS:
	call testIsOpenCE
	jq z,bootOpenCEOS
	jp ti.MarkOSInvalid
testIsOpenCE:
	ld bc,oce.identifier_location
	push bc
	ld bc,string_OpenCE_bootcode
	push bc
	call ti._strcmp
	xor a,a
	or a,l
	pop bc,bc
	ret
bootOpenCEOS:
	call fs_build_VAT
	ld hl,fs_temp_name_start
	ld (fs_temp_name_ptr),hl
OSMain:
	ld bc,$FF
	ld (oce.textColors),bc
	call clearScreenHomeUpStatusBar
	ld hl,string_welcome
	call oce.putSAndNewLine
	call oce.blitBuffer
.keys:
	call oce.waitKeyCycle
	cp a,9
	jq z,.console
	cp a,15
	jr nz,.keys
	call clearScreenHomeUpStatusBar
	ld hl,string_return_to_OpenCE
	call oce.putSAndNewLine
	call oce.putSAndNewLine
	call oce.blitBuffer
	call oce.waitKeyCycle
	cp a,9
	jr nz,OSMain
	call ti.boot.TurnOffHardware
	rst 0
.console:
	call console
	jq OSMain
console:
	ld bc,64
	push bc
	ld bc,tempMem
	push bc
	call get_user_input
	call nextLine
	pop hl
	pop bc
	ld a,(hl)
	or a,a
	ret z
	push hl
	call process_command
	pop bc
	jq console


nextLine:
	ld a,(ti.curRow)
	cp a,20
	jq nc,scrollText
	inc a
	ld (ti.curRow),a
	ret

scrollText:
	ld de,vRamBuffer+320*18
	ld hl,vRamBuffer+320*28
	ld bc,320*(240-28)
	ldir
	ret

ErrorHandler:
	ld bc,$80FF
	ld (oce.textColors),bc
	call oce.putSAndNewLine
	jp oce.blitBuffer


clearScreenHomeUpStatusBar:
	ld a,$FF
	call oce.setBuffer
	call oce.homeUp
	jp oce.drawStatusBar

