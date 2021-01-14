@echo off
mkdir bin

fasmg src/BareOS/usbrun.asm src/BareOS/usbrun.bin
fasmg src/lib/fatdrvce/fatdrvce.asm src/lib/fatdrvce/fatdrvce.bin
fasmg src/lib/srldrvce/srldrvce.asm src/lib/srldrvce/srldrvce.bin
fasmg src/lib/usbdrvce/usbdrvce.asm src/lib/usbdrvce/usbdrvce.bin
fasmg src/lib/libload/libload.asm src/lib/libload/libload.bin
fasmg src/main.asm bin/NOTI.rom
