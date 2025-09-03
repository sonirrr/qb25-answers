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

grep RNA GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct|wc
#1376 23920384 58969389 
#1376 lines with "RNA" in them
