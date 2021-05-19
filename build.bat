@echo off
mkdir bin

REM fasmg src/BareOS/usbrun.asm src/BareOS/usbrun.bin
REM fasmg src/lib/fatdrvce/fatdrvce.asm src/lib/fatdrvce/fatdrvce.bin
REM fasmg src/lib/srldrvce/srldrvce.asm src/lib/srldrvce/srldrvce.bin
REM fasmg src/lib/usbdrvce/usbdrvce.asm src/lib/usbdrvce/usbdrvce.bin
REM fasmg src/lib/libload/libload.asm src/lib/libload/libload.bin
fasmg src/main.asm bin/NOTI.rom
