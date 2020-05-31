namespace usb

;bit 7 of port $000F
;return nz if bus is powered by the power controller
IsBusPowered:
	in0 a,($0A)
	res 1,a
	out0 ($0A),a
	in0 a,($0B)
	and a,1 shl 1
	ret

;bit 7 of port $000F
;return a = 1 if bus is powered externally
BusPowered:
	in0 a,($0F)
.enter:
	rlca
	and a,1
	ret

;bit 6 of port $000F
;return a = 1 if bus is self-powered
SelfPowered:
	in0 a,($0F)
	rlca
	jq BusPowered.enter

SetDeviceB:
	ld hl,ti.mpUsbOtgCsr
	ld a,(hl)
	or a,ti.bmUsbBHnp or ti.bmUsbBBusReq
	ld (hl),a
	ret

DmaCxReadNext:
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
	call DmaCxRead
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

DmaCxWrite:
	call _frameset0
	ld hl,(ix+$09)
	call _scmpzero
	jr z,.exit
	ld bc,$10
	push bc
	call _Out_31C0_b
	push bc
	call SetDmaAddress
	pop bc
	ld hl,1
	push hl
	push bc
	call SetDmaState
	ld sp,ix
	call DmaCxTransferWait
	pop ix
	ret
.exit:
	ld sp,ix
	pop ix
	ret

DmaCxRead:
	call _frameset0
	ld hl,(ix+$09)
	call _scmpzero
	jr z,.exit
	ld bc,$10
	push bc
	call _Out_31C0_b
	push bc
	call SetDmaAddress
	pop bc
	or a,a
	sbc hl,hl
	push hl
	push bc
	call SetDmaState
	ld sp,ix
	call DmaCxTransferWait
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
	

DmaCxWriteNext:
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
	call DmaCxWrite
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

DmaCxWriteCheck:
	ld bc,2
	ld hl,($D140AF)
	or a,a
	sbc hl,bc
	jp z,DmaCxWriteNext
	ld bc,$3120
	in a,(bc)
	or a,5
	out (bc),a
	ret

SetDmaState:
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

DmaTransfer:
	
	ret

..GetEpReg:
	ld hl,6
	add hl,sp
	ld a,(hl)
	ld hl,ti.mpUsbInEp1
	jq z,.in
	ld l,ti.usbOutEp1-$100
.in:
	dec a
	cp a,8
	pop de
	ret nc
	push de
	rlca
	rlca
	or a,l
	ld l,a
	ret

virtual
	or a,1
	load ..or_a_n: byte from $$
end virtual

OutEndpointClrStall:
	db ..or_a_n
InEndpointClrStall:
	cp a,a
	call ..GetEpReg
	res ti.bUsbEpStall-8,(hl)
	ret

OutEndpointSetStall:
	db ..or_a_n
InEndpointSetStall:
	cp a,a
	call ..GetEpReg
	set ti.bUsbEpStall-8,(hl)
	ret

OutEndpointClrReset:
	db ..or_a_n
InEndpointClrReset:
	cp a,a
	call ..GetEpReg
	res ti.bUsbEpReset-8,(hl)
	ret

OutEndpointSetReset:
	db ..or_a_n
InEndpointSetReset:
	cp a,a
	call ..GetEpReg
	set ti.bUsbEpReset-8,(hl)
	ret

InEndpointSendZlp:
	cp a,a
	call ..GetEpReg
	set ti.bUsbInEpSendZlp-8,(hl)
	ret

SetDmaAddress:
	pop de
	ex (sp),hl
	ld (ti.mpUsbDmaAddr),hl
	ex de,hl
	jp (hl)

SetFifoMap:
	pop de, bc
	ex (sp),hl
	push bc, de
	ld a,c
	cp a,4
	ret nc
	or a,ti.usbFifo0Map-$100
	ld c,a
	ld b,ti.pUsbFifo0Map shr 8
	out (bc),l
	ret

ClrEndpointConfig:
	ld hl,2*long
	ld c,h
	ld b,h
	add hl,sp
	jq SetEndpointConfig.enter

SetEndpointConfig:
	ld hl,3*long
	add hl,sp
	ld bc,(hl)
repeat long
	dec hl
end repeat
.enter:
	bit 0,(hl)
	call ..GetEpReg
	ld (hl),bc
	ret

SetFifoConfig:
	pop de, bc
	ex (sp),hl
	push bc, de
	ld a,c
	cp a,4
	ret nc
	or a,ti.usbFifo0Cfg-$100
	ld c,a
	ld b,ti.pUsbFifo0Cfg shr 8
	out (bc),l
	ret

ResetFifos:
	ld a,($D14074)
	or a,a
	ret nz
	cpl
	ld hl,ti.mpUsbFifoRxImr
	ld (hl),a
	ld l,ti.usbFifoTxImr-$100
	ld (hl),a
	ld l,ti.usbFifo0Cfg-$100
repeat 4
	res ti.bUsbFifoEn,(hl)
 if % <> %%
	inc l
 end if
end repeat
	ld l,ti.usbEp1Map-$100
	ld de,.init
	ld bc,.len
	ex de,hl
	ldir
	ex de,hl
	ld c,64
repeat 4
 if % <> 2
	ld l,ti.usbInEp#%-$100
 else
	ld l,ti.usbOutEp#%-$100
 end if
	ld (hl),bc
end repeat
	ld l,ti.usbFifo0Cfg-$100
repeat 4
	set ti.bUsbFifoEn,(hl)
.wait#%:
	bit ti.bUsbFifoEn,(hl)
	jq nz,.wait#%
 if % <> %%
	inc l
 end if
end repeat
	pop de, bc
	push bc, de
	bit 0,c
	ret z
iterate fifo, 0, 3
	ld l,ti.usbFifo#fifo#Cfg-$100
	set ti.bUsbFifoEn,(hl)
end iterate
	ret
.init	db $30, $03, $32, $33, $33, $33, $33, $33
	db $22, $00, $23, $24, $06, $06, $02, $03
.len := $-.

DmaCxTransferWait:
	ret

ResetTimers:
	ret

DisableTimers:
	ret

EnableTimers:
	ret

end namespace
