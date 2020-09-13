
_boot_ZeroVRAM:
	xor a,a
	jr _boot_SetVRAM
_boot_ClearVRAM:
	ld a,$FF
_boot_SetVRAM:
	ld hl,vRam
	ld de,vRam+1
	ld bc,320*240
	ld (hl),a
	ldir
	ret
_boot_ZeroBuffer:
	xor a,a
	jr _boot_SetBuffer
_boot_ClearBuffer:
	ld a,$FF
_boot_SetBuffer:
	ld hl,vRamBuffer
	ld de,vRamBuffer+1
	ld bc,320*240
	ld (hl),a
	ldir
	ret

_boot_homeup:
	xor a,a
	ld (ti.curCol),a
	ld (ti.curRow),a
	ret

_boot_drawstatusbar:
	push ix
	ld a,$9D
	ld (textColors+2),a
	or a,a
	sbc hl,hl
	ld e,l
	ld a,18
	ld bc,ti.lcdWidth
	call boot_gfx_filled_rectangle
	or a,a
	sbc hl,hl
	ld e,18
	ld bc,ti.lcdWidth
	ld a,$7D
	call boot_gfx_horizontal
	pop ix
	ret
_PutSpinner:
	ld hl,vRam+317
	ld de,ti.lcdWidth-1
	ld b,17
	ld a,(hl)
	or a,a
	jr z,.loop
	cp a,$E5
	jr z,.loop
	ld a,$E5
.setloop:
	ld (hl),a
	inc hl
	ld (hl),a
	xor a,$E5
	add hl,de
	djnz .setloop
	ret
.loop:
	ld a,(hl)
	xor a,$E5
	ld (hl),a
	inc hl
	ld (hl),a
	add hl,de
	djnz .loop
	ret

_boot_puts_and_new_line:
	call _boot_PutS
_boot_NewLine:
	xor a,a
	ld (ti.curCol),a
	ld a,(ti.curRow)
	inc a
	cp a,20
	jr nc,_boot_ScrollTextUp
	ld (ti.curRow),a
	ret

_boot_ScrollTextUp:
	push hl
	ld de,vRamBuffer+320*18
	ld hl,vRamBuffer+320*28
	ld bc,320*(240-28)
	ldir
	pop hl
	ret



_boot_blit_buffer:
	ld hl,vRamBuffer
	ld de,vRam
	ld bc,ti.lcdWidth*ti.lcdHeight
	ldir
	ret

_boot_PutS:
	ld a,(hl)
	inc hl
	or a,a
	ret z
	call _boot_PutC
	jr _boot_PutS

_boot_PutC: ;taken and modified from Cesium
	push	hl
character_width:=8
character_height:=8
vRam:=$D40000
vRamBuffer:=vRam+ti.lcdWidth*ti.lcdHeight
	push af
	ld a,(ti.curCol)
	ld b,a
	inc a
	ld (ti.curCol),a
	ld c,9
	mlt bc
	inc bc
	inc bc
	ld	a,(ti.curRow)
	add a,3
	ld l,a
	add a,a
	add a,a
	add a,a
	add a,l
	ld l,a
	ld	h,ti.lcdWidth / 2
	mlt	hl
	add	hl,hl
	ld	de,vRamBuffer
	add	hl,de
	add	hl,bc				; add x value
	pop		af
	push	hl
	or a,a
	sbc	hl,hl
	ld	l,a
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	de,boot_font
	add	hl,de				; hl -> correct character
	pop	de				; de -> correct location
	ld	a,character_width
.vert_loop:
	ld	c,(hl)
	ld	b,character_height
	ex	de,hl
	push	de
	ld de,(textColors) ;text colors
.horiz_loop:
	rlc	c
	jr c,.fg
	ld (hl),e
	db $38 ;jr c
.fg:
	ld	(hl),d
	inc	hl
	djnz	.horiz_loop
	ld	(hl),e
	ld	bc,ti.lcdWidth - character_width
	add	hl,bc
	pop	de
	ex	de,hl
	inc	hl
	dec	a
	jr	nz,.vert_loop
	ld a,(ti.curCol)
	cp a,30
	call nc,_boot_NewLine
	pop hl
	ret

boot_homeup:
	xor a,a
	ld (ti.curCol),a
	ld (ti.curRow),a
	ret

; bc = width
; hl = x coordinate
; e = y coordinate
; a = height
boot_gfx_filled_rectangle:
	ld	d,ti.lcdWidth / 2
	mlt	de
	add	hl,de
	add	hl,de
	ex	de,hl
.computed:
	ld	ix,vRamBuffer			; de -> place to begin drawing
.loop:
	add	ix,de
	lea	de,ix
	ld	hl,textColors+2		; always just fill with the primary color
	ldi					; check if we only need to draw 1 pixel
	jp	po,.skip
	inc bc
	scf
	sbc	hl,hl
	add	hl,de
	push bc
	ldir					; draw the current line
	pop bc
.skip:
	ld	de,ti.lcdWidth			; move to next line
	dec	a
	jr	nz,.loop
	ret

boot_gfx_rectangle:
	push	bc
	push	hl
	push	de
	call	boot_gfx_horizontal			; top horizontal line
	pop	bc
	push	bc
	call	boot_gfx_vertical.computed		; left vertical line
	pop	bc
	pop	hl
	ld	e,c
	call	boot_gfx_vertical			; right vertical line
	pop	bc
	jr	boot_gfx_horizontal.computed		; bottom horizontal line

; hl = x
; e = y
; a = color
; bc = length
boot_gfx_horizontal:
	call	boot_gfx_compute			; hl -> drawing location
.computed:
	jp	boot_memset

; hl = x
; e = y
; a = color
; b = length
boot_gfx_vertical:
	dec	b
	call	boot_gfx_compute			; hl -> drawing location
.computed:
	ld	de,ti.lcdWidth
.loop:
	ld	(hl),a				; loop for height
	add	hl,de
	djnz	.loop
	ret

boot_gfx_compute:
	ld	d,ti.lcdWidth / 2
	mlt	de
	add	hl,de
	add	hl,de
	ld	de,vRamBuffer
	add	hl,de
	ret


