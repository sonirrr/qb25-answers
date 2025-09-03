#!/usr/bin/env python3

import sys
my_file = open(sys.argv[1])

_ = my_file.readline()
_ = my_file.readline()

header = my_file.readline()
header = header.split("\t")

data = my_file.readline()
data = data.split("\t")

new_dict = {}
i = 0

for j in data:
    new_dict[header[i]] = data[i]
    i+=1

new_file = open(sys.argv[1])
for line in new_file:
    if new_dict.get(line[0]) is None:
        print(line)
