wc ce11_genes.bed
#53935  323610 2200094 ce11_genes.bed
#53935 lines in the file
grep chrI ce11_genes.bed|wc
#38026  228156 1559286
#38026 lines for chrI
grep chrII ce11_genes.bed|wc
#11148   66888  460214
#11148 lines for chrII
grep + ce11_genes.bed|wc
#27309  163854 1114547
#27309 lines for + strand
grep - ce11_genes.bed|wc
#26626  159756 1085547
#26626 lines for - strand

cut -f 1 ce11_genes.bed | uniq -c
#5460 chrI
  #12 chrM
#9057 chrV
#6840 chrX
#6299 chrII
#21418 chrIV
#4849 chrIII

cut -f 6 ce11_genes.bed|sort|uniq -c
#26626 -
#27309 +
