
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
	jp _unpackDynamicLibrary
	jp _boot_ClearVRAM
	jp _boot_ClearBuffer
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
	riemann
	riemann
;place noti bootcode notice, so programs/OSs can easily tell
assert $=$7F0
	db "noti bootcode",0
	jp END_OF_JUMPS
	jp _pushOP1
	jp _pushOP2
	jp _pushOP3
	jp _pushOP4
	jp _pushOP5
	jp _pushOP6
	jp _popOP1
	jp _popOP2
	jp _popOP3
	jp _popOP4
	jp _popOP5
	jp _popOP6
	jp _mov9ToOP1
	jp _mov9ToOP2
	jp _mov9ToOP3
	jp _mov9ToOP4
	jp _mov9ToOP5
	jp _mov9ToOP6
	jp _mov11b
	jp _mov9b
	jp _mov8b
END_OF_JUMPS:

paduntil $1000
