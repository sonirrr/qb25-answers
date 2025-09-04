#!/usr/bin/env python3
import sys
import fasta

my_file = open(sys.argv[1])
assemblies = fasta.FASTAReader(my_file)
total_length = 0
num_contig = 0
cum_length = 0
contig_lengths = []

for ident,sequence in assemblies:
    length = len(sequence)
    total_length += length
    num_contig += 1
    contig_lengths.append(length)

average_length = total_length/num_contig
print(f"Number of contigs: {num_contig}")
print(f"Total length: {total_length}")
print(f"Average length: {average_length}")

contig_lengths.sort(reverse = True)
for i in range(0, len(contig_lengths)):
    cum_length = sum(contig_lengths[0:i])
    if cum_length > (0.5*total_length):
        print(f"N50 stat: {contig_lengths[i]}")
        break



