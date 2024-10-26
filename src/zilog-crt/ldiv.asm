;Edited for use with open-ce
; Copyright (C) 1999-2008 Zilog, Inc, All Rights Reserved
;-------------------------------------------------------------------------
; 	ldiv function
;
;	ldiv_t ldiv(long numer, long denom); 
;
;-------------------------------------------------------------------------
;	.assume adl=1
;	.def 	_ldiv
;	.ref	__ldivs
;	.ref	__lrems
;	SEGMENT code
_ldiv:

 push bc
 push af
 push de
 push hl

 ld hl,27
 add hl,sp
 ld  a,(hl)
 dec hl
 dec hl
 dec hl
 ld bc,(hl)     ; aBC : denominator
 dec hl
 dec hl
 dec hl
 ld e,(hl)
 dec hl
 dec hl
 dec hl
 ld hl,(hl)	  	; eHL: Numerator
 call _ldivs
 push de
 push hl		; eHL : quotient

 ld hl,27
 add hl,sp
 ld e,(hl)
 dec hl
 dec hl
 dec hl
 ld hl,(hl)
 call _lrems
 ld a,e
 ex de,hl       ;aDE :remainder

 ld hl,21
 add hl,sp
 ld hl,(hl)
 push hl

 ld bc, 7
 add hl, bc
 ld (hl),a
 dec hl
 dec hl
 dec hl
 ld (hl),de      ; aDE : remainder

 pop hl
 pop bc
 ld (hl),bc		; bc : 3 LSB  of quotient
 pop bc
 push hl
 inc hl
 inc hl
 inc hl
 ld (hl),c		;  c : MSB of quotient
 pop hl

 pop de
 pop de
 pop af
 pop bc

 ret

