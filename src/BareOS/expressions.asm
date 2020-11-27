

get_user_input:
	ld hl,-5
	call ti._frameset
	xor a,a
	sbc hl,hl
	ld (ix-3),hl
	ld (ix-4),a
	ld hl,(ix+6)
	ld (hl),a
	push hl
	pop de
	inc de
	ld bc,(ix+9)
	ldir
	ld a,(ti.curRow)
	ld (ix-5),a
	jr .entry
.draw:
	ld a,(ix-5)
	ld (ti.curRow),a
.entry:
	xor a,a
	ld (ti.curCol),a
	ld bc,$FF
	ld (noti.textColors),bc
	ld hl,(ix+6)
	call noti.putS
	ld a,7
	ld (noti.textColors),a
	ld bc,0
	ld hl,_overtypes
	ld c,(ix-4)
	add hl,bc
	ld a,(hl)
	call noti.putC
	ld a,$FF
	ld (noti.textColors),a
	ld a,' '
	call noti.putC
	call noti.blitBuffer
.keys:
	call noti.waitKeyCycle
	cp a,56
	jq z,.delete
	cp a,15
	jq z,.exit
	cp a,54
	jq z,.nextmap
	cp a,9
	jq z,.enter
	jq c,.keys
	cp a,48
	jq z,.prevmap
	jq nc,.keys
	ld bc,0
	ld c,(ix-4)
	ld hl,_keymaps
	add hl,bc
	add hl,bc
	add hl,bc
	ld hl,(hl)
	sub a,10
	ld c,a
	add hl,bc
	ex hl,de
	ld hl,(ix-3)
	ld bc,(ix+9)
	or a,a
	inc hl
	sbc hl,bc
	jq nc,.keys
	add hl,bc
	ld (ix-3),hl
	dec hl
	ld a,(de)
	ld bc,(ix+6)
	add hl,bc
	ld (hl),a
	inc hl
	ld (hl),0
	jq .draw
.delete:
	ld hl,(ix+6)
	ld bc,(ix-3)
	ld a,(ix-1)
	or a,b
	or a,c
	jq z,.draw
	dec bc
	add hl,bc
	ld (hl),0
	ld (ix-3),bc
	jq .draw
.enter:
	xor a,a
	ld (ti.curCol),a
	inc a
	jr .return
.exit:
	xor a,a
	ld (ti.curCol),a
	ld hl,(ix+6)
	ld (hl),a
.return:
	ld sp,ix
	pop ix
	ret
.prevmap:
	ld a,(ix-4)
	or a,a
	jr nz,.decmap
	ld a,3
.decmap:
	dec a
.setmap:
	ld (ix-4),a
	jq .draw
.nextmap:
	ld a,(ix-4)
	inc a
	cp a,3
	jr nz,.setmap
	xor a,a
	jr .setmap




