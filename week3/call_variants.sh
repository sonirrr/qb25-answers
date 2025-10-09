#!/bin/bash

for filename in "/Users/cmdb/qb25-answers/week3/BYxRM_bam"/*; do
    samtools view -c $filename >> read_counts.txt
done

ls *.bam > bamListFile.txt

freebayes -f '/Users/cmdb/qb25-answers/week 2/genomes/sacCer3.fa' -L bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf
#change this to .fagz file from data folder