
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


_usb_DMACXReadNext:


_usb_DMACXWrite:


_usb_DMACXRead:


_usb_DMACXWriteNext:


_usb_DMACXWriteCheck:


_usb_SetDMAState:


_usb_DMATransfer:


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

