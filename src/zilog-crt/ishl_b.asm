_ishl_b:
	push bc
	ld c,a
	call _ishl
	pop bc
	ret
