library(tidyverse)
library(broom)
setwd("/Users/cmdb/qb25-answers/week4")

dnm <- read_csv("aau1043_dnm.csv")

dnm_father <- dnm %>% filter(Phase_combined == "father")
dnm_father <- dnm_father[order(dnm_father$Proband_id),]
num_fathers <- as.data.frame(table(dnm_father$Proband_id))
colnames(num_fathers) <- c("Proband_id", "Father")

dnm_mother <- dnm %>% filter(Phase_combined == "mother")
dnm_mother <- dnm_mother[order(dnm_mother$Proband_id),]
num_mothers <- as.data.frame(table(dnm_mother$Proband_id))
colnames(num_mothers) <- c("Proband_id", "Mother")

mother_father <- left_join(num_mothers, num_fathers, by = "Proband_id")

parent_ages <- read_csv("aau1043_parental_age.csv")
mother_father$Proband_id <- as.numeric(as.character(mother_father$Proband_id))

counts_ages <- inner_join(mother_father, parent_ages, by = "Proband_id")

ggplot(counts_ages, aes(x = Mother_age, y = Mother)) + 
  geom_point() +
  labs(x = "Maternal Age", y = "DNM Frequency")

ggplot(counts_ages, aes(x = Father_age, y = Father)) + 
  geom_point() + 
  labs(x = "Paternal Age", y = "DNM Frequency")


lm(data = counts_ages, 
   formula = Mother ~ Mother_age) %>%
  summary()

lm(data = counts_ages,
   formula = Father ~ Father_age) %>%
  summary()

t.test(counts_ages$Mother, counts_ages$Father, paired = TRUE)

diff_dnm <- counts_ages$Mother - counts_ages$Father

lm(diff_dnm ~1) %>%
  summary()

ggplot(counts_ages, aes(x = Mother, y = Father)) + 
  geom_point()

df <- data.frame(
  value = c(dnm_mother, dnm_father),
  dataset = factor(c(rep("Mother", length(dnm_mother)), rep("Father", length(dnm_father))))
)

ggplot(df, aes(x = value, fill = dataset)) +
  geom_histogram(alpha = 0.5, position = "identity", bins = 30) +
  scale_fill_manual(values = c("Mother" = "blue", "Father" = "red")) +
  theme_minimal()
  

#for question 3, downloaded Gutenberg data from Tidy Tuesday Github
gutenberg_authors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_authors.csv')
gutenberg_languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_languages.csv')
gutenberg_metadata <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_metadata.csv')
gutenberg_subjects <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_subjects.csv')


# Mostly clean data provided by the {gutenbergr} package. (taken from tidy tuesday github)
# install.packages("gutenbergr")
library(gutenbergr) 
library(dplyr)
gutenberg_metadata <- gutenbergr::gutenberg_metadata
gutenberg_authors <- gutenbergr::gutenberg_authors
gutenberg_languages <- gutenbergr::gutenberg_languages |>
  # Fix a typo in the current CRAN version of the package.
  dplyr::mutate(language = as.factor(language))
gutenberg_languages$lanuage <- NULL
gutenberg_subjects <- gutenbergr::gutenberg_subjects

#Question: Do authors who have alias/write under different names have their work translated into more languages than authors who do not?
#anwer will probably be yes because most of the aliases are just the author's name in a different language or spelled differently when translated into english

#pseudocode
#go from author alias to author id in gutenberg_authors (output: author_id with alias True or False)
#go from author id to guten_berg id by going from gutenberg_authors to gutenberg_metadata (output: new column with all book ids for every author)
#go from guten_berg id to number of languages in gutenberg_languages (output: highest number of languages out of all guten_berg ids)

final_guten <- data.frame("Author ID" = gutenberg_authors$gutenberg_author_id)

final_guten$Alias <- is.na(gutenberg_authors$alias)


#break this up into multiple step
final_guten$Author.ID

x <- gutenberg_metadata %>% filter(gutenberg_author_id == final_guten$Author.ID) 


final_guten$Book.ID <- gutenberg_metadata[gutenberg_author_id == final_guten$Author.ID]$gutenberg_id


palmtrees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-18/palmtrees.csv')
palmtrees$fruit_size_categorical <- as.factor(palmtrees$fruit_size_categorical)


#Plotting fruit length as a function of height
ggplot(palmtrees, aes(x = max_stem_height_m, y = max_fruit_length_cm))+
  geom_point() 
ggplot(palmtrees, aes(x = max_leaf_number, y = max_fruit_length_cm)) + 
  geom_point()
#Plotting fruit width vs length
ggplot(palmtrees, aes(x = average_fruit_length_cm, y = average_fruit_width_cm, fill = fruit_size_categorical))+
  geom_point(shape = 21, size = 2)

#Linear model hypothesis: Do trees with more leaves grow bigger fruit? 
lm(data = palmtrees, 
   formula = average_fruit_length_cm ~ max_leaf_number) %>%
  summary()
#Yes and this is statistically significant (p-value 1.06e-12)
#slope is very small though (0.05), so this is a very small correlation
#could be argued that this is not a correlation, but I think it might be a small correlation because
#every extra leaf probably has a very, very small effect on tree photosynthesis
#could also be that healthier trees overall have more fruit and more leaves, but would need more data to determine this