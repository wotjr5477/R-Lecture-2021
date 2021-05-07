# Alice
library(dplyr)
#install.packages("readr")
library(readr)
library(devtools)
#devtools::install_github("lchiffon/wordcloud2")
library(wordcloud2)
library(tm) # text mining library
library(SnowballC)

# wordcloud2(alice, figPath = "data/Alice_mask.png")


alice = read_file("data/Alice.txt") # 파일 채로 읽음
head(alice)

ali = readLines("data/Alice.txt") # 줄별로 읽어들임
head(ali)

al = Corpus(VectorSource(alice))

al = tm_map(al, tolower) # 소문자화
#al = tm_map(al, content_transformer(tolower)) # 소문자화
al = tm_map(al, removeNumbers) # 숫자제거거
al = tm_map(al, removeWords, c(stopwords("en"), "said"))# 영문 불용어
al = tm_map(al, removePunctuation) # 구두점 제거
al = tm_map(al, stripWhitespace) # 공백제거

#al = tm_map(al, stemDocument) # 어근 추출 / SnowballC 필요

dtm = DocumentTermMatrix(al) # DTM 만들기
dtm
dtm = as.matrix(dtm) # 행열로
dim(dtm)

v = sort(rowSums(dtm), decreasing = T)
d = data.frame(word = names(v), freq = v)
head(d)

wordcloud2(d)


tdm = TermDocumentMatrix(al)
tdm
tdm = as.matrix(tdm)
dim(tdm)

v2 = sort(rowSums(tdm), decreasing = T)
d2 = data.frame(word = names(v2), freq = v2)
head(d2)

wordcloud2(d2)

