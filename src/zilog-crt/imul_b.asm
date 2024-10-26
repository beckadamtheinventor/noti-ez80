_imul_b:
	push bc
	ld bc,0
	ld c,a
	call _imulu
	pop bc
	ret
