_sshrs_b:
	push bc
	ld c,a
	call _sshrs
	pop bc
	ret
