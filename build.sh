#!/bin/bash
#----------------------------------------
#Put your program name in place of "DEMO"
name='OPENCE.rom'
#----------------------------------------

mkdir "bin" || echo ""

echo "compiling to $name"
~/CEdev/bin/fasmg src/main.asm bin/$name

read -p "Finished. Press any key to exit"
