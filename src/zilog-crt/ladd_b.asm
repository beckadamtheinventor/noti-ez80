_ladd_b:
	push bc
	ld bc,0
	ld c,a
	ld a,0
	call __ladd
	ld a,c
	pop bc
	ret
