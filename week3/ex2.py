#!/usr/bin/env python3
import sys
#both af and rd files must already exist, this script appends them 

af_filename = sys.argv[1]
rd_filename = sys.argv[2]

read_depths = []
allele_frequency = []

for line in open("/Users/cmdb/qb25-answers/week3/biallelic.vcf"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')
    for val in fields[7].split(";"):
        if "SAF=" in val:
            continue
        if "AF=" in val:
            allele_frequency.append(float((val.strip("AF="))))
    format = fields[9].split(":")
    read_depths.append(format[2])

with open(af_filename, 'a') as f:
    for af in allele_frequency:
        print(af, file = f)

with open(rd_filename, 'a') as f:
    for rd in read_depths:
        print(rd, file = f)

        




        
