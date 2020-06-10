include '../../opence.inc'

	db "BareOS version 0.03.0002",0
paduntil $0100F0
	db "noti OS",0,0,0,0,0,3,0,1,0
	db $5A,$A5,$FF,$01
include 'table.asm'
include 'code.asm'
include 'expressions.asm'
include 'fs.asm'
include 'data.asm'

endOfOS:
