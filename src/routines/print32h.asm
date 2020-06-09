
_print32h:
	push de
	ld a,e
	call _print8h
	call _print24h
	pop de
	ret


