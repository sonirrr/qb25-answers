#!/usr/bin/env python3
import sys
import fasta
import codons

file1 = open(sys.argv[1])
file2 = open(sys.argv[2])
assembly1 = fasta.FASTAReader(file1)
assembly2 = fasta.FASTAReader(file2)

aas1 = {}
aas2 = {}

for ident,sequence in assembly1:
    #print(f"ident: {ident}")
    for i in range(0,len(sequence),3):
        codon = sequence[i:(i+3)]
        aa = codons.forward.get(codon)
        if aa in aas1:
            aas1[aa] = aas1[aa] + 1
        else:
            aas1[aa] =  1

        #print(codon)

for ident,sequence in assembly2:
    #print(f"ident: {ident}")
    for i in range(0,len(sequence),3):
        codon = sequence[i:(i+3)]
        aa = codons.forward.get(codon)
        if aa in aas2:
            aas2[aa] = aas2[aa] + 1
        else:
            aas2[aa] =  1

aa_list = list(codons.reverse.keys())
aa_list = sorted(aa_list)
print(aa_list)
for j in range(0, len(aa_list)):
    current_aa = aa_list[j]
    print(f"{current_aa}\t{aas1.get(current_aa)}\t{aas2.get(current_aa)}\n")
        