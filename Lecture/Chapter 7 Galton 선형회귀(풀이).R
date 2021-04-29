# 210429


# Galton 선형회귀 : 교수님 풀이
library(dplyr)
library(ggplot2)

df = read.csv("http://www.randomservices.org/random/data/Galton.txt", sep = "\t")
head(df)

# 아버지와 아들의 키
galton = df %>% filter(Gender == "M") %>%
  mutate(father=Father, son=Height)

