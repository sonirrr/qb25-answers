library(tidyr)
library(dplyr)
library(matrixStats)

data <- read.table("/Users/cmdb/qb25-answers/week7/read_matrix.tsv")
data <- as.matrix(data)
#data <- data[order(rowSds(data), decreasing = TRUE),]
smalldata <- t(data[order(rowSds(data), decreasing = TRUE),][1:500,])

pca_results = prcomp(smalldata)
summary(pca_results)

pca_summary = tibble(PC1=pca_results$x[,1], PC2 = pca_results$x[,2])
pca_summary %>% ggplot(aes(x = PC1, y = PC2)) +
  geom_point()

pca_summary <- pca_summary %>% mutate(names = rownames(smalldata))
sep_pca_summary <- pca_summary %>% 
  separate(
    col = names,
    into = c("Tissue", "Replicate"),
    sep = "_",
    remove = TRUE
  )

sep_pca_summary %>% ggplot(aes(x = PC1, y = PC2, color = Tissue, shape = Replicate)) +
  geom_point()
#Two tissue types (Fe and LFC.Fe) are clustering with each other (one replicate of Fe is in the LFC.Fe cluster)
#Two values have been mislabeled (rows 12 and 13)

temp_row <- sep_pca_summary[12,]
sep_pca_summary[12,] <- sep_pca_summary[13,]
sep_pca_summary[13,] <- temp_row

sep_pca_summary[12,3] <- "LFC.Fe"
sep_pca_summary[13,3] <- "Fe"

sep_pca_summary %>% ggplot(aes(x = PC1, y = PC2, color = Tissue, shape = Replicate)) +
  geom_point()
#Physical location in the gut is separating out the clusters 
#(RNA expression from different tissue types correlates to different regions in the gut)


stdev <- data.frame(pc = 1:21, std = pca_results$sdev)

ggplot(stdev, aes(x = pc, y = std)) + 
    geom_col() + 
    labs(x = "PCA", y = "Standard Deviation")

data[, c(12,13)] <- data[, c(13,12)]

combined = data[,seq(1, 21, 3)]
combined = combined + data[,seq(2, 21, 3)]
combined = combined + data[,seq(3, 21, 3)]
combined = combined / 3

combined <- combined[rowSds(combined) > 1, ]

set.seed(42)
kmeans_results <- kmeans(centers = 12, as.matrix(combined), nstart = 100)
kmeans_results$cluster
clusters <- as.data.frame(kmeans_results$cluster)

order_kmeans_results <- kmeans_results[order(kmeans_results$cluster)]$cluster
order_combined <- combined[order(order_kmeans_results), ]

heatmap(order_combined, Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[order_kmeans_results], ylab="Gene")
heatmap(order_combined)

#clusters of interest: 2 and 3

cluster2 <- clusters %>%
  filter(`kmeans_results$cluster` == 2)

cluster3 <- clusters %>%
  filter(`kmeans_results$cluster` == 3)

cluster5 <- clusters %>%
  filter(`kmeans_results$cluster` == 5)

cluster7 <- clusters %>%
  filter(`kmeans_results$cluster` == 7)

cluster9 <- clusters %>%
  filter(`kmeans_results$cluster` == 9)

cluster11 <- clusters %>%
  filter(`kmeans_results$cluster` == 11)
  
cluster2genes <- rownames(cluster2)
cluster3genes <- rownames(cluster3)
cluster5genes <- rownames(cluster5)
cluster7genes <- rownames(cluster7)
#none of these produce enrichment results??

cluster9genes <- rownames(cluster9)
cluster11genes <- rownames(cluster11)

