#!/bin/bash

for sample in A01_02 A01_03 A01_04 A01_05 A01_06
do 
    echo "***" $sample
    bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/$sample.fq.gz > $sample.sam
    samtools sort -o $sample.bam $sample.sam
    samtools index $sample.bam
done