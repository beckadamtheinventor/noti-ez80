namespace usb

numQhs := 4
numXfers := 6
numQtds := $10
numBufs := 6

struc devDesc
	local size
	label .:size
	.bLength rb 1
	.bDescriptorType rb 1
	.bcdUSB rw 1
	.bDeviceClass rb 1
	.bDeviceSubClass rb 1
	.bDeviceProtocol rb 1
	.bMakePacketSize0 rb 1
	.idVendor rw 1
	.idProduct rw 1
	.bcdDevice rw 1
	.iManufacturer rb 1
	.iProduct rb 1
	.iSerialNumber rb 1
	.bNumConfigurations rb 1
	size := $-.
end struc

struc otgDesc
	local size
	label .:size
	.bLength rb 1
	.bDescriptorType rb 1
	.bmAttributes rb 1
	size := $-.
end struc

struc confDesc
	local size
	label .:size
	.bLength rb 1
	.bDescriptorType rb 1
	.wTotalLength rw 1
	.bNumInterfaces rb 1
	.bConfigurationValue rb 1
	.iConfiguration rb 1
	.bmAttributes rb 1
	.bMaxPower rb 1
	size := $-.
end struc

struc ifaceDesc
	local size
	label .:size
	.bLength rb 1
	.bDescriptorType rb 1
	.bInterfaceNumber rb 1
	.bAlternateSetting rb 1
	.bNumEndpoints rb 1
	.bInterfaceClass rb 1
	.bInterfaceSubClass rb 1
	.bInterfaceProtocol rb 1
	.iInterface rb 1
	size := $-.
end struc

struc hidDesc
	local size
	label .:size
	.bLength rb 1
	.bDescriptorType rb 1
	.bcdCDC rw 1
	.bCountryCode rb 1
	.bNumDescriptors rb 1
	.bDescriptorType0 rb 1
	.wDescriptorLength0 rw 1
	size := $-.
end struc

struc endptDesc
	local size
	label .:size
	.bLength rb 1
	.bDescriptorType rb 1
	.bEndpointAddress rb 1
	.bmAttributes rb 1
	.wMaxPacketSize rw 1
	.bInterval rb 1
	size := $-.
end struc

struc conf
	local size
	label .:size
	.conf confDesc
 repeat 2,ifIndex:0
	.iface.ifIndex ifaceDesc
	.iface.ifIndex.hid hidDesc
  repeat 3,epIndex:0
	.iface.ifIndex.endpt.epIndex endptDesc
  end repeat
 end repeat
	size := $-.
end struc

struc xfer
	local size
	label .:size
	.handler rl 1
	.errHandler rl 1
	.ptr rl 1
	.desc rl 1
	.head rl 1
	.timeout rl 1
	.cur rl 1
	.len rl 1
	.type rb 1
	.target rb 1
	.unknown rb 1
	.err rl 1
	size := $-.
end struc

struc timer
	local size
	label .:size
	.handler rl 1
	.timeout rl 1
	.offset rl 1
	.enabled rb 1
	.tripped rb 1
	size := $-.
end struc

struc curXfer
	local size
	label .:size
	.timeout rl 1
	.len rw 1
	.unknown1 rw 1
	.maxlen rw 1
	.target rb 1
	.ptr rl 1
	.unknown2 rl 1
	size := $-.
end struc

virtual at ti.usbArea
	?usbQueueHeads rl numQhs
	?3FE4 rl 1
	?3FE7 rl 1
	?3FEA rl 1
	?usbXfers rl 1
	?3FF0 rl 1
	?3FF3 rl 1
	?3FF6 rl 1
	?3FF9 rl 1
	?3FFC rl 1
	?3FFF rl 1
	?usbXferArray rl numXfers
	?4014 rl 1
	?queueHead rl 1
	?queueEltsBegin rl 1
	?periodicList rl 1
	?bufsBegin rl 1
	?devRes rl 1
	?resetCHook rl 1
	?4029 rl 1
	?402C rl 1
	?402F rl 1
	?4032 rl 1
	?FrameListRolloverCounter rl 1
	?timerCounter rl 1
	?portConnected rb 1
	?403C rd 1
	?devResLen rw 1
	?otgIntMaskHigh rb 1
	?otgIntStatusHigh rb 1
	?otgIntMaskedStatusHigh rb 1
	?statusHigh rb 1
	?otgIntMaskLow rb 1
	?otgIntStatusLow rb 1
	?otgIntMaskedStatusLow rb 1
	?intPending rb 1
	?devIntMaskedStatusHigh rb 1
	?devIntMaskHigh rb 1
	?devIntStatusHigh rb 1
	?devIntMaskedStatusLow rb 1
	?devIntMaskLow rb 1
	?devIntStatusLow rb 1
	?fifoIntMaskedStatusHigh rb 1
	?fifoIntMaskHigh rb 1
	?fifoIntStatusHigh rb 1
	?fifioIntMaskedStatusLow rb 1
	?fifioIntMaskLow rb 1
	?fifoIntStatusLow rb 1
	?devIntMaskedStatus rb 1
	?devIntMask rb 1
	?devIntStatus rb 1
	?grpIntPending rb 1
	?grpIntDisable rb 1
	?grpIntStatus rb 1
	?queueEltStatus rb numQtds
	?bufStatus rb numBufs
	?isBDevice rb 1
	?isDevice rb 1
	?4074 rb 1
	?4075 rb 1
	?4076 rb 1
	?timersEnabled rb 1
	?hostRecvData rb 1
	?hostSenddata rb 1
	?hostSetupRecvXfer rb 1
	?selfPowered rb 1
	?reset1 rb 1
	?reset2 rb 1
	?suspended rb 1
	?407F rb 1
	?inMinorState85 rb 1
	?4081 rb 1
	?asrpDetected rb 1
	?bsrpComplete rb 1
	?bSessionEnd rb 1
	?bPlugRemoved rb 1
	?aPlugRemoved rb 1
	?idChanged rb 1
	?isHost rb 1
	?noFullDraw rb 1
	?408A rb 1
	?408B rb 1
	?408C rb 1
	?configVal rb 1
	?ifaceNum rb 1
	?altSetting rb 1
	?configNum rb 1
	?4091 rb 1
	?4092 rb 1
	?4093 rb 1
	?4094 rb 1
	?4095 rb 1
	?4096 rb 1
	?nextDevAddr rb 1
	?4098 rb 1
	?curDevReq rb 8 + 11
	?curAlloc rl 1
	?40AF rl 1
	?reqStatus rb 1
	?tmpBuf rb $100
	?41B3 rb 8
	?41BB rl 1
	?41BE rl 1
	?41C1 rl 1
	rl 4
	?41D0 rl 1
	?41D3 rl 1
	?41D6 rl 1
	rl 3
	?41E2 rl 1
	?curDevAddr rb 1
	?devSpeed rb 1
	?portResetting rb 1
	?portSuspending rb 1
	?41E9 rb 1
	?devicePresent rb 1
	?portSuspend rb 1
	?41EB rb 1
	?hwErr rb 1
	?curDevDesc devDesc
 repeat 4,confIndex:0
	?curConfDesc.confIndex conf
 end repeat
	?otgDesc otgDesc
	rb 136
	?xfer xfer
	?timer1 timer
	?curXfer curXfer
	rb $3288
	?incomingVirtPkt rl 1
	?outgoingVirtPkt rl 1
	rl 1
	?76B1 rl 1
	rl 1
	?76B7 rl 1
	?76BA rl 1
	?errHandler rl 1
	?timer3 timer
	?timer3Timeout rl 1
	?timer3TimeoutBackup rl 1
	?76D1 rl 1
	?76D4 rl 1
	?76D7 rl 1
	?76DA rl 1
	?76DD rl 1
	?76E0 rl 1
	?76E3 rl 1
	?76E6 rl 1
	?76E9 rl 1
	?76EC rl 1
	?76EF rl 1
	?err rl 1
	?76F5 rl 1
	?76F8 rb 1
	?76F9 rb 1
	?76FA rb 1
	?xferSuccess rb 1
	?76FC rb 1
	?76FD rb 1
	?76FE rb 1
	?76FF rb 1
	?7700 rb 10
	?curVirtPkt rl 1
	?770D rl 1
	?7710 rl 1
	?7713 rl 1
	?paramPtr rl 1
	?7719 rb 1
	?tmpLong rd 1
	?771E rd 1
	?7722 rl 1
	?tmpByte rb 1
	?tmpWord rw 1
	rb 1
	?ctx rb 1
	?vramOff rl 1
	?osXferActive rb 1
	?osXferProgress rl 1
	?tempStr rb $10
	?7741 rl 1
	?osXferSpinner rb 1
	?7745 rb 1
	?7746 rb 1
	?7747 rb 1
	?7748 rl 1
	?774B rl 1
	?774E rl 1
	?7751 rl 1
	?7754 rw 1
	?7756 rw 1
	?7758 rb 1
	?7759 rb 1
	?775A rb 1
	?775B rl 1
	?775E rl 1
	?7761 rl 1
	?7764 rw 1
	?7766 rb 1
	?7767 rb 1
	?7768 rb 1
	?7769 rb 1
	?outgoingRawPkt rl 1
	?incomingRawPkt rl 1
	?timer2 timer
	?777B rd 1
	?777F rd 1
	?7783 rd 1
	?7787 rd 1
	?778B rd 1
	?778F rl 1
	?timer2Timeout rl 1
	?7795 rb 1
	?break rb 1
	?7797 rb $20
	?sillyState rb 1
	?minorState rb 1
	?majorState rb 1
	?77BA rb 1
	?endptNum rb 1
	?77BC rb 1
