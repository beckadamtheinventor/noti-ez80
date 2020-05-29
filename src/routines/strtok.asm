
;char *strtok(char *s1,char *s2);
_strtok:
	pop bc
	pop de
	pop hl
	push hl
	push de
	push bc
	add hl,bc
	or a,a
	sbc hl,bc
	jr z,.hl_is_ptr
	scf
	sbc hl,hl
.hl_is_ptr:
	push de
	push hl
	call _strspn ;l = strspn(ptr,s2)
	pop bc
	pop de
;if (!l && !*ptr)
	jr nz,.continue ;!l
	ld a,(bc)
	jr z,.return_null ;!*ptr
.continue:
	add hl,bc ;ptr+=l
	push de
	push hl
	call _strpbrk ;p = strpbrk(ptr,s1)
	add hl,bc
	or a,a
	sbc hl,bc
	jr nz,.p_is_not_zero
	pop hl
	pop de
	xor a,a
	cp a,(hl)
	jr z,.return_null
	ret ;hl = s1
.p_is_not_zero:
	ld (hl),0 ;*p = 0
.return_s1:
	pop hl ;hl = s1
	pop bc
	ret
.return_null:
	xor a,a
	sbc hl,hl
	ret
