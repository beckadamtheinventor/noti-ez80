define bare? bare
namespace bare


fs_find_sym                  := $010134
fs_execute_file              := $010138
fs_create_file               := $01013C
fs_delete_file               := $010140

macro rom_file? name
	ROM_FILE=$
	db $01
	db name
	dl ROM_FILE.LEN
	ROM_FILE.START=$
	macro end_file
		ROM_FILE.LEN=$-ROM_FILE.START
		purge end_file
	end macro
end macro

macro sys_file? name
	ROM_FILE=$
	db $0F
	db name
	dl ROM_FILE.LEN
	ROM_FILE.START=$
	db "SYS"
	macro end_file
		ROM_FILE.LEN=$-ROM_FILE.START
		purge end_file
	end macro
end macro

end namespace
