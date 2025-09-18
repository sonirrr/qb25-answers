#!/bin/bash
bedtools intersect -a nhek-active.bed -b nhek-repressed.bed
#reported nothing, so there is no overlap between the active and the repressed in NHEK

bedtools intersect -a nhlf-active.bed -b nhlf-repressed.bed
#reported nothing, so there is no overlap between the active and the repressed in NHLF

bedtools intersect -wa -a nhek-active.bed -b nhlf-active.bed
#returned every entry in A that was also found in B
#returns list of regions that are active in both NHEK and NHLF

bedtools intersect -v -wa -a nhek-active.bed -b nhlf-active.bed
#returned every entry in A that was not also found in B
#returns list of regions that are active in NHEK but not active in NHLF

bedtools intersect -wa -a nhek-active.bed -b nhlf-active.bed | wc
#12174 entries total
bedtools intersect -v -wa -a nhek-active.bed -b nhlf-active.bed | wc
#2405 entries total
#12174+2405 is greater than 14013

bedtools intersect -wa -u -a nhek-active.bed -b nhlf-active.bed | wc
#11608 entries total, 11608+2405 = 14013

bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed | head
#first entry: chr1	25558413	25559413

bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed | head
#first entry: chr1	19923013	19924213

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head
#first entry: chr1	1051137	1051537
#the relationship between the NHEK and NHLF chromatin state shrinks as the overlap parameter becomes more stringent

bedtools intersect -a nhek-active.bed -b nhlf-active.bed | head
#first entry: chr1	19923013 19924213
#NHLF: active
#NHEK: active
#K562: active with enhancer
#HUVEC: active with enhancer
#HSMM: active
#HMEC: active with enhancer
#HepG2: active
#H1-hESC: active
#GM12878: active

bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed | head
#first entry: chr1	1981140	1981540
#NHLF: repressed 
#NHEK: active
#K562: half insulated, half under weak enhancer
#HUVEC: half enhanced, half poised
#HSMM: repressed
#HMEC: active
#HepG2: active with enhancer
#H1-hESC: active
#GM12878: active

bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed | head
#first entry: chr1	11537413	11538213
#NHLF: repressed
#NHEK: repressed
#K562: heterochromatin
#HUVEC: heterochromatin
#HSMM: repressed
#HMEC: repressed
#HepG2: heterochromatin 
#H1-hESC: repressed
#GM12878: heterochromatin