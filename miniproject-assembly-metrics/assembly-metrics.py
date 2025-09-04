#!/usr/bin/env python3
import sys
import fasta

my_file = open(sys.argv[1])
assemblies = fasta.FASTAReader(my_file)
total_length = 0
num_contig = 0

for ident,sequence in assemblies:
    length = len(sequence)
    total_length += length
    num_contig += 1

average_length = total_length/num_contig
print(f"Number of contigs: {num_contig}")
print(f"Total length: {total_length}")
print(f"Average length: {average_length}")