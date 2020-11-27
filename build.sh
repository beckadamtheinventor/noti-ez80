#!/bin/bash

mkdir -p bin
mkdir -p obj

fasmg src/main.asm bin/NOTI.rom

read -p "Finished. Press enter to continue."
