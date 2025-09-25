#!/usr/bin/env python3

import sys

my_file = open(sys.argv[1])
chr_dict = {}
nm_dict = {}
total_nm_count = 0

for line in my_file:
    if line[0].startswith("@") == True:
        head_split = line.split("\t")
        for v in head_split:
            if v.startswith("NM:i:"):
                total_nm_count +=1
    else:
        split_line = line.split("\t")
        for val in split_line:
            if val.startswith("NM:i:"):
                total_nm_count += 1
                nm_key = int(val.split("NM:i:")[1])

        if split_line[2].startswith("NM:i:") == True:
            new_key = split_line[2].split("NM:i:")
        else:
            new_key = split_line[2]
        if chr_dict.get(new_key) is None:
            chr_dict[new_key] = 1
        else:
            chr_dict[new_key] += 1
        
        if nm_dict.get(nm_key) is None:
            nm_dict[nm_key] = 1
        else:
            nm_dict[nm_key] += 1



#for keys in chr_dict.keys():
  #  print(f"{keys}; {chr_dict[keys]}")

print(f"Number of total mismatches: {total_nm_count}")

print(chr_dict)
#confirmed to be same as samtools idxstats

for key in sorted(nm_dict.keys()):
    print(f"{key} {nm_dict.get(key)}")

my_file.close()

