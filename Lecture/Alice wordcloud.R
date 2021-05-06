# Alice
library(dplyr)
install.packages("readr")
library(readr)
library(devtools)
devtools::install_github("lchiffon/wordcloud2")
# wordcloud2(alice, figPath = "data/Alice_mask.png")


alice = read_file("data/Alice.txt")

library(tm)
library(SnowballC)

al = Corpus(VectorSource(alice))
al

al = tm_map(al,stripWhitespace) # 공백제거
al = tm_map(al, tolower) # 소문자화
al = tm_map(al, removeNumbers) # 숫자제거거
al = tm_map(al, removeWords, stopwords("en")) # 영문 불용어
al = tm_map(al, removePunctuation) # 구두점 제거

al = tm_map(al, stemDocument) # 어근 추출 / SnowballC 필요

dtm = TermDocumentMatrix(al) # DTM 만들기
dtm
dtm = as.matrix(dtm)
head(dtm)

rowSums(dtm)

v = sort(rowSums(dtm), decreasing = T)
d = data.frame(word = names(v), freq = v)
head(d)
