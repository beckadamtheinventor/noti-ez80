
;sin(x) = sum((-1)^nx2^(n + 1)/(2n + 1)!, 0, infinity)

_sin:
	ld hl,-5
	call _frameset
	ld a,(ix+6) ;store sign and 7 bits of mantissa
	ld (ix-1),a
	xor a,a
	sbc hl,hl
	ld (ix-5),a
	ld (ix-4),hl
	ld a,$80    ;store 8th bit of mantissa
	and a,(ix+5)
	ld (ix-2),a

;ix-4: float C
.mainloop:
	ld hl,1
	ld a,(ix-5)
	or a,a
	jr z,.skipshift ;n==0: float B = 1
	inc hl
	cp a,20
	jr nc,.exit ;n>=20
	ld b,a ;int S = 2<<n
.shiftloop:
	add hl,hl
	djnz .shiftloop
.skipshift:
	ld e,0
	ld bc,(ix-4)
	ld a,(ix-1)
	call _fmul ;X*=S
	push af
	xor a,a
	sbc hl,hl
	ld e,a
	ld a,(ix-5)
	add a,a
	inc a ;a = 2n+1
	ld l,a
	pop af
	call _ltof
	call _fdiv ;X/=(2n+1)
	ld hl,(ix-4)
	ld e,(ix-1)
	call _fadd ;C+=X
	ld (ix-4),bc
	ld (ix-1),a
	inc (ix-5) ;n++
	jr .mainloop
.exit:
	ld e,(ix-1)
	ld hl,(ix-4)
	ld sp,ix
	pop ix
	ret


