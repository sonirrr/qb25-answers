#!/usr/bin/env python3

import sys
my_file = open(sys.argv[1])

for line in my_file:
    if line[0].startswith("#") == True:
        break
    else:
        print(line[2])
        new_start = line[1] - 1
        attribute = line[7].split(";")
        split_attribute = attribute[2].split(" ")
        gene_name = split_attribute[1]
        print(f"{line[0]} {line[1]} {line[2]} {gene_name}")