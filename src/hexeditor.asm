

hex_editor:
	ld hl,-8
	call _frameset
	ld hl,$D00000
	ld (ix-3),hl
	ld (ix-6),hl
	xor a,a
	ld (ix-7),a
	ld (ix-8),a
.main_loop:
	call _boot_ClearBuffer
	call _boot_drawstatusbar
	call _boot_homeup
	ld bc,$FF
	ld (textColors),bc
	lea hl,ix-1 ;edit page pointer
	ld b,3
.addrloop:
	ld a,(hl)
	push bc
	call .putbyte
	pop bc
	dec hl
	dec hl
	djnz .addrloop
	ld a,3
	ld (ti.curRow),a
	xor a,a
	ld (ti.curCol),a
	ld hl,(ix-3) ;edit page pointer
	ld c,16
.outer:
	ld b,8
.inner:
	push bc
	call .putbyte
	pop bc
	ld a,(ti.curCol)
	inc a
	ld (ti.curCol),a
	djnz .inner
	ld a,(ti.curRow)
	inc a
	ld (ti.curRow),a
	xor a,a
	ld (ti.curCol),a
	dec c
	jr nz,.outer
	or a,a
	sbc hl,hl
	ld a,(ix-7) ;cursor offset
	ld l,a
	rra
	rra
	rra
	and a,$F
	inc a
	inc a
	inc a
	ld (ti.curRow),a
	ld a,l
	and a,$7
	ld c,a
	add a,a
	add a,c
	ld (ti.curCol),a
	ld bc,(ix-3) ;edit page pointer
	add hl,bc ;(hl) = byte to recolor
	ld a,6
	ld (textColors),a
	call .putbyte
	call _boot_blit_buffer
.keys:
	call boot_wait_key
	ld c,(ix-7)
	cp a,4
	jq z,.up
	cp a,3
	jq z,.right
	cp a,2
	jq z,.left
	cp a,1
	jq z,.down
	push af
.waitkeyunpress:
	call boot_get_keycode
	or a,a
	jr nz,.waitkeyunpress
	pop af
	cp a,15 ;clear key
	jr z,.exit
	ld bc,16
	ld hl,.nibblekeys+15
	cpdr
	jr nz,.keys
	ld hl,(ix-3)
	ld a,(hl)
	bit 0,(ix-8)
	jr nz,.lowernibble
	rlc c
	rlc c
	rlc c
	rlc c
	and a,$0F
	or a,c
	set 0,(ix-8)
	jr .writenibble
.lowernibble:
	and a,$F0
	or a,c
	res 0,(ix-8)
.writenibble:
	ld c,(ix-7)
	add hl,bc
	ld bc,$D00000
	or a,a
	sbc hl,bc
	add hl,bc
	jr c,.flashwrite
	ld (hl),a
	jr .nextcursor
.exit:
	ld sp,ix
	pop ix
	ret
.up:
	res 0,(ix-8)
	ld a,c
	sub a,8
	jr nc,.loadcursor
.backwardpage:
	ld bc,-8
.advancepage:
	ld hl,(ix-3)
	add hl,bc
	ld (ix-3),hl
	jr .dontloadcursor
.down:
	res 0,(ix-8)
	ld a,c
	add a,8
	cp a,8*16
	jr c,.loadcursor
.forwardpage:
	ld bc,8
	jr .advancepage
.left:
	res 0,(ix-8)
	ld a,c
	dec a
	jr nc,.loadcursor
	ld a,16*8-1
	ld (ix-7),a
	jr .forwardpage
.nextcursor:
	bit 0,(ix-8)
	jr nz,.dontloadcursor
	ld a,(ix-7)
	jr .rightentry
.right:
	res 0,(ix-8)
	ld a,c
.rightentry:
	inc a
	cp a,16*8
	jr c,.loadcursor
	xor a,a
	ld (ix-7),a
	jr .forwardpage
.flashwrite:
	push hl
	ex de,hl
	call _WriteFlashA
	pop hl
	jr .nextcursor
.loadcursor:
	ld (ix-7),a
.dontloadcursor:
	jp .main_loop
.putbyte:
	ld a,(hl)
	rra
	rra
	rra
	rra
	and a,$F
	call .putnibble
	ld a,(hl)
	inc hl
	and a,$F
.putnibble:
	cp a,10
	jr nc,.putnibbleA
	add a,$30
	jp _boot_PutC
.putnibbleA:
	add a,$41-10
	jp _boot_PutC
.nibblekeys:
	db 33,34,26,18,35,27,19,36,28,20,47,39,31,46,38,30
