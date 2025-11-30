#!/usr/bin/env python3

import numpy as np
import scipy
import matplotlib.pyplot as plt
import sys


genomesize = 1000000
readLength = 100
coverage = int(sys.argv[1])
#outfile = sys.argv[2]

#num_reads = calculate_number_of_reads(genomesize, readlength, coverage)
num_reads = int((genomesize*coverage) / readLength)

## use an array to keep track of the coverage at each position in the genome
genome_coverage = np.zeros(genomesize)

for i in range(num_reads):

  startpos = np.random.uniform(0,genomesize-readLength+1)
  endpos = int(startpos) + int(readLength)
  genome_coverage[int(startpos):int(endpos)] += 1

## get the range of coverages observed
maxcoverage = int(np.max(genome_coverage))
xs = np.arange(0, maxcoverage+1)

## Get the poisson pmf at each of these
poisson_estimates = scipy.stats.poisson.pmf(xs, mu= coverage)

## Get normal pdf at each of these (i.e. the density between each adjacent pair of points)
normal_estimates = scipy.stats.norm.pdf(xs, loc = coverage, scale = np.sqrt(coverage))

poisson_freq = poisson_estimates * num_reads
normal_freq = normal_estimates * num_reads


## now plot the histogram and probability distributions

plt.hist(genome_coverage, bins = 50, density = True, alpha = 0.5)
plt.xlabel("Coverage depth")
plt.ylabel("Probability density")
plt.plot(xs, poisson_estimates, label = "Poisson")
plt.plot(xs, normal_estimates, label = "Normal")
plt.legend()
plt.show()

#Exercise 2
reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
k = 3

graph = set()

for read in reads:
  for i in range(len(read) - k):
     kmer1 = read[i: i+k]
     kmer2 = read[i+1: i+1+k]
     graph.add(f"{kmer1} -> {kmer2}")
     
     #add "kmer1 -> kmer2" to graph

#for each edge in graph:
  # print edge
print("digraph G {")
for edge in graph:
  k1, k2 = edge.split(" -> ")
  print(f'  "{k1}" -> "{k2}";')
print("}")