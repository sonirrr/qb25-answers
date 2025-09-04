# Computational Bootcamp 2025 Day 3 Sept. 4, 2025
# Codon Usage Mini-Project #2

Prompt 2: Parsing CDS sequences into three nucleotide codons
Script codon-usage.py, tested using subset of cytoplasm.fa named subset.fa
Prints ident string followed by long list of three letter codons (correct format for output)
For all idents, first codon output is ATG (start codon) and last codon is AGC or TGA (stop codon) - indicates that the script parses sequence into codons correctly (not out of frame)
Different number of codons for each ident corresponds with different length sequences - script is moving through different entries in fasta file correctly in the loop

Counting amino acid abundance in subset.fa 
Output: {'M': 3, 'P': 13, 'F': 7, 'L': 17, 'E': 10, 'D': 5, 'T': 11, 'N': 5, 'A': 17, 'R': 9, 'V': 8, 'G': 12, 'K': 6, 'C': 4, 'S': 13, 'I': 7, 'Q': 3, 'H': 3, 'Y': 1, '*': 1}
Numbers variable enough to correspond with real amino acid sequences
While debugging, printed out every amino acid as each codon was translated, compared against that list this output is correct

Amino acid abundance in cytoplasm.fa
{'M': 988, 'P': 2762, 'F': 1610, 'L': 4769, 'E': 3544, 'D': 2252, 'T': 2633, 'N': 1704, 'A': 3183, 'R': 2622, 'V': 2525, 'G': 2663, 'K': 2570, 'C': 954, 'S': 3808, 'I': 1907, 'Q': 2166, 'H': 1273, 'Y': 1201, '*': 100, 'W': 535}
Amino acid abundance in membrane.fa
{'M': 1010, 'A': 3364, 'E': 2953, 'S': 4272, 'R': 2511, 'G': 3143, 'L': 5044, 'Y': 1438, 'W': 595, 'C': 1031, 'F': 1961, 'V': 2921, 'I': 2365, 'K': 2207, 'P': 3053, 'T': 3468, 'H': 1224, 'Q': 1879, 'N': 1797, 'D': 2039, '*': 100}

There are more charged amino acids in the cytoplasm because the inner surface of the membrane is non-polar and hydrophobic, as opposed to the cytoplasm which is filled with water-based cytosol