
include '../include/ez80.inc'
include '../include/ti84pceg.inc'

macro paduntil? addr
	assert $ <= addr
	if $ < addr
		db addr-$ dup $FF
	end if
end macro

;if defined calminstruction
	;calminstruction (var) strcalc? val
		;compute val, val        ; compute expression
		;arrange val, val        ; convert result to a decimal token
		;stringify val           ; convert decimal token to string
		;publish var, val
	;end calminstruction
;end if

macro unlock_flash?

end macro

macro lock_flash?

end macro

macro .def
end macro

macro .assume
end macro

macro .ref
end macro

define endif? end if


org 0
__SECTOR_00h:		;Bootloader goes here
include 'boot.asm'



paduntil $020000
__SECTOR_02h:		;OS goes here


