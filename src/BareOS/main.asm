include '../../noti-ez80.inc'
include '../../bareos.inc'
namespace BareOS

OS_BASE:
	dd 0
paduntil OS_BASE+$100
	db $5A,$A5,$FF,$01
include 'table.asm'
include 'code.asm'
include 'expressions.asm'
include 'data.asm'

endOfOS:

end namespace

