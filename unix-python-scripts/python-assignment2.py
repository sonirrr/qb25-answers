#!/usr/bin/env python3
# this is for Comp Bootcamp 2025 Sept. 3 afternoon assignment
# Exercise 4: Transform GTEx data using Python

import sys
my_file = open(sys.argv[1])
new_file = open(sys.argv[2])

line1 = my_file.readline()
line2 = my_file.readline()

header = my_file.readline()
header = header.split("\t")

data = my_file.readline()
data = data.split("\t")

new_header = new_file.readline()
new_header = new_header.split("\t")

SMTSD_column = new_header.index("SMTSD")

new_dict = {}
i = 0
expression_column = []

for j in data:
    new_dict[header[i]] = data[i]
    i+=1

k=0
for line in new_file:
    line = line.split("\t")
    if new_dict.get(line[0]) is not None:
        expression_column.append(new_dict.get(line[0]))
        expression_column.sort()
        print(f"{line[0]}\t{expression_column[k]}\t{line[SMTSD_column]}")
        k+=1

#the first three tissues that have >0 gene expression are 
# "Brain - Cortex", "Adrenal Gland", and "Thyroid"