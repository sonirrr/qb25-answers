#!/bin/bash

wget hg19.chrom.sizes https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes
bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed
mv ~/Downloads/hg19-kc.tsv .
wc hg19-kc.tsv
bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed > hg19-kc-count.bed
