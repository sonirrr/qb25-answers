
Question 1
bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam
samtools sort -o A01_01.bam A01_01.sam
samtools index A01_01.bam
samtools idxstats A01_01.bam > A01_01.idxstats

Question 2
This visualization is showing the overall coverage of the reference genome from each sample and each read from each sample, highlighting SNPs 

Question 4
minimap2 -a -x map-ont '/Users/cmdb/qb25-answers/week 2/genomes/sacCer3.fa' '/Users/cmdb/qb25-answers/week 2/rawdata/ERR8562478.fastq' > longreads.sam

samtools sort -o longreads.bam longreads.sam

Question 5

hisat2 -p 4 -x sacCer3 -U SRR10143769.fastq > rna.sam 
Beginnings and ends of exons appear to have the most coverage