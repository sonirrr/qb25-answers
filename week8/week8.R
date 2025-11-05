library(tidyr)
library(DESeq2)
library(broom)


gtex_metadata <- read.csv("/Users/cmdb/qb25-answers/week8/gtex_metadata_downsample.txt")
gene_locations <- read_tsv("/Users/cmdb/qb25-answers/week8/gene_locations.txt")
gtex_wholeblood <- read.csv("/Users/cmdb/qb25-answers/week8/gtex_whole_blood_counts_downsample.txt")
                          
gtex_wholeblood <- gtex_wholeblood %>% column_to_rownames(var = "GENE_NAME")
gtex_metadata <- gtex_metadata %>% column_to_rownames(var = "SUBJECT_ID")
rownames(gtex_metadata) <- sub("-", ".", rownames(gtex_metadata))


colnames(gtex_wholeblood) == rownames(gtex_metadata)
#this returns TRUE for all, so they are in the same order

dds <- DESeqDataSetFromMatrix(countData = gtex_wholeblood, 
                              colData = gtex_metadata, 
                              design = ~ DTHHRDY + SEX + AGE)

vsd <- vst(dds)
plotPCA(vsd, intgroup = "DTHHRDY")
plotPCA(vsd, intgroup = "SEX")
plotPCA(vsd, intgroup = "AGE")

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(gtex_metadata, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
#this gene does not show significant evidence of sex-differential expression because 
#the p-value for the "sex" term is greater than 0.05

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

#this gene (SLC25A47) does show significant evidence of sex-differntial expression because
#the p-value for the "sex" term is less than 0.05
#but because it is 0.025, I don't think this is a very strong correlation
#this is a positive correlation because the estimate value is greater than 0
#if the sex is male, correlated with upregulation of this gene

#2.2
dds <- DESeq(dds)

res <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

diff_res <- res %>% filter(padj < 0.1)
nrow(diff_res)
#262 genes exhibit differential expression at a 10% FDR

diff_res <- left_join(diff_res, gene_locations, by = "GENE_NAME")
diff_res <- diff_res[order(diff_res$padj),]

#the top hits are genes that are encoded on the X or Y chromosome
#the majority of these hits are on the Y chromosome and upregulated in males
#this makes sense, given that we looked specifically for genes that are differentially regulated by sex
#and it makes sense that genes on the Y chromosome show the biggest difference in regulation, since 
#females do not have a Y chromosome

wash7p <- diff_res[diff_res$GENE_NAME == "WASH7P", "padj"]
print(wash7p)
slc25a47 <- diff_res[diff_res$GENE_NAME == "SLC25A47", "padj"]
print(slc25a47)
#WASH7P: DEseq filtered to remove this gene because it has a low probability of being DE
# this corresponds to my previous analysis, which also said this gene was not significantly differentially expressed
#SLC25A47: this shows significant differential expression, which corresponds to previous analysis
#these results are broadly consistent

res1 <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")

diff_res1 <- res1 %>% filter(padj < 0.1)
nrow(diff_res1)
#16069 genes are differentially expressed according to 10% FDR

diff_res1 <- left_join(diff_res1, gene_locations, by = "GENE_NAME")
diff_res1 <- diff_res1[order(diff_res1$padj),]

shuffle_gtex_metadata <- gtex_metadata
shuffle_gtex_metadata$SEX <- sample(shuffle_gtex_metadata$SEX, replace = FALSE)

shuffle_dds <- DESeqDataSetFromMatrix(countData = gtex_wholeblood, 
                                colData = shuffle_gtex_metadata, 
                                design = ~ DTHHRDY + SEX + AGE)
shuffle_dds <- DESeq(shuffle_dds)

res2 <- results(shuffle_dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

diff_res2 <- res2 %>% filter(padj < 0.1)
nrow(diff_res2)
#189 genes are significant in the shuffled analysis
#this means that 189 of the 262 genes are false positives
#over 70% of the genes are false positives, indicating that this FDR is too low

ggplot(res, aes(x = log2FoldChange, y = -log10(padj), color = (abs(log2FoldChange) > 1) & (padj < 0.1))) +
  geom_point()

  