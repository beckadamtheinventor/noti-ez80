#!/usr/bin/python
import os
import sys

max_data_length = 65000

filename_in = sys.argv[1]
with open(filename_in, "rb") as infile:
    no_extension = os.path.splitext(filename_in)[0]

    with open(no_extension + ".bin", "wb") as outfile:
        first_var_data_length = 0x020000 - 2 * max_data_length
        outfile.write(bytes("bootcode"))
        outfile.write(bytearray({0}))
        outfile.write(infile.read(first_var_data_length))
    with open(no_extension + "1.bin", "wb") as outfile:
        outfile.write(infile.read(max_data_length))
    with open(no_extension + "2.bin", "wb") as outfile:
        outfile.write(infile.read(max_data_length))

trimmed_name = str(os.path.basename(no_extension))[:8]
print(trimmed_name)

os.system("convbin -r -j bin -k 8xv -i" + no_extension + ".bin -o " + no_extension + ".8xv -n " + trimmed_name)
os.system("convbin -r -j bin -k 8xv -i" + no_extension + "1.bin -o " + no_extension + "1.8xv -n " + trimmed_name + "1")
os.system("convbin -r -j bin -k 8xv -i" + no_extension + "2.bin -o " + no_extension + "2.8xv -n " + trimmed_name + "2")