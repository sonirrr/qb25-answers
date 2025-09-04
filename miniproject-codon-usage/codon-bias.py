#!/usr/bin/env python3
import sys
import fasta
import codons

my_file = open(sys.argv[1])
aa = sys.argv[2]

assemblies = fasta.FASTAReader(my_file)
counts = {}

for ident,sequence in assemblies:
    for i in range(0,len(sequence),3):
        codon = sequence[i:(i+3)]
        amino = codons.forward.get(codon)
        if codon in counts:
            counts[codon] = counts[codon] + 1
        else:
            counts[codon] =  1
        

codon_list = codons.reverse.get(aa)
for k in range(0, len(codon_list)):
    print(f"{codon_list[k]}\t{counts.get(codon_list[k])}")

