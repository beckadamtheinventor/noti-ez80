_sshl_b:
	push bc
	ld c,a
	call _sshl
	pop bc
	ret
