library (tidyverse)
setwd("/Users/cmdb/qb25-answers/week3")

#3.1: the samples that derive from the wine strain have many snps next to each other in this region
#because this does not align to the reference lab genome

colnames = c("sample", "chromosome", "position", "genotype")

data <- read_tsv("chII_A01_62_gt_long.txt", col_names = colnames)

#data["genotype"] <- as.factor(data["genotype"])

data <- data %>%
  mutate(genotype = as.factor(genotype))

ggplot(data, aes(x = position, y = chromosome, color = genotype)) + 
geom_point() 

#genotype 1 is almost exclusively found at the ends of the chromosome, while genotype 0 is a long run in the middle
#this could be because mutations in the middle of the chromosome do not produce viable organisms
#or because no recombination occurs in the middle of the chromosome (near the centromere)

full_data <- read_tsv("A01_62_gt_long.txt", col_names = colnames)
full_data <- full_data %>%
  mutate(genotype = as.factor(genotype))

ggplot(full_data, aes(x = position, y = chromosome, color = genotype)) + 
  geom_point() + 
  facet_grid(.~sample, scales = "free_x", space = "free_x")

all_data <- read_tsv("gt_long.txt", col_names = colnames)
all_data <- all_data %>%
  mutate(genotype = as.factor(genotype))
ggplot(all_data, aes(x = position, y = chromosome, color = genotype)) + 
  geom_point() + 
  facet_grid(.~sample, scales = "free_x", space = "free_x")
  