end virtual

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

virtual
	or a,not 0
	load ..or_a_n:byte from $$
end virtual

DmaCxTryRead:
	ld bc,2
	ld hl,(?40AF)
	or a,a
	sbc hl,bc
	jq z,DmaCxReadNext
	ld hl,ti.mpUsbCxFifo
	ld a,(hl)
	or a,ti.bmCxFifoStall or ti.bmCxFifoFin
	ld (hl),a
	ret

DmaCxWriteNext:
	db ..or_a_n
DmaCxReadNext:
	xor a,a
	ld hl,(devResLen)
	ld de,$40
	sbc hl,de
	jq nc,.min
	add hl,de
	ex de,hl
	or a,a
	sbc hl,hl
.min:
	push af
	ld (devResLen),hl
	ld hl,(devRes)
	ex de,hl
	add hl,de
	ld (devRes),hl
	call DmaCxRead.enter
	pop af
	ret nz
	xor a,a
	ld (?40AF),a
	inc a
	ld (reqStatus),a
	ret

DmaCxWrite:
	db ..or_a_n
DmaCxRead:
	xor a,a
	pop bc,de
	ex (sp),hl
	push de,bc
	add hl,de
	or a,a
.enter:
	sbc.s hl,de
	ret z
	ld iy,ti.mpUsbRange+$180
	and a,ti.usbDmaMem2Fifo
	ld (ti.usbDmaCtrl+iy-$180),a
	ld a,ti.bmUsbDmaCxFifo
	ld (ti.usbDmaFifo+iy-$180),a
	ld (ti.usbDmaAddr+iy-$180),de
	ld (ti.usbDmaLen+iy-$180),hl
	jq DmaCxWait

DmaCxWait:
	ld hl, 2000
	ld (curXfer.timeout),hl
	push hl
	call SetupTimer1
	pop hl
	ld iy,ti.mpUsbRange+$180
	set ti.bUsbDmaStart, (ti.usbDmaCtrl+iy-$180)
.loop:
	ld hl,(ti.usbDevIsr+iy-$180)
	bit ti.bUsbIntDevDmaErr,hl
	jq nz,.err
	bit ti.bUsbIntDevDmaFin,hl
	jq nz,.fin
	ld a,(timer1.tripped)
	or a,h
	and a,ti.bmUsbIntDevResume or ti.bmUsbIntDevSuspend or ti.bmUsbIntDevReset
	ld c,a
	ld a,(sillyState)
	sub a,$55
	or a,c
	jq z,.loop
.timeout:
	sbc hl,hl
	ld (curXfer.timeout),hl
	jq .cont
