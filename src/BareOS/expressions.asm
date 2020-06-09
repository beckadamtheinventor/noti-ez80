

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
	ld (oce.textColors),bc
	ld hl,(ix+6)
	call oce.putS
	ld a,7
	ld (oce.textColors),a
	ld bc,0
	ld hl,_overtypes
	ld c,(ix-4)
	add hl,bc
	ld a,(hl)
	call oce.putC
	ld a,$FF
	ld (oce.textColors),a
	ld a,' '
	call oce.putC
	call oce.blitBuffer
.keys:
	call oce.waitKeyCycle
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


process_command:
	pop hl
	pop de
	push de
	push hl
	push de
	call command_skipword
	pop bc
	or a,a
	jr z,.no_args
	xor a,a
	dec de
	ld (de),a
	inc de
	inc de
	ld a,(de)
	or a,a
	jr z,.no_args
	push bc
	ld hl,sys_exec_arguments
	push hl
	push de
	call ti._strcpy
	pop bc
	pop bc
	pop bc
	jr .exec
.no_args:
	xor a,a
	ld (sys_exec_arguments),a
.exec:
	push bc
	call fs_execute_file
	pop bc
	ret
command_skipword:
	ld a,(de)
	inc de
	or a,a
	ret z
	cp a,' '
	jr nz,.
	ret



process_expression:
	ld hl,-9
	call ti._frameset
	or a,a
	sbc hl,hl
	ld (ix-3),hl
	ld (ix-6),hl
.main_loop:
	ld hl,(ix+6)
	ld bc,(ix-3)
	add hl,bc
.dont_reload_ptr:
	ld a,(hl)
	inc hl
	or a,a
	jq z,.exit
	cp a,'.'
	jq c,.decimal
	cp a,$30
	jq c,.dont_reload_ptr
	cp a,$3A
	jq nc,.number
	
	jq .dont_reload_ptr
.decimal:
	inc bc
	inc bc
	ld (ix-3),bc
	ld a,(hl)
	sub a,$30
	call .numberentry
	ld a,(ix-7)
	
	jq .main_loop
.number:
	inc bc
	ld (ix-3),bc
	sub a,$30
	call .numberentry
	jq .main_loop
.numberentry:
	ld e,(ix-9)
	ld hl,(ix-6)
	push af
	xor a,a
	ld bc,10
	call ti._lmulu
	pop af
	call ti._ladd_b
	ld (ix-9),e
	ld (ix-6),hl
	ret
.exit:
	ld sp,ix
	pop ix
	ret

