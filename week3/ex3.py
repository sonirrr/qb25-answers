#!/usr/bin/env python3

import sys

#input vcf file and output file name

#this list must be in the same order as the ids are in the vcf file
#code assumes there are 9 columns before these columns (standard vcf format)
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

vcf_file = open(sys.argv[1])
output_filename = sys.argv[2]

output_file = open(output_filename, 'w')

is_print = False
#genotype = 2

for line in vcf_file:
    if line.startswith("#"):
        continue
    fields = line.split("\t")
    chrom = fields[0]
    pos = fields[1]
    for sample in sample_ids:
        index = sample_ids.index(sample) + 9
        sample_info = fields[index].split(":")
        if sample_info[0] == '0':
            genotype = 0
            is_print = True    
        elif sample_info[0] == '1':
            genotype = 1
            is_print = True
        else:
            is_print = False
            continue
        print(is_print)
        if is_print is True:
            print(f"{sample} \t {chrom} \t {pos} \t {genotype}", file = output_file)
        else:
            continue





