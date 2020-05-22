
include '../include/ez80.inc'
include '../include/ti84pceg.inc'

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



org 0
__SECTOR_00h:		;Bootloader goes here
include 'boot.asm'

include 'loader.asm'


paduntil $020000
__SECTOR_02h:		;OS goes here


