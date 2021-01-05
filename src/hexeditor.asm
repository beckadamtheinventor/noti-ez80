

hex_editor:
	ld hl,-11
	call _frameset
	ld hl,$D00000
	ld (ix-3),hl
	xor a,a
	sbc hl,hl
	ld (ix-6),hl
	ld (ix-11),hl
	ld (ix-7),a
	ld (ix-8),a
.main_loop:
	ld a,(ix-7)
	cp a,$FF
	jr nz,.main_draw
	and a,7
	ld (ix-7),a
	jq .backwardpage
.main_draw:
	call .clearscreen
	ld bc,$FF
	ld (textColors),bc
	ld hl,(ix-3)
	push hl
	ld c,(ix-7)
	add hl,bc ;add cursor offset
	call _print24h
	pop hl
	ld a,3
	ld (ti.curRow),a
	xor a,a
	ld (ti.curCol),a
	ld c,16
.outer:
	ld b,8
.inner:
	push bc
	ld a,(hl)
	inc hl
	call _print8h
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
	ld a,(hl)
	call _print8h
	call _boot_blit_buffer
.keys:
	call boot_wait_key
	ld c,(ix-7)
	cp a,5
	jr nc,.notarrowkey
	push af
	call boot_Delay10ms
	pop af
	cp a,4
	jq z,.up
	cp a,3
	jq z,.right
	cp a,2
	jq z,.left
	cp a,1
	jq z,.down
.notarrowkey:
	push af
.waitkeyunpress:
	call boot_get_keycode
	or a,a
	jr nz,.waitkeyunpress
	pop af
	cp a,15 ;clear key
	jq z,.exit
	cp a,53 ;yequ key
	jq z,.setaddress
	cp a,9 ;enter key
	jq z,.write_sector
	cp a,10 ;"+" key
	jq z,.forwardfullpage
	cp a,11 ;"-" key
	jq z,.backwardfullpage
	cp a,12 ;"*"/"R" key
	jq z,.maybeerasesector
	cp a,13 ;"/" key
	jq z,.edit_sector
	ld bc,16
	ld hl,.nibblekeys+15
	cpdr
	jr nz,.keys
	push bc
	call boot_wait_key_cycle
	ld bc,16
	ld hl,.nibblekeys+15
	cpdr
	pop de
	jq nz,.keys
	ld a,e
	rla
	rla
	rla
	rla
	add a,c
	ld hl,(ix-3)
	ld c,(ix-7)
	add hl,bc
	inc c
	ld (ix-7),c
	ld bc,$D00000
	or a,a
	sbc hl,bc
	add hl,bc
	jr c,.flashwrite
	ld (hl),a
	jp .main_loop
.exit:
	ld sp,ix
	pop ix
	ret
.up:
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
.backwardfullpage:
	ld bc,-8*16
	jr .advancepage
.forwardfullpage:
	ld bc,8*16
	jr .advancepage
.down:
	ld a,c
	add a,8
	cp a,8*16
	jr c,.loadcursor
.forwardpage:
	ld bc,8
	jr .advancepage
.left:
	ld a,c
	dec a
	jr nc,.loadcursor
	ld a,16*8-1
	ld (ix-7),a
	jr .forwardpage
.right:
	ld a,c
	inc a
	cp a,16*8
	jr c,.loadcursor
	ld a,15*8
	ld (ix-7),a
	jr .forwardpage
.flashwrite:
	ex hl,de
	call _WriteFlashA
	jp .main_loop
.loadcursor:
	ld (ix-7),a
.dontloadcursor:
	jp .main_loop
.setaddress:
	call .getaddress
	jp c,.main_loop
	ld hl,(ix-6)
	ld (ix-3),hl
	xor a,a
	jp .main_loop
.getaddress:
	call .clearscreen ;c flag is always unset after _boot_homeup
	sbc hl,hl
	ld (ix-6),hl
	lea hl,ix-4 ;upper byte of address
	call .getaddrbyte
	lea hl,ix-5 ;high byte of address
	call nc,.getaddrbyte
	lea hl,ix-6 ;low byte of address
	ret c
.getaddrbyte:
	push hl
	call boot_wait_key_cycle
	ld bc,16
	ld hl,.nibblekeys+15
	cpdr
	jr nz,.exitaddrloop
	ld (ix-8),c
	ld a,c
	call _print4h
	call _boot_blit_buffer
	call boot_wait_key_cycle
	ld bc,16
	ld hl,.nibblekeys+15
	cpdr
	jr nz,.exitaddrloop
	ld a,c
	ld l,a
	call _print4h
	ld a,(ix-8)
	rlca
	rlca
	rlca
	rlca
	add a,l
	pop hl
	ld (hl),a
	call _boot_blit_buffer
	or a,a
	ret
.exitaddrloop:
	pop bc
	call _boot_blit_buffer
	scf
	ret
.maybeerasesector:
	ld hl,string_erase_sector
	call .confirm
	cp a,9
	call z,.erasesector
	jq .main_loop
.erasesector:
	sbc hl,hl
	ld bc,(ix-3)
	ld l,(ix-7)
	add hl,bc
	jq _EraseFlash
.clearscreen:
	call _boot_ClearBuffer
	call _boot_drawstatusbar
	jq _boot_homeup
.edit_sector:
	or a,a
	sbc hl,hl
	ld bc,(ix-3)
	ld l,(ix-7)
	add hl,bc
	ld de,$D30000
	ld (ix-3),de
	ld bc,$010000
	ld l,c
	ld h,b
	ld (ix-11),hl
	ldir
	jq .main_loop
.write_sector:
	ld a,(ix-11)
	or a,(ix-10)
	or a,(ix-9)
	jq z,.main_loop
	call .clearscreen
	ld a,$FF
	ld (textColors),a
	ld hl,string_overwrite_sector
	call .confirm
	cp a,9
	call z,.overwrite_sector
	jq .main_loop
.overwrite_sector:
	ld hl,(ix-11)
	call _EraseFlash
	ld hl,$D30000
	ld de,(ix-11)
	ld bc,0
	ld (ix-11),bc
	ld bc,$010000
	jq _WriteFlash
.confirm:
	push hl
	call .clearscreen
	ld a,$FF
	ld (textColors),a
	pop hl
	call _boot_puts_and_new_line
	ld hl,string_are_you_sure
	call _boot_puts_and_new_line
	ld hl,string_press_enter_confirm
	call _boot_blit_buffer
	jq boot_wait_key_cycle

.nibblekeys:
	db 33,34,26,18,35,27,19,36,28,20,47,39,31,46,38,30

