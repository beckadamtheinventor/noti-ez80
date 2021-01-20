; -- TODO --
; this sprintf routine written by Beck for noti-ez80.
_sprintf:
	ld hl,-9
	call _frameset
	push iy
	ld hl,(ix+9)
	ld de,(ix+6)
	lea iy,ix+12
.loop:
	ld a,(hl)
	or a,a
	jq z,.end
	inc hl
	ld c,(hl)
	inc hl
	cp a,$5C  ; backslash
	jq z,.loop
	dec hl
	cp a,'%'
	jq z,.format_spec
	ld (de),a
	inc de
	dec hl
	jq .loop
.next_arg:
	lea iy,iy+3
	pop hl
	jq .loop
.end:
	pop iy
	ld sp,ix
	pop ix
	ret
.format_spec:
	push hl
	ld b,a
	ld a,c
	cp a,'c'
	jq z,.format_c
	cp a,'%'
	jq z,.format_c
	cp a,'i'
	jq z,.format_i
	cp a,'d'
	jq z,.format_i
	cp a,'s'
	jq z,.format_s
	cp a,'u'
	jq z,.format_u
	cp a,'o'
	jq z,.format_o
	cp a,'x'
	jq z,.format_x
	cp a,'X'
	jq z,.format_upper_x
	cp a,'n'
	jq z,.next_arg
	pop hl
	dec hl
	ex hl,de
	ld (hl),b
	inc hl
	ld (hl),a
	inc hl
	ex hl,de
	jq .loop
.format_c:
	ld a,(iy)
	lea iy,iy+3
	ld (de),a
	inc de
	jq .next_arg
.format_s:
	ld hl,(iy)
	xor a,a
.format_s_copy_loop:
	cp a,(hl)
	jq z,.format_s_done_copy
	ldi
	jq .format_s_copy_loop
.format_s_done_copy:
	jq .next_arg
.format_upper_x:
	ld a,(iy)
	call .put_byte_u
	ld a,(iy+1)
	call .put_byte_u
	ld a,(iy+2)
	call .put_byte_u
	jq .next_arg
.format_x:
	ld a,(iy)
	call .put_byte
	ld a,(iy+1)
	call .put_byte
	ld a,(iy+2)
	call .put_byte
	jq .next_arg
.format_o:
	ld a,(iy)
	ld b,3
.format_o_loop:
	ld c,a
	and a,7
	add a,'0'
	ld (de),a
	ld a,c
	rrca
	rrca
	rrca
	djnz .format_o_loop
	jq .next_arg
.format_i:
	ld hl,(iy)
	ld a,(iy+2)
	adc a,a
	jq nc,.format_i_non_neg
	push de
	ex hl,de
	scf
	sbc hl,hl
	sbc hl,de
	pop de
	ld a,'-'
	ld (de),a
	inc de
.format_i_non_neg:
	push de
	call .itos
	ex hl,de
	ld a,'0'
.format_i_skip_0_loop:
	cp a,(hl)
	inc hl
	jq z,.format_i_skip_0_loop
	dec hl
	pop de
	ld (de),a
	xor a,a
.format_i_copy_num_loop:
	cp a,(hl)
	inc hl
	jq nz,.format_i_copy_num_loop
	jq .next_arg
.format_u:
	ld hl,(iy)
	jq .format_i_non_neg

.put_byte:
	ld c,a
	call .put_nibble
	ld a,c
	rrca
	rrca
	rrca
	rrca
.put_nibble:
	and a,$F
	cp a,10
	jq c,.put_lt_10
	add a,'A'-'0'
.put_lt_10:
	add a,'0'
	ld (de),a
	inc de
	ret

.put_byte_u:
	ld c,a
	call .put_nibble_u
	ld a,c
	rrca
	rrca
	rrca
	rrca
.put_nibble_u:
	and a,$F
	cp a,10
	jq c,.put_lt_10_u
	add a,'A'-'0'
.put_lt_10_u:
	add a,'0'
	ld (de),a
	inc de
	ret


.itos:
	lea de,ix-9
	ld	bc,-1000000
	call	.aqu
	ld	bc,-100000
	call	.aqu
	ld	bc,-10000
	call	.aqu
	ld	bc,-1000
	call	.aqu
	ld	bc,-100
	call	.aqu
	ld	c,-10
	call	.aqu
	ld	c,b
	call .aqu
	xor a,a
	ld (de),a
	ret
.aqu:
	ld	a,'0' - 1
.under:
	inc	a
	add	hl,bc
	jr	c,.under
	sbc	hl,bc
	ld	(de),a
	inc	de
	ret

