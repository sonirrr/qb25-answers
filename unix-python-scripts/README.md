wc ce11_genes.bed
#53935  323610 2200094 ce11_genes.bed
#53935 lines in the file

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

cut -f 6 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt|sort|uniq -c|sort|tail
#821 Colon
 #867 Lung
#1132 Muscle
#1141 Heart
#1327 Adipose Tissue
#1473 Blood Vessel
#1582 Esophagus
#2014 Skin
#3326 Brain
#3480 Blood
#Skin, Brain, and Blood have the most samples

grep RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt|wc
#20017 1288009 10820825
#20017 lines with "RNA" in them

grep -v RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
#2935 1351453 11512258 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
#2935 lines without "RNA" in them


cut -f 2 gencode.v46.basic.annotation.gtf|sort|uniq -c
#1 ##contact: gencode-help@ebi.ac.uk
   #1 ##date: 2024-03-26
   #1 ##description: evidence-based annotation of the human genome (GRCh38), version 46 (Ensembl 112)
   #1 ##format: gtf
   #1 ##provider: GENCODE
#123679 ENSEMBL
#1901207 HAVANA
#There are 123679 entries for feature type ENSEMBL and 1901207 entries for feature type HAVANA

grep "lncRNA" gencode.v46.basic.annotation.gtf|cut -f 1|sort|uniq -c
##13469 chr1
6251 chr10
6464 chr11
7867 chr12
4405 chr13
5684 chr14
7428 chr15
6937 chr16
6720 chr17
4092 chr18
5515 chr19
12332 chr2
3961 chr20
3284 chr21
3275 chr22
9268 chr3
7677 chr4
8385 chr5
8483 chr6
7627 chr7
7598 chr8
5398 chr9
3365 chrX
1176 chrY##
