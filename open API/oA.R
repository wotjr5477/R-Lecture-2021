# 다음 책 검색
library(httr)
library(jsonlite)

kakao_api_key <- readLines('openAPI/kakao_api_key.txt')
kakao_api_key
base_url <- 'https://dapi.kakao.com/v3/search/book'
query <- URLencode(iconv('데이터 분석', to='UTF-8'))
query_str <- paste0('target=title&query=', query)
url <- paste(base_url, query_str, sep='?')
url
auth_key <- paste('KakaoAK', kakao_api_key); auth_key
res <- GET(url,
           add_headers('Authorization'=auth_key))
res_str <- as.character(res); res_str
result <- fromJSON(res_str); result
df <- data.frame(result)
View(df)

write.csv(df, 'openAPI/book.csv', fileEncoding = "utf-8")
# 결과가 릿트이기 때문에 매트릭스로 변환하여 저장
write.table(as.matrix(df), 'openAPI/book.csv', 
            fileEncoding='utf-8', row.names=F, sep='\t')
# 내용중에 ","가 있어서 제대로 못 읽기 때문에 sep를 \t로 변경
df2 <- read.csv('data/book.csv', fileEncoding='utf-8', sep='\t')
View(df2)