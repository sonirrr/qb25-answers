# Computational Bootcamp 2025 Day 3 Sept. 4, 2025
# Codon Usage Mini-Project #2

Prompt 2: Parsing CDS sequences into three nucleotide codons
Script codon-usage.py, tested using subset of cytoplasm.fa named subset.fa
Prints ident string followed by long list of three letter codons (correct format for output)
For all idents, first codon output is ATG (start codon) and last codon is AGC or TGA (stop codon) - indicates that the script parses sequence into codons correctly (not out of frame)
Different number of codons for each ident corresponds with different length sequences - script is moving through different entries in fasta file correctly in the loop