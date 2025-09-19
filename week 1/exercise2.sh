#!/bin/bash

wget hg16.chrom.sizes https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed
cut -f1-3,5 hg16-kc.tsv > hg16-kc.bed
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed > hg16-kc-count.bed

bedtools intersect -a nhek-active.bed -b nhek-repressed.bed
#reported nothing, so there is no overlap between the active and the repressed in NHEK

bedtools intersect -a nhlf-active.bed -b nhlf-repressed.bed
#reported nothing, so there is no overlap between the active and the repressed in NHLF

wc hg19-kc.bed                                     
#80270 genes in hg19

bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc
#42717 genes in hg19 that are not in hg16
#hg19 is the more recent version of the human genome, so it is possible that they discovered new genes 
#(that were previously thought to be junk DNA) or they filled holes in the sequencing data

wc hg16-kc.bed
#21365 genes in hg16

bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed| wc
#3460 genes in hg16 that are not in hg19
#these could have been misidentified genes 
#or genes that were double counted (two genes that were actually one gene and one regulatory sequence)

