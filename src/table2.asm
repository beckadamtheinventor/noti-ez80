
;pad until $700. Hopefully enough room for standard bootcode functions
paduntil $700
	jp boot_wait_key_cycle
	jp _boot_SetVRAM
	jp _boot_SetBuffer
	jp boot_gfx_compute
	jp boot_gfx_horizontal
	jp boot_gfx_vertical
	jp boot_gfx_rectangle
	jp boot_gfx_filled_rectangle
	jp boot_homeup
	jp _boot_PutS
	jp _boot_PutC
	jp _boot_puts_and_new_line
	jp _boot_drawstatusbar
	jp _boot_blit_buffer
	jp _boot_ClearVRAM
	jp _boot_ClearBuffer
	jp _cphlde
	jp _loadDEInd_s
	jp _setHLUTo0
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
	riemann
;place noti bootcode identifier, so programs/OSs can easily tell
assert $=$7F0
	db "noti bootcode",0,0,0
	jp END_OF_JUMPS

END_OF_JUMPS:

paduntil $1000
