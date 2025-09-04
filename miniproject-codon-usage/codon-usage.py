#!/usr/bin/env python3
import sys
import fasta

my_file = open(sys.argv[1])
assemblies = fasta.FASTAReader(my_file)

for ident,sequence in assemblies:
    #print(f"ident: {ident}")
    for i in range(0,len(sequence),3):
        codon = sequence[i:(i+3)]
        #print(codon)

        