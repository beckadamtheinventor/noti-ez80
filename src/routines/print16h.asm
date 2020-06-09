_print16h:
	ld a,h
	call _print8h
	ld a,l
	jq _print8h
