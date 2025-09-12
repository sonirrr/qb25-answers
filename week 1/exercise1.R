library (tidyverse)
setwd("/Users/cmdb/qb25-answers/Week 1")
header <- c("chr", "start", "end", "count")
df_kc <- read_tsv("hg19-kc-count.bed", col_names = header)

filter(chr == "chr1")

ggplot(data = df_kc, aes(x = start, y = count)) + 
  geom_line() + facet_wrap("chr", scales = "free")
  
ggsave("exercise1.png")
