1: 3 MB/100 bp = 30,000

1.4: about 20% of the genome has not been sequenced
- there is a higher probability at every coverage depth compared than either the Poisson or the normal distribution expects

1.5: very close to 0% of the genome has a 0x coverage depth
- The middle of the histogram corresponds better to both the poisson and the normal distribution
- indicating a better spread of coverage over the entire genome

1.6: 0% of the genome has a 0x coverage depth
- The shape of the histogram roughly follows both the poisson and the normal distribution
- But there are two very sharp peaks (one between 20 and 30 and the other between 30 and 40)
- A greater proportion of the genome is being covered at ~25x and ~35x compared to every other coverage value

2.4: dot -Tpng dotfile.dot -o ex2_digraph.png

2.5: Possible sequence
ATTGATTCATTCTTATTT

2.6: To reconstruct the sequence of the genome, I would walk through this graph
But I would also need additional information to get the correct number of repeats and other edge cases
