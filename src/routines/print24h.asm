
_print24h:
	ld (ScrapMem),hl
	ld a,(ScrapMem+2)
	call _print8h
	jq _print16h
