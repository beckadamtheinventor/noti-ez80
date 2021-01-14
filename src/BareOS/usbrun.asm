

include '../../include/ez80.inc'
include '../../include/ti84pceg.inc'
include '../../noti-ez80.inc'

usb_sector_buffer := $D01000
usb_device := $D01400
msd_device := $D01400
partition_descriptor := $D01480
fat_dir_entries := $D01500
fat_device := $D01600
fat_volume_label := $D01680


org $D1A881
	jq usbrun_main
	db "REX",0
usbrun_main:
	ld (_ErrSP),sp
	call libload_load
	jq z,usbrun_main.main
	ld hl,str_FailedToLoadLibload
	call putSAndNewLine
	scf
	sbc hl,hl
	ret

libload_load:
	ld   de,libload_relocations
	ld   bc,.notfound
	push   bc
	jp noti.JumpToLibload
.notfound:
	xor   a,a
	inc   a
	ret

usbrun_main.main:
;init USB
	ld bc, 12  ;USB_DEFAULT_INIT_FLAGS
	push bc
	ld bc, 0       ;use default device descriptors
	push bc
	ld bc, usb_device
	push bc     ;and pass the usb device for the Opaque pointer
	ld bc,main_event_handler
	push bc
	call usb_Init
	pop bc,bc,bc,bc
	or a,a
	add hl,bc
	sbc hl,bc
	jq nz,no_drive_found
main_init_start:
	ld hl,str_WaitingForDevice
	call putSAndNewLine
.loop:
	call usb_WaitForInterrupt
	add hl,bc
	or a,a
	sbc hl,bc
	jq nz,main_exit
	ld hl,(usb_device)
	add hl,bc
	or a,a
	sbc hl,bc
	jq z,.loop
	call main_msd_Init
	jq z,.init_success
.init_fail:
	ld hl,str_FailedToInitMsd
	call putSAndNewLine
	jq main_exit
.init_success:
	ld hl,str_MsdInited
	call putSAndNewLine
init_explore_drive:
	call init_fat_partition
	jq z,open_file
.init_fat_fail:
	ld hl,str_FailedToInitFat

main_print_and_exit:
	call putSAndNewLine
	call noti.waitKeyCycle
;Cleanup USB
main_exit:
	ld bc,msd_device
	push bc
	call msd_Deinit
	pop bc
	call usb_Cleanup
	jq _exit



reset_smc_bytes:
	ld a,$01 ;ld bc,...
	ld (main_msd_Init),a
	ld a,$0E ;ld c,...
	ld (init_fat_partition),a
	ret


main_msd_Init:
	ld bc,usb_sector_buffer
	ld hl,msd_device
	ld de,(hl)
	push bc,de,hl
	call msd_Init
	pop bc,bc,bc
	ld a,$C9 ;smc to ret so this routine doesn't try to re-init the drive constantly.
	ld (.),a
	add hl,bc
	or a,a
	sbc hl,bc
	ret


init_fat_partition:
	ld c,1
	push bc
	ld bc,found_partitions
	push bc
	ld bc,partition_descriptor
	push bc
	ld bc,msd_device
	push bc
	ld hl,str_LookingForPartitions
	call putSAndNewLine
	call fat_Find
	pop bc,bc,bc,bc
	add hl,bc
	or a,a
	sbc hl,bc
	ret nz
	ld hl,(found_partitions)
	add hl,bc
	or a,a
	sbc hl,bc
	jq z,.no_partitions
	ld bc,partition_descriptor
	push bc
	ld bc,fat_device
	push bc
	ld hl,str_InitializingPartition
	call putSAndNewLine
	call fat_Init
	pop bc,bc
	add hl,bc
	or a,a
	sbc hl,bc
	ret nz
	ld hl,str_FatInited
	call putSAndNewLine
	ld a,$C9
	ld (.),a ;smc so we don't run this code again
	or a,a
	sbc hl,hl
	ret
.no_partitions:
	ld hl,str_NoParitions
	call putSAndNewLine
	ld a,1
	or a,a
	ret



;usb_error_t main_event_handler(usb_event_t event, void *event_data, usb_callback_data_t *callback_data);
main_event_handler:
	call ti._frameset0
	ld hl,(ix+6)
	ld a,l
	cp a, 1 ;USB_DEVICE_DISCONNECTED_EVENT
	jq z,.device_disconnected
	cp a, 2 ;USB_DEVICE_CONNECTED_EVENT
	jq z,.device_connected
	cp a, 4 ;USB_DEVICE_ENABLED_EVENT
	jq z,.device_enabled
	jq .success
