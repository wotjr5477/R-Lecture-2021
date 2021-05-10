# 210510

# 멜론 차트 웹 크롤링

library(rvest)
library(stringr)
library(dplyr)
library(httr)

url = "https://www.melon.com/chart/week/index.htm"
read_html(url)
ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
res = GET(url = url, user_agent(agent = ua))
html = read_html(res)
html

