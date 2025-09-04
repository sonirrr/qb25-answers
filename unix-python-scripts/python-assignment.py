#!/usr/bin/env python3
# this is for Comp Bootcamp 2025 Sept. 3 afternoon assignment
# Exercise 2: Recalculate ce11_genes.bed scores using Python

import sys
my_file = open(sys.argv[1])

for line in my_file:
    line = line.strip("\n")
    line = line.split("\t")
    new_score = int(line[4])*(int(line[2])-int(line[1]))
    if line[5] == "-":
        new_score = -1*new_score
    print(f"{line[0]}\t{line[1]}\t{line[2]}\t{line[3]}\t{new_score}\t{line[5]}\t")