.print_then_success:
	call putSAndNewLine
.success:
	pop ix
	xor a,a
	sbc hl,hl
	ret
.device_enabled:
	ld de,(ix+9)
	ld (usb_device),de
	ld hl,(ix+12)
	ld (hl),de
	ld hl,str_DeviceEnabled
	jq .print_then_success
.device_connected:
	ld de,(ix+9)
	push de
	call usb_ResetDevice
	pop bc
	ld hl,str_DeviceConnected
	jq .print_then_success
.device_disconnected:
	ld de,0
	ld hl,(ix+12)
	ld (hl),de
	ld hl,str_DeviceDisconnected
	jq .print_then_success



no_drive_found:
	ld hl,.string
	call putSAndNewLine
	ld hl,-2
	jq _exit
.string:
	db $9,"No avalible drive found.",0

_exit:
	ld sp,0
_ErrSP:=$-3
	xor a,a
	sbc hl,hl
	ret

putSAndNewLine:
	call noti.putSAndNewLine
	jp noti.blitBuffer

str_NoParitions:
	db "No Partitions found.",0
str_LookingForPartitions:
	db "Looking for partitions...",0
str_InitializingPartition:
	db "Initializing partition...",0
found_partitions:
	dl 0
str_UsbRun:
	db "USB Program Executor",0
str_WaitingForDevice:
	db $9,"Waiting for device...",$A
	db "Please insert USB flash drive.",0
str_FailedToInitFat:
	db $9,"Failed to initialize drive.",$A
	db "Are you sure it is FAT32 formatted?",0
str_FailedToInitMsd:
	db $9,"Failed to init device.",0
str_FailedToLoadLibload:
	db "Failed to load libload.",0
str_DeviceConnected:
	db "Device connected.",0
str_DeviceDisconnected:
	db "Device disconnected",0
str_FatInited:
	db "FAT Filesystem initialized.","Read/Write can now occur",0
str_MsdInited:
	db "Device initialized.",0
str_DeviceEnabled:
	db "Device Enabled.",0
str_FileNotFound:
	db $9,"File not found.",0
str_MemoryError:
	db $9,"Not Enough Memory.",0
str_InavlidExecutable:
	db "Invalid Executable Format. Aborting.",0
os_rom_file:
	db "/OS.ROM",0

libload_relocations:
db $C0,"USBDRVCE",0,0
usb_Init:
	jp 0
usb_Cleanup:
	jp 3
usb_HandleEvents:
	jp 9
usb_WaitForInterrupt:
	jp 15
usb_ResetDevice:
	jp 39

db $C0,"FATDRVCE",0,1
msd_Init:
	jp 0
msd_Deinit:
	jp 6
msd_Reset:
	jp 9
fat_Find:
	jp 24
fat_Init:
	jp 27
fat_Deinit:
	jp 30
fat_Open:
	jp 39
fat_Close:
	jp 42
fat_GetSize:
	jp 48
fat_SetFilePos:
	jp 57
fat_ReadSectors:
	jp 63

	xor   a,a      ; return z (loaded)
	pop   hl      ; pop error return
	ret

open_file:
	ld hl,os_rom_file
	ld c,1 shl 0
	ld de,fat_device
	push bc,hl,de
	call fat_GetSize
	ld (.file_descriptor),hl
	ld a,(.file_descriptor+2)
	dec a
	ld (.sectors_to_copy),a
	call fat_Open
	pop bc,bc,bc
	add hl,bc
	or a,a
	sbc hl,bc
	jq nz,.copy_file_opened
	ld hl,str_FileNotFound
	jq main_print_and_exit
.copy_file_opened:
	ld (.file_descriptor),hl
	ld bc,$020000/512
	push bc,hl
	call fat_SetFilePos
	pop bc,bc
	ld bc,$010000
	ld (.current_sector),bc
	ld b,0
.sectors_to_copy:=$-1
.read_loop:
	push bc
	ld hl,0
.file_descriptor:=$-3
	ld bc,$D30000
	ld de,65536/512
	push bc,de,hl
	call fat_ReadSectors
	pop bc,bc,bc
	ld a,(.current_sector+2)
	inc a
	ld (.current_sector+2),a
	call $2DC
	ld hl,$D30000
	ld de,$010000
.current_sector:=$-3
	ld bc,$010000
	call $2E0
	pop bc
	djnz .read_loop
	call usb_Cleanup
	rst $00

