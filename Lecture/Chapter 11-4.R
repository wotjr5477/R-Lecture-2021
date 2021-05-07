# R library를 이용한 전처리
library(RCurl)
library(XML)
library(stringr)

html = readLines("https://en.wikipedia.org/wiki/Data_science")
html = htmlParse(html,asText = T)
doc = xpathSApply(html, "//p", xmlValue)
doc

library(tm)
library(SnowballC)

doc = Corpus(VectorSource(doc))
doc
inspect(doc)

doc = tm_map(doc, content_transformer(tolower)) # 소문자 변환
doc = tm_map(doc, removeNumbers) # 숫자 제거
doc = tm_map(doc, removeWords, stopwords("english")) # 불용어 제거
doc = tm_map(doc, removePunctuation) # 구두점 제거
doc = tm_map(doc, stripWhitespace) # 공백 제거

##########################
### DTM 구축 ###
################
dtm = DocumentTermMatrix(doc)
dim(dtm)
inspect(dtm)


################
## Word Cloud ##
################
library(wordcloud)
m = as.matrix(dtm)
v = sort(colSums(m), decreasing = T)
v[1:5]
df = data.frame(word = names(v), freq = v)
head(df)
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words = 100, random.order = F, rot.per = 0.35)

# Alice
library(devtools)
devtools::install_github("lchiffon/wordcloud2")

alice = readLines("c:/workspace/R/Lecture/data/Alice.txt")
alice = htmlParse(alice,asText = T)
alice = xpathSApply(alice, "//p", xmlValue)

library(tm)
library(SnowballC)

alice = Corpus(VectorSource(alice))
inspect(alice)

alice = tm_map(alice, content_transformer(tolower)) # 소문자 변환
alice = tm_map(alice, removeNumbers) # 숫자 제거
alice = tm_map(alice, removeWords, stopwords("english")) # 불용어 제거
alice = tm_map(alice, removePunctuation) # 구두점 제거
alice = tm_map(alice, stripWhitespace) # 공백 제거

dtm = DocumentTermMatrix(alice)
dim(alice)
inspect(alice)


library(wordcloud2)
wordcloud2(alice, figPath = "data/Alice_mask.png")

d200 = df[1:200,]
wordcloud2(d200, shape = "star")
wordcloud2(d200, minRotation = pi/6, maxRotation = pi/3, rotateRatio = 1.0)
wordcloud2(d200, figPath = "data/Alice_mask.png")
?wordcloud2

install.packages("htmlwidgets")
install.packages("tmltools")
install.packages("jsonlite")
install.packages("yaml")
install.packages("base64enc")
