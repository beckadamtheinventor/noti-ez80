
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
install_from_usb:
	db "Install OS from FAT32 USB drive. Place file OS.ROM into root of FAT32 formatted USB flash drive. Plug drive into calculator and press enter. Press clear to cancel.",0




