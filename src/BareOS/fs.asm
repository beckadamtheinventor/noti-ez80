
; file VAT flags
fs_exists_bit      := 1 shl 0 ;reset this to mark a file for deletion
fs_new_file_bit    := 1 shl 1 ;indicates file must be created upon writing

; file data flags. If the flag byte is equal to $FF, then assume there are no remaining files
;fs_exists_bit      := 1 shl 0 ;reset this to mark a file for deletion (same as VAT flag)
fs_executable_bit  := 1 shl 1
fs_system_bit      := 1 shl 2
fs_read_only_bit   := 1 shl 3

fs_temp_name_ptr   := $D00101 ;store temp name pointer. temp names are file that have not yet been written to.
fs_VAT_start       := $D01000 ;$2000 bytes = 2048x4 byte entries
fs_VAT_ptr         := $D00104 ;points to current end of VAT pointer
fs_flash_ptr       := $D00107 ;first sector of user flash memory
fs_end_flash_ptr   := $D00108 ;points to end of user flash memory
fs_temp_name_start := $D00140 ;start of temporary file name stack

fs_build_VAT:
	push ix
	ld ix,fs_VAT_start
	ld hl,system_files
	call .loop
	or a,a
	sbc hl,hl
	ld (ScrapMem),hl
	ld a,(fs_flash_ptr)
	ld (ScrapMem+2),a
	ld hl,(ScrapMem)
	call .loop
	ld (fs_VAT_ptr),ix
	pop ix
	ret
.loop:
	ld a,(hl)
	cp a,$FF
	ret z    ;if flag byte = $FF, there are no more user files to account for
	bit fs_exists_bit,a
	jr z,.dont_count
	ld a,fs_exists_bit
	ld (ix),a
	ld (ix+1),hl
	lea ix,ix+4
.dont_count:
	inc hl ;bypass flags
	ld de,(hl)
	inc hl
	inc hl
	inc hl ;bypass length
	ld bc,0
	xor a,a
	cpir   ;bypass name
	add hl,de ;bypass file
	jr .loop


fs_get_file_name:
	push hl
	bit fs_new_file_bit,(hl)
	inc hl
	ld bc,(hl)
	jr nz,.new_file
	inc bc
	inc bc
	inc bc
	inc bc
.new_file:
	pop hl
	ret

fs_find_sym:
	pop hl
	pop de
	push de
	push hl
	push ix
	ld hl,fs_VAT_start
.loop:
	push hl
	push de
	call fs_get_file_name
	push bc
	call ti._strcmp
	xor a,a
	or a,l
	pop bc
	pop de
	pop hl
	jr z,.found
	inc hl
	inc hl
	inc hl
	inc hl
	ld bc,(fs_VAT_ptr)
	or a,a
	sbc hl,bc
	add hl,bc
	jr c,.loop
	scf
	pop ix
	ret
.found:
	or a,a
	pop ix
	ret


fs_execute_file:
	pop bc
	pop hl
	push hl
	push bc
	push hl
	call fs_find_sym
	pop bc
	jq c,.file_not_found
	inc hl
	ld hl,(hl)
	ld a,(hl)
	bit fs_exists_bit,a
	jq z,.file_not_found
	bit fs_executable_bit,a
	jq z,.fail_not_executable
	ld ($D00000),a
	inc hl
	ld bc,(hl)
	ld ($D00001),bc
	inc hl
	inc hl
	inc hl ;bypass flag byte and length bytes
	ld bc,0
	xor a,a
	cpir ;bypass name
	ld de,(hl)
	ex hl,de
	db $01,'XZE' ;EZX
	or a,a
	sbc hl,bc
	jr z,.exec_EZX
	add hl,bc
	db $01,'SYS' ;SYS
	or a,a
	sbc hl,bc
	jr z,.exec_SYS
	add hl,bc
	ex hl,de
	ld a,(hl)
	cp a,$EF
	jq z,.maybe_EF7B
	jq .invalid_exe
.exec_SYS:
	ld a,($D00000)
	bit fs_system_bit,a
	jr c,.not_a_system_file
	ex hl,de
	inc hl
	inc hl
	inc hl
	jp (hl)
.exec_EZX:
	ex hl,de
	inc hl
	inc hl
	inc hl
.test_data:
	ld a,(hl)
	cp a,$C7
	jr z,.bypass_icon
	cp a,$CF
	jr z,.bypass_description
	jp (hl)
.bypass_icon:
	ld b,(hl)
	inc hl
	ld c,(hl)
	inc hl
	mlt bc
	add hl,bc
	jr .test_data
.bypass_description:
	ld bc,0
	xor a,a
	cpir
	jr .test_data
