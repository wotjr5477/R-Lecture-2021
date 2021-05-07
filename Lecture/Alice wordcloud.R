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

al = Corpus(VectorSource(alice))

al = tm_map(al, tolower) # 소문자화
#al = tm_map(al, content_transformer(tolower)) # 소문자화
al = tm_map(al, removeNumbers) # 숫자제거거
al = tm_map(al, removeWords, c(stopwords("en"), "said"))# 영문 불용어
al = tm_map(al, removePunctuation) # 구두점 제거
al = tm_map(al, stripWhitespace) # 공백제거

#al = tm_map(al, stemDocument) # 어근 추출 / SnowballC 필요


tdm = TermDocumentMatrix(al)
tdm
tdm = as.matrix(tdm)
dim(tdm)

v2 = sort(rowSums(tdm), decreasing = T)
d2 = data.frame(word = names(v2), freq = v2)
d400 = d2[1:400,]

head(d400)

wordcloud2(d2)


wordcloud2(d400)

###########################################################

ali = readLines("data/Alice.txt") # 줄별로 읽어들임
head(ali)


ali = Corpus(VectorSource(alice))

#ali = tm_map(ali, tolower) # 소문자화
ali = tm_map(ali, content_transformer(tolower)) # 소문자화
ali = tm_map(ali, removeNumbers) # 숫자제거거
ali = tm_map(ali, removeWords, c(stopwords("en"), "said"))# 영문 불용어
ali = tm_map(ali, removePunctuation) # 구두점 제거
ali = tm_map(ali, stripWhitespace) # 공백제거
#ali = tm_map(ali, stemDocument) # 어근 추출 / SnowballC 필요

dtm = DocumentTermMatrix(ali) # DTM 만들기
dtm
dtm = as.matrix(dtm) # 행열로
dim(dtm)

v = sort(colSums(dtm), decreasing = T)
d = data.frame(word = names(v), freq = v)
d500 = d[1:500,]
head(d500)

wordcloud2(d500)

