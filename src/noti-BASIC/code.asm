
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
	ret

exec_bas:
	ld hl,-84
	call ti._frameset
	lea hl,ix-84
	ld a,26
	ld de,data_function_table
.loop:
	ex hl,de
	ld bc,(hl)
	ex hl,de
	ld (hl),bc
	inc hl
	inc hl
	inc hl
	inc de
	inc de
	inc de
	dec a
	jr nz,.loop
	ld sp,ix
	pop ix
	ret

exec_function:
	
	ret