.maybe_EF7B:
	inc hl
	ld a,(hl)
	cp a,$7B
	jr nc,.invalid_exe
	inc hl
	ld bc,($D00001)
	dec bc
	dec bc
	ld de,execMem
	push de
	ldir
	ret
.not_a_system_file:
	ld hl,string_invalid_sys
	jp ErrorHandler
.invalid_exe:
	ld hl,string_invalid_executable
	jp ErrorHandler
.fail_not_executable:
	ld hl,string_file_not_executable
	jp ErrorHandler
.file_not_found:
	ld hl,string_file_not_found
	jp ErrorHandler
.failed:
	scf
	ret


fs_create_file:
	ld hl,3
	add hl,sp
	ld hl,(hl)
	ld de,(fs_temp_name_ptr)
	push hl
	push de
	call ti._strcpy
	pop bc
	pop hl
	ld hl,(fs_VAT_ptr) ;end of VAT pointer
	ld (hl),fs_new_file_bit+fs_exists_bit
	inc hl
	ld (hl),bc      ;store pointer to file name
	inc hl
	inc hl
	inc hl
	ld (fs_VAT_ptr),hl ;advance VAT
	push bc
	pop hl
	xor a,a
	ld bc,0
	cpir
	ld (fs_temp_name_ptr),hl ;advance temp name pointer
	ret


fs_delete_file:
	call fs_find_sym
	ret c
	res fs_exists_bit,(hl)
	bit fs_new_file_bit,(hl)
	call z,.mark_flash_data
	xor a,a
	ret
.mark_flash_data:
	inc hl
	ld hl,(hl)
	ld a,(hl)
	res fs_exists_bit,a
	ex hl,de
	jp ti.WriteFlashByte


fs_write_file:
	call fs_find_sym
	ret c
	push ix
	push hl
	pop ix
	push iy
	ld iy,3
	add iy,sp
	ld hl,(iy) ;file name
	push hl
	call ti._strlen
	pop ix
	push hl
	pop bc
	bit fs_new_file_bit,(ix)
	ld hl,(fs_end_flash_ptr)
	push hl
	inc bc
	push bc
	add hl,bc
	ld bc,(iy+9) ;length of data to write
	add hl,bc
	ld bc,4 ;flag byte + file length
	add hl,bc
	ld (fs_end_flash_ptr),hl
	xor a,a
	bit fs_new_file_bit,(ix)
	jr z,.no_file_flags
	ld hl,(ix+1) ;get the old file pointer
	ld a,(hl)
.no_file_flags:
	pop hl
	pop bc
	set fs_exists_bit,a
	push bc
	ex hl,de
	call ti.WriteFlashByte
	pop bc
	ld hl,$D00000
	ld (hl),bc
	ld bc,3
	call ti.WriteFlash
	ld hl,(iy)
	call ti.WriteFlash
	ld bc,(iy+9)
	ld hl,(iy+6)
	call ti.WriteFlash
	pop iy
	pop ix
	ret

fs_append_file:
	call fs_find_sym
	ret c
	push ix
	push hl
	pop ix
	push iy
	ld iy,0
	add iy,sp
	ld hl,(iy+3) ;file name
	push hl
	call ti._strlen
	pop bc
	push hl
	pop bc
	bit fs_new_file_bit,(ix)
	ld hl,(fs_end_flash_ptr)
	push hl
	ld hl,(ix+1)
	inc hl
	ld de,(hl) ;get old file length
	ld ($D00006),de ;save old file length
	inc hl
	inc hl
	inc hl
	xor a,a
	push bc
	ld bc,0
	cpir
	pop bc
	inc hl
	ld ($D00003),hl ;save old file pointer
	pop hl
	push hl
	inc bc
	push bc
	add hl,bc
	add hl,de ;add old file length
	ld bc,(iy+9) ;length of data to write
	add hl,bc
	ld bc,4 ;flag byte + file length
	add hl,bc
	ld (fs_end_flash_ptr),hl
	xor a,a
	bit fs_new_file_bit,(ix)
	jr z,.no_file_flags
	ld hl,(ix+1) ;get the old file pointer
	ld a,(hl)
.no_file_flags:
	pop hl
	pop bc
	set fs_exists_bit,a
	push bc
	ex hl,de
	call ti.WriteFlashByte ;write file flags
	pop bc
	ld hl,$D00000
	ld (hl),bc
	ld bc,3
	call ti.WriteFlash ;write file size
	push de
	ld hl,(iy+3)
	push hl
	call ti._strlen
	push hl
	pop bc
	pop hl
	pop de
	inc bc
	call ti.WriteFlash ;write file name
	ld hl,($D00003)
	ld bc,($D00006)
	call ti.WriteFlash ;write old file data
	ld hl,(iy+6)
	ld bc,(iy+9)
	call ti.WriteFlash ;write data to append
	pop iy
	pop ix
	ret

