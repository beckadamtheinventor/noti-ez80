
macro assume? rest&
end macro
macro public? rest&
end macro
macro private? rest&
end macro
macro section? rest&
end macro
macro ident? rest&
end macro
macro extern? rest&
end macro
macro require? rest&
end macro

PREFER_OS_CRT := 0
PREFER_OS_LIBC := 0

include 'crt/bdvrms_abs.src'
include 'crt/bdvrmu.src'
include 'crt/bdivs.src'
include 'crt/bdivu.src'
include 'zilog-crt/bldix.asm'
include 'zilog-crt/bldiy.asm'
include 'crt/bmuls.src'
include 'crt/bmulu.src'
include 'crt/brems.src'
include 'crt/bremu.src'
include 'zilog-crt/bshl.asm'
include 'zilog-crt/bshrs.asm'
include 'zilog-crt/bshru.asm'
include 'zilog-crt/bstix.asm'
include 'zilog-crt/bstiy.asm'
include 'zilog-crt/case.asm'
include 'zilog-crt/case8.asm'
include 'zilog-crt/case8D.asm'
include 'zilog-crt/case16.asm'
include 'zilog-crt/case16D.asm'
include 'zilog-crt/case24.asm'
include 'zilog-crt/case24D.asm'
include 'zilog-crt/fpadd.asm'
include 'zilog-crt/fpsub.asm'
include 'zilog-crt/fpcmp.asm'
include 'zilog-crt/fpdiv.asm'
include 'zilog-crt/fpftol.asm'
__ftol := _ftol
include 'zilog-crt/fpltof.asm'
include 'zilog-crt/fpultof.asm'
include 'zilog-crt/fpmul.asm'
include 'zilog-crt/fpneg.asm'
include 'zilog-crt/fppack.asm'
include 'zilog-crt/fpupop1.asm'
include 'zilog-crt/fpupop2.asm'
__fcmp := _fcmp

include 'crt/frameset0.src'
include 'crt/frameset.src'
_frameset := __frameset
_frameset0 := __frameset0
include 'zilog-crt/frbmuls.asm'
include 'zilog-crt/frbtof.asm'
include 'zilog-crt/frftob.asm'
include 'zilog-crt/frftoi.asm'
include 'zilog-crt/frftos.asm'
include 'zilog-crt/frftoub.asm'
include 'zilog-crt/frftoui.asm'
include 'zilog-crt/frftous.asm'
include 'zilog-crt/frimuls.asm'
include 'zilog-crt/frimulu.asm'
include 'zilog-crt/fritof.asm'
include 'zilog-crt/frsmuls.asm'
include 'zilog-crt/frsmulu.asm'
include 'zilog-crt/frstof.asm'
include 'zilog-crt/frubtof.asm'
include 'zilog-crt/fruitof.asm'
include 'zilog-crt/frustof.asm'
include 'crt/and.src'
include 'crt/icmpzero.src'
include 'crt/idivs.src'
include 'crt/idivu.src'
include 'crt/idvrms.src'
include 'crt/idvrmu.src'
include 'zilog-crt/ildix.asm'
include 'zilog-crt/ildiy.asm'
include 'crt/imulu.src'
_imulu := __imulu
include 'zilog-crt/imul_b.asm'
include 'zilog-crt/indcall.asm'
include 'crt/indcallhl.src'

include 'crt/ineg.src'
include 'crt/inot.src'
include 'crt/or.src'
include 'crt/irems.src'
include 'crt/iremu.src'
include 'crt/ishl.src'
_ishl := __ishl
include 'crt/ishrs.src'
_ishrs := __ishrs
_ishru := __ishru
;include 'crt/ishru.src'
include 'zilog-crt/ishl_b.asm'
include 'zilog-crt/ishrs_b.asm'
include 'zilog-crt/ishru_b.asm'
include 'zilog-crt/istix.asm'
include 'zilog-crt/istiy.asm'
include 'zilog-crt/itol.asm'
include 'crt/xor.src'
include 'crt/ladd.src'
include 'zilog-crt/ladd_b.asm'
;include 'crt/land.src'
include 'crt/lcmpu.src'
__lcmps := __lcmpu
_lcmps := __lcmps
include 'crt/lcmpzero.src'
include 'crt/ldiv.src'
include 'crt/ldivs_lrems_common.src'
include 'crt/ldivs.src'
include 'crt/ldivu.src'
include 'crt/ldvrmu.src'
include 'zilog-crt/lldix.asm'
include 'zilog-crt/lldiy.asm'
include 'crt/lmulu.src'
include 'crt/lneg.src'
include 'crt/lnot.src'
;include 'crt/lor.src'
include 'crt/lrems.src'
include 'crt/lremu.src'
include 'crt/lshl.src'
include 'crt/lshrs.src'
include 'crt/lshru.src'
_lshl := __lshl
_lshru := __lshru
_lshrs := __lshrs
include 'zilog-crt/lstix.asm'
include 'zilog-crt/lstiy.asm'
include 'crt/lsub.src'
;include 'crt/lxor.src'
include 'zilog-crt/memchr.asm'
include 'zilog-crt/memclear.asm'
include 'zilog-crt/memcmp.asm'
include 'zilog-crt/memcpy.asm'
include 'zilog-crt/memmove.asm'
include 'zilog-crt/memset.asm'
include 'crt/sand.src'
include 'crt/scmpzero.src'
include 'crt/sdvrmu.src'
include 'crt/sdvrms_abs.src'
include 'crt/sdivs.src'
include 'crt/sdivu.src'
include 'zilog-crt/seqcase.asm'
include 'zilog-crt/seqcaseD.asm'
include 'zilog-crt/setflag.asm'
__setflag := _setflag
include 'zilog-crt/setjmp.asm'
include 'zilog-crt/sldix.asm'
include 'zilog-crt/sldiy.asm'
include 'crt/smulu.src'
_ineg := __ineg
_inot := __inot
__sneg := _ineg
__snot := _inot
include 'crt/sor.src'
;include 'crt/sprintf.src'
include 'crt/srems.src'
include 'crt/sremu.src'
include 'crt/sshl.src'
include 'zilog-crt/sshl_b.asm'
include 'crt/sshrs.src'
include 'zilog-crt/sshrs_b.asm'
include 'crt/sshru.src'
include 'zilog-crt/sshru_b.asm'
_sshl := __sshl
_sshrs := __sshrs
_sshru := __sshru
include 'zilog-crt/sstix.asm'
include 'zilog-crt/sstiy.asm'
include 'zilog-crt/stoi.asm'
include 'zilog-crt/stoiu.asm'
include 'zilog-crt/strcat.asm'
include 'zilog-crt/strchr.asm'
include 'zilog-crt/strcmp.asm'
include 'zilog-crt/strcpy.asm'
include 'zilog-crt/strcspn.asm'
include 'zilog-crt/strlen.asm'
include 'zilog-crt/strncat.asm'
include 'zilog-crt/strncmp.asm'
include 'zilog-crt/strncpy.asm'
include 'zilog-crt/strpbrk.asm'
include 'zilog-crt/strrchr.asm'
include 'zilog-crt/strspn.asm'
include 'zilog-crt/strstr.asm'
include 'zilog-crt/sqrtf.asm'
include 'crt/sxor.src'

