_ishrs_b:
	push bc
	ld c,a
	call _ishrs
	pop bc
	ret
