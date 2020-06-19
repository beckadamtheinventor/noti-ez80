
execMem             :=  $D1A881
tempMem             :=  $D03000
sys_exec_arguments  :=  $D00800

_keymaps:
	dl _keymap_A,_keymap_a,_keymap_1,0
_keymap_A:
	db "#WRMH  ?!VQLG  :ZUPKFC  YTOJEB  XSNIDA"
_keymap_a:
	db "#wrmh  ?!vqlg  :zupkfc  ytojeb  xsnida"
_keymap_1:
	db "+-*/^  ;369)$@ .258(&~ 0147,][  ",$1A,"<=>}{"
_overtypes:
	db "Aa1"
string_welcome:
	db "Welcome to BareOS!",0
string_return_to_bootloader:
	db "Return to bootloader?",0
;string_press_enter_confirm:
;	db "Press enter to confirm.",0
string_noti_bootcode:
	db "noti bootcode",0
string_invalid_executable:
	db "Invalid executable format",0
string_file_not_found:
	db "File not found.",0
string_invalid_sys:
	db "Invalid SYS executable.",0
string_file_not_executable:
	db "File is not executable.",0

system_files:
sys_file_1:
	db fs_system_bit+fs_executable_bit+fs_exists_bit
	dl .len
	db "RM",0
.data:
	db "SYS"
	ld hl,sys_exec_arguments
	ld a,(hl)
	or a,a
	jq z,.fail_no_args
	push hl
.loop:
	call ti._strlen
	push hl
	pop bc
	pop hl
	jr z,.exit
	push hl
	ld a,' '
	ld bc,0
	cpir
	xor a,a
	ld (hl),a
	ex (sp),hl
	push hl
	call fs_delete_file
	pop hl
	jr .loop
.exit:
	xor a,a
	ret
.fail_no_args:
	ld hl,.string_help
	call noti.putSAndNewLine
	xor a,a
	ret
.string_help:
	db "RM FILE [...]",0
.len:=$-.data


sys_file_2:
	db fs_system_bit+fs_executable_bit+fs_exists_bit
	dl .len
	db "MKF",0
.data:
	db "SYS"
	ld hl,sys_exec_arguments
	ld a,(hl)
	or a,a
	jq z,.fail_no_args
	push hl
.loop:
	call ti._strlen
	add hl,bc
	or a,a
	sbc hl,bc
	push hl
	pop bc
	pop hl
	jr z,.exit
	push hl
	ld a,' '
	cpir
	xor a,a
	ld (hl),a
	inc hl
	ex (sp),hl
	push hl
	call fs_create_file
	pop hl
	jr .loop
.exit:
	pop hl
	xor a,a
	ret
.fail_no_args:
	ld hl,.string_help
	call noti.putSAndNewLine
	xor a,a
	ret
.string_help:
	db "MKF FILE [...]",0
.len:=$-.data

sys_file_3:
	db fs_system_bit+fs_executable_bit+fs_exists_bit
	dl .len
	db "APP",0
.data:
	db "SYS"
	ld hl,sys_exec_arguments
	ld a,(hl)
	or a,a
	jq z,.fail_no_args
	push hl
	call ti._strlen
	add hl,bc
	or a,a
	sbc hl,bc
	push hl
	pop bc
	pop hl
	jr z,.exit
	ld ($D00000),hl ;file name
	ld a,' '
	cpir
	xor a,a
	ld (hl),a
	inc hl
	push hl ;data to write
	call ti._strlen
	pop bc
	push hl
	push bc
	ld bc,($D00000)
	push bc
	call fs_append_file
	pop bc,bc,bc
.exit:
	xor a,a
	ret
.fail_no_args:
	ld hl,.string_help
	call noti.putSAndNewLine
	xor a,a
	ret
.string_help:
	db "APP FILE DATA",0
.len:=$-.data

sys_file_4:
	db fs_system_bit+fs_executable_bit+fs_exists_bit
	dl .len
	db "WRT",0
.data:
	db "SYS"
	ld hl,sys_exec_arguments
	ld a,(hl)
	or a,a
	jq z,.fail_no_args
	push hl
	call ti._strlen
	add hl,bc
	or a,a
	sbc hl,bc
	push hl
	pop bc
	pop hl
	jr z,.exit
	ld ($D00000),hl
	ld a,' '
	cpir
	xor a,a
	ld (hl),a
	inc hl
	push hl
	call ti._strlen
	pop bc
	push hl
	push bc
	ld bc,($D00000)
	push bc
	call fs_write_file
	pop bc,bc,bc
.exit:
	xor a,a
	ret
.fail_no_args:
	ld hl,.string_help
	call noti.putSAndNewLine
	xor a,a
	ret
.string_help:
	db "WRT FILE DATA",0
.len:=$-.data

	db $FF



