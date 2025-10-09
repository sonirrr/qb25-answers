library (tidyverse)
setwd("/Users/cmdb/qb25-answers/week3")


AFdata <- read_csv("AF.txt", col_names = FALSE)

ggplot(AFdata, aes(x = X1))+ 
  geom_histogram(bins = 11)

#interpretation: most of these variants are fairly common
#this looks like a normal distribution centered near 0.5
#I think this makes sense/is expected because, given the read depth, we are most likely to catch fairly common variants
DPdata <- read_csv("DP.txt", col_names = FALSE)

ggplot(DPdata, aes(x = X1)) +
  xlim(0, 20) + 
  geom_histogram(bins = 11)

#this is a right-tail distribution, and the majority of variants have a read depth less than 10
#I think this means that we don't have many reads for each of these variants, whic h

