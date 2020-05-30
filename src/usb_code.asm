
;bit 7 of port $0F
;return nz if bus is receiving power
_usb_IsBusPowered:
	in a,($0F)
	bit 7,a
	ret

;bit 6 or 7 of port $000F
;return nz if bus is powered_usb_BusPowered:
_usb_BusPowered:
	in a,($0F)
	and a,$C0
	ret

;bit 6 of port $0F
;return nz if bus is self-powered
_usb_SelfPowered:
	in a,($0F)
	bit 6,a
	ret


_usb_SetDeviceB:
	ld bc,$3080
	in a,(bc)
	or a,3 ;set bits 0 and 1
	out (bc),a
	ret

_usb_DMACXReadNext:
	ld hl,-2
	call _frameset
	ld bc,$4000
	push bc
	ld hl,($D14040)
	xor a,a
	sbc.s hl,bc
	jr nc,.next
	ld b,a
	ld a,($D14040)
	ld c,a
	or a,a
	ld hl,($D14040)
	sbc.s hl,bc
.next:
	push hl
	pop bc
	ld hl,$D14040
	ld (hl),c
	inc hl
	ld (hl),b
	ld bc,($D14023)
	push bc
	call _usb_DMACXRead
	pop bc
	pop bc
	call _stoiu
	ld bc,($D14023)
	add hl,bc
	ld ($D14023),hl
	ld a,1
	ld ($D140B2),a
	ld hl,($D14040)
	call _scmpzero
	jr nz,.exit
	ld bc,0
	ld ($D140AF),bc
.exit:
	ld sp,ix
	pop ix
	ret

_usb_DMACXWrite:
	call _frameset0
	ld hl,(ix+$09)
	call _scmpzero
	jr z,.exit
	ld bc,$10
	push bc
	call _Out_31C0_b
	push bc
	call _usb_SetDMAAddress
	pop bc
	ld hl,1
	push hl
	push bc
	call _usb_SetDMAState
	ld sp,ix
	call _usb_DMACXTransferWait
	pop ix
	ret
.exit:
	ld sp,ix
	pop ix
	ret

_usb_DMACXRead:
	call _frameset0
	ld hl,(ix+$09)
	call _scmpzero
	jr z,.exit
	ld bc,$10
	push bc
	call _Out_31C0_b
	push bc
	call _usb_SetDMAAddress
	pop bc
	or a,a
	sbc hl,hl
	push hl
	push bc
	call _usb_SetDMAState
	ld sp,ix
	call _usb_DMACXTransferWait
	pop ix
	ret
.exit:
	ld sp,ix
	pop ix
	ret

_Out_31C0_b:
	ld hl,6
	add hl,sp
	ld bc,$31C0
	ld a,(hl)
	out (bc),a
	ret

_Out_31C8_b:
	ld hl,6
	add hl,sp
	ld bc,$31C8
	ld a,(hl)
	out (bc),a
	ret

_Out_31C9_s:
	ld hl,6
	add hl,sp
	ld hl,(hl)
	ld bc,$31C9
	call _boot_OutBC_s
	xor a,a
	out (bc),a
	ret
	

_usb_DMACXWriteNext:
	ld hl,-2
	call _frameset
	ld bc,$4000
	push bc
	ld hl,($D14040)
	xor a,a
	sbc.s hl,bc
	jr nc,.next
	ld b,a
	ld a,($D14040)
	ld c,a
	or a,a
	ld hl,($D14040)
	sbc.s hl,bc
.next:
	push hl
	pop bc
	ld hl,$D14040
	ld (hl),c
	inc hl
	ld (hl),b
	ld bc,($D14023)
	push bc
	call _usb_DMACXWrite
	pop bc
	pop bc
	call _stoiu
	ld bc,($D14023)
	add hl,bc
	ld ($D14023),hl
	ld a,1
	ld ($D140B2),a
	ld hl,($D14040)
	call _scmpzero
	jr nz,.exit
	ld bc,0
	ld ($D140AF),bc
.exit:
	ld sp,ix
	pop ix
	ret

_usb_DMACXWriteCheck:
	ld bc,2
	ld hl,($D140AF)
	or a,a
	sbc hl,bc
	jp z,_usb_DMACXWriteNext
	ld bc,$3120
	in a,(bc)
	or a,5
	out (bc),a
	ret

_usb_SetDMAState:
	call _frameset0
	ld bc,(ix+6)
	push bc
	call _stoiu
	ld a,1
	sub a,(ix+9)
	add a,a
	ld c,a
	ld b,0
	push bc
	call _Out_31C8_b
	pop bc
	call _Out_31C9_s
	ld sp,ix
	pop ix
	ret

_usb_DMATransfer:
	
	ret

_usb_DMACXTransferWait:


_usb_ResetFIFOS:


_usb_ResetTimer:


_usb_DisableTimer:


_usb_EnableTimer:


_usb_SetDMAAddress:



_usb_InEndpointClrStall:


_usb_InEndpointSetStall:


_usb_InEndpointClrReset:


_usb_InEndpointSetReset:


_usb_InEndpointSendZlp:


_usb_OutEndpointClrStall:


_usb_OutEndpointSetStall:


_usb_OutEndpointClrReset:


_usb_OutEndpointSetReset:


_usb_SetFifoMap:


_usb_SetEndpointConfig:


_usb_ClrEndpointConfig:


_usb_SetFifoConfig:
	ret

