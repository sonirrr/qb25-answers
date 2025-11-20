#!/usr/bin/env python3

import sys

import numpy as np

from fasta import readFASTA


#====================#
# Read in parameters #

input_sequences = readFASTA(open(sys.argv[1]))
seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]


sigma_file = sys.argv[2]
gap_penalty = int(sys.argv[3])
out_file = sys.argv[4]

#====================#

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code


# Read the scoring matrix into a dictionary
fs = open(sigma_file)
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

#print(sigma[('A','G')])

# Read in the actual sequences using readFASTA

#=====================#
# Initialize F matrix #
#=====================#
f_matrix = np.zeros((len(sequence1) + 1, len(sequence2) + 1), dtype = int)

#=============================#
# Initialize Traceback Matrix #
#=============================#
t_matrix = np.empty((len(sequence1) + 1, len(sequence2) + 1), dtype = str)
t_matrix[0, :] = 'v'
t_matrix[:,0] = 'h'

#===================#
# Populate Matrices #
#===================#
for j in range(1, len(sequence2)+1): 
    f_matrix[0, j] = f_matrix[0, j-1] + gap_penalty

for i in range(1, len(sequence1) + 1): 
    f_matrix[i,0] = f_matrix[i - 1, 0] + gap_penalty

for i in range(1, len(sequence1)+1):
	for j in range(1, len(sequence2) + 1):
		v_score = gap_penalty + f_matrix[i - 1, j]
		h_score = gap_penalty + f_matrix[i, j-1]
		d_score = sigma[sequence1[i-1], sequence2[j-1]] + f_matrix[i-1, j-1]
		scores = [v_score, h_score, d_score]
		f_matrix[i,j] = max(scores)

		if np.argmax(scores) == 0:
			t_matrix[i,j] = "v"
		if np.argmax(scores) == 1:
			t_matrix[i,j] = "h"
		if np.argmax(scores) == 2:
			t_matrix[i,j] = "d"

#print(f_matrix)
#print(t_matrix)


#========================================#
# Follow traceback to generate alignment #
#========================================#

i = t_matrix.shape[0] -1
j = t_matrix.shape[1] -1
#print(t_matrix.shape)
#print(len(sequence1))
#print(len(sequence2))


sequence1_alignment = ""
sequence2_alignment = ""

while i >= 0 or j >= 0 :
	if t_matrix[i,j] == 'd':
		sequence1_alignment = sequence1_alignment + sequence1[i-1]
		sequence2_alignment = sequence2_alignment + sequence2[j-1]
		j = j-1
		i = i-1
	if t_matrix[i,j] == 'h':
		sequence1_alignment = sequence1_alignment + sequence1[i-1]
		sequence2_alignment = sequence2_alignment + "-"
		j = j-1
	if t_matrix[i,j] == 'v':
		sequence1_alignment = sequence1_alignment + "-"
		sequence2_alignment = sequence2_alignment + sequence2[j-1]
		i = i-1
	

#print(sequence1_alignment)
#print(f"\n")
#print(sequence2_alignment)

# The aligned sequences are assumed to be strings named sequence1_aligment
# and sequence2_alignment in later code


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

output = open(out_file, 'w')

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')


#=============================#
# Calculate sequence identity #
#=============================#
num_gaps1 = sequence1_alignment.count("-")
num_gaps2 = sequence2_alignment.count("-")
num_matches = identity_alignment.count("|")
seqid1 = round(identity_alignment.count("|")/len(sequence1) *100, 3)
seqid2 = round(identity_alignment.count("|")/len(sequence2) *100, 3)
align_score = f_matrix[f_matrix.shape[0] -1, f_matrix.shape[1] - 1]

#======================#
# Print alignment info #
#======================#

print(f"The number of gaps in sequence 1: {num_gaps1}")
print(f"The number of gaps in sequence 2: {num_gaps2}")
print(f"The sequence identity in sequence 1: {seqid1}%")
print(f"The sequence identity in sequence 2: {seqid2}%")
print(f"The alignment score for sequence 1 and sequence 2: {align_score}")


# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score
