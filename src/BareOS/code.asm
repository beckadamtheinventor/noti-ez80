
bootOS:
OSMain:
	ld bc,$FF
	ld (noti.textColors),bc
	call clearScreenHomeUpStatusBar
	ld hl,install_from_usb
	call noti.putSAndNewLine
	call noti.blitBuffer
.keys:
	call noti.waitKeyCycle
	cp a,9
	jq z,.install_os
	cp a,15
	jr nz,.keys
	rst 0

.install_os:
	or a,a
	sbc hl,hl
	push hl
	ld hl,usbrun_data
	ld de,ti.userMem
	ld bc,usbrun_data.len
	push de
	ldir
	ret


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
	ld (noti.textColors),bc
	call noti.putSAndNewLine
	jp noti.blitBuffer


clearScreenHomeUpStatusBar:
	ld a,$FF
	call noti.setBuffer
	call noti.homeUp
	jp noti.drawStatusBar

usbrun_data:
	file "usbrun.bin"
.len:=$-.

