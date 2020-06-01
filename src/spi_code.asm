namespace spi

; TODO: implement everything after here


Read:
	ret


	; Input: A = parameter
WriteParam:
	scf ; First bit is set for data
	db 030h ; jr nc,? ; skips over one byte
	; Input: A = command
WriteCmd:
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

end namespace
