library (tidyverse)
setwd("/Users/cmdb/qb25-answers/Week 1")

header <- c("chr", "start", "end", "count")
df_kc19 <- read_tsv("hg19-kc-count.bed", col_names = header)
df_kc16 <- read_tsv("hg16-kc-count.bed", col_names = header)

combdf_kc <- bind_rows( df_kc19, df_kc16, .id="assembly" )

ggplot(data = combdf_kc, aes(x = start, y = count, color = assembly)) + 
  geom_line() + facet_wrap("chr", scales = "free")

