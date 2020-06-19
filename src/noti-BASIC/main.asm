
namespace noti_BASIC

BASE:

paduntil BASE+$80
	db "noti-BASIC version 0.00.0001",0
paduntil BASE+$F0
	db "noti OS",0,0,0,0,0,0,0,1,0
	db $5A,$A5,$FF,$01
include 'table.asm'
include 'code.asm'

endOfOS:

end namespase
