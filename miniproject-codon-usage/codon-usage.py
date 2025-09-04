#!/usr/bin/env python3
import sys
import fasta
import codons

my_file = open(sys.argv[1])
assemblies = fasta.FASTAReader(my_file)

aas = {}

for ident,sequence in assemblies:
    #print(f"ident: {ident}")
    for i in range(0,len(sequence),3):
        codon = sequence[i:(i+3)]
        aa = codons.forward.get(codon)
        if aa in aas:
            aas[aa] = aas[aa] + 1
        else:
            aas[aa] =  1

        #print(codon)

print(aas)


        