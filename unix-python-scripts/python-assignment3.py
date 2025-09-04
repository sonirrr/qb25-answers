#!/usr/bin/env python3
# this is for Comp Bootcamp 2025 Sept. 3 afternoon assignment
# Exercise 6: Export gene features to BED format using Python

import sys
my_file = open(sys.argv[1])

for line in my_file:
    line = line.split("\t")
    if line[0].startswith("#") != True: 
        new_start = int(line[3]) - 1
        attribute = line[8].split(";")
        split_attribute = attribute[3].split(',')
        gene = split_attribute[0].split(" ")
        gene_name = gene[2]
        print(f"{line[0]}\t{line[3]}\t{line[4]}\t{gene_name}")