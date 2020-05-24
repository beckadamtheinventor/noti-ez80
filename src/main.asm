
include '../include/ez80.inc'

macro paduntil? addr
	assert $ <= addr
	if $ < addr
		db addr-$ dup $FF
	end if
end macro


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