include 'crt/ftoll.src'
include 'crt/ftoll.c.src'

;include 'crt/uldiv.src'
include 'routines/zx7_Decompress.asm'

include 'zilog-crt/longjmp.asm'

; ... lots of 64-bit functions that aren't in the jump table (yet) but needed for some libc routines
include 'crt/lladd.src'
include 'crt/lland.src'
include 'crt/llcmpu.src'
include 'crt/llcmps.src'
include 'crt/llcmpzero.src'
include 'crt/llctlz.src'
include 'crt/lldivs.src'
include 'crt/lldivu.src'
include 'crt/lldvrmu.src'
include 'crt/llmulu.src'
include 'crt/llneg.src'
include 'crt/llshl.src'
include 'crt/llshrs.src'
include 'crt/llshru.src'
include 'crt/llsub.src'
_outchar := _boot_PutC
include 'libc/nanoprintf.c.src'
HAS_PRINTF := 1
include 'libc/printf.src'


include 'libc/strtof.src'
include 'libc/strtof.c.src'
include 'libc/strtol.c.src'
include 'libc/strtoll.c.src'
include 'libc/strtoul.c.src'
include 'libc/strtoull.c.src'
include 'libc/maptab.c.src'

__ltof := _ltof
include 'libc/toupper.src'
include 'libc/tolower.src'
include 'libc/isalnum.src'
include 'libc/isalpha.src'
include 'libc/isascii.src'
include 'libc/iscntrl.src'
include 'libc/isdigit.src'
include 'libc/isfinitef.src'
include 'libc/isgraph.src'
include 'libc/isinff.src'
include 'libc/islower.src'
include 'libc/isnanf.src'
include 'libc/isprint.src'
include 'libc/ispunct.src'
include 'libc/isspace.src'
include 'libc/isupper.src'
include 'libc/isxdigit.src'

_errno := ti.errNo
__fsub := _fsub
__fadd := _fadd
__fmul := _fmul
__fdiv := _fdiv
__fneg := _fneg
_sqrt := _sqrtf
include 'libc/acos.src'
include 'libc/asin.src'
include 'libc/asin.c.src'
include 'libc/atan.src'
include 'libc/atan.c.src'
include 'libc/atan2.c.src'
include 'libc/atof.src'
include 'libc/floor.src'
include 'libc/floor.c.src'
include 'libc/ceil.src'
include 'libc/cos.src'
include 'libc/cosh.c.src'
include 'libc/fabs.src'
include 'libc/fmod.c.src'
include 'libc/log10.c.src'
include 'libc/modf.src'
include 'libc/modf.c.src'
include 'libc/pow.c.src'
include 'libc/sin.c.src'
include 'libc/sinh.c.src'
include 'libc/sqrt.c.src'
; include 'libc/strtod.c.src'
include 'libc/tan.c.src'
include 'libc/tanh.c.src'
include 'libc/trunc.c.src'
include 'libc/ldexp.src'
include 'libc/ldexp.c.src'
include 'libc/exp.src'
include 'libc/exp.c.src'
include 'libc/copysign.src'
include 'libc/frexp.src'
include 'libc/frexp.c.src'
include 'libc/log.src'
include 'libc/log.c.src'
_sinhf := __sinhf_c
_coshf := __coshf_c



purge assume
purge public
purge private
purge section
purge ident
purge extern
purge require
