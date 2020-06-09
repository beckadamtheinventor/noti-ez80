
_print8h:
	push af
	rra
	rra
	rra
	rra
	and a,$F
	call _print4h
	pop af
	and a,$F
	jq _print4h