.err:
	set ti.bCxFifoClr,(ti.usbCxFifo+iy-$180)
	ld (ti.usbDevIsr+1+iy-$180),ti.bmUsbIntDevDmaErr shr 8
	jq .cont
.fin:
	ld (ti.usbDevIsr+iy-$180),ti.bmUsbIntDevDmaFin
	jq .cont
.cont:
	ld hl,(curXfer.timeout)
	add hl,de
	xor a,a
	sbc hl,de
	ld (timer1.enabled),a
	ld (ti.usbDmaFifo+iy-$180),a
	ret nz
	set 8-8,(ti.usbDevCtrl+1+iy-$180)
	set ti.bCxFifoClr,(ti.usbCxFifo+iy-$180)
	ld hl,ti.bmUsbIntDevDmaErr or ti.bmUsbIntDevDmaFin
	ld (ti.usbDevIsr+iy-$180),hl
	ret

SetDmaCtrl:
	pop de,bc
	ex (sp),hl
	push bc
	ld a,l
	cpl
	rlca
	and a,ti.usbDmaMem2Fifo
	ld hl,ti.mpUsbDmaCtrl
	ld (hl),a
	inc l
	inc bc
	dec.s bc
	ld (hl),bc
	ex de,hl
	jp (hl)

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
	pop de,bc
	ex (sp),hl
	push bc,de
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
	pop de,bc
	ex (sp),hl
	push bc,de
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
	pop de,bc
	push bc,de
	bit 0,c
	ret z
iterate fifo,0,3
	ld l,ti.usbFifo#fifo#Cfg-$100
	set ti.bUsbFifoEn,(hl)
end iterate
	ret
.init	db $30,$03,$32,$33,$33,$33,$33,$33
	db $22,$00,$23,$24,$06,$06,$02,$03
.len := $-.

Get76FC:
	ld hl,(?76FC)
	ret

ResetTimers:
	call	DisableTimers
	jq	EnableTimers

EnableTimers:
	; TODO: Implement
	ret

DisableTimers:
	; TODO: Implement
	ret

; TODO: implement everything after here

ByteSwapCopy:
	ret

ByteSwapStore:
	ret

ResetChip:
	ret

?400:
	ret

ResetConfig:
	ret

?41C:
	ret

?420:
	ret

HandleOsBeginPkt:
	ret

HandleOsHdrPkt:
	ret

HandleOsDataPkt:
	ret

SendOsAckPkt:
	ret

HandleEotPkt:
	ret

SendErrPkt:
	ret

SendParamDataPkt:
	ret

StorePidHeader:
	ret

ByteSwapCopyWord:
	ret

?448:
	ret

HandleDelayAckPkt:
	ret

?450:
	ret

TranslateError:
	ret

HandleErr:
	ret

SendPkt:
	ret

?468:
	ret

?46C:
	ret

ResetTimer2Timeout:
	ret

HandleInvalidPkt:
	ret

HandleBufReqPkt:
	ret

HandleBufAllocPkt:
	ret

HandleDataPkt:
	ret

HandleAckPkt:
	ret

RecvDataChk:
	ret

SendDataChk:
	ret

RecvData:
	ret

SendData:
	ret

SetupRecvXfer:
	ret

SetupSendXfer:
	ret

HandleXfer:
	ret

DefaultHandler:
	ret

DmaXfer:
	ret

DevRecvPkt:
	ret

?4B8:
	ret

HandleVirtPkt:
	ret

?4C4:
	ret

?4C8:
	ret

AllocOutgoingPkt:
	ret

AllocIncomingPkt:
	ret

AllocBuf:
	ret

FreeBuf:
	ret

SetupTimer2:
	ret

XferTimeoutHandler:
	ret

SetupTimer3NoHandler:
	ret

TimeoutErrorHandler:
	ret

RestoreTimer3Timeout:
	ret

SetupTimer1:
	ret

?500:
	ret

Free:
	ret

Alloc:
	ret

?50C:
	ret

?510:
	ret

?514:
	ret

?5FC:
	ret

?604:
	ret

ResetHandler:
	ret

end namespace
