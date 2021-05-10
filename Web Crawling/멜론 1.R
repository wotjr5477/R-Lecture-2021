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

table = html %>%
  html_node("div.service_list_song") %>%
  html_node("table")

trs = table %>%
  html_node("tbody") %>% html_nodes("tr")

# 1등
tr = trs[1]
tr
rank = tr %>% html_node("span.rank") %>% html_text()
rank
rank = as.integer(rank); rank

# 지난 주 순위
# 1, 2, 3, 22 (순서대로, 유지 상승 하강 신규)
tds = html_nodes(tr, "td")
html_text(tds[3])

for (i in c(1,2,3,22)){
  tr = trs[i]
  tds = html_nodes(tr, "td")
  spans = html_nodes(tds[3], "span"); spans
  last_str = html_text(spans[3])
  
  if (length(spans) ==4) {
    t = as.integer(html_text(spans[4]))
    if (last_str == "순위동일") {
      last_rank = rank
    } else if (last_str == "단계상승") {
      last_rank = rank + t
    } else {
      last_rank = rank -t
    }
  } else {
    last_rank = 999
  }
  print(last_rank)
}

  #print(length(spans))
  #tds[3] %>% html_node("span.none") %>% html_text()
  #print(change)
  #print(html_text(tds[3]))


# 곡 정보
anchors = tr %>% html_node(".wrap_song_info") %>%
  html_nodes("a")
title = html_text(anchors[1]); title
artist = html_text(anchors[2]); artist

title = tr %>% html_node(".ellipsis.rank01") %>%
  html_node("a") %>%
  html_text()
artist = tr %>% html_node(".ellipsis.rank02") %>%
  html_node("a") %>%
  html_text()
album = tr %>% html_node(".ellipsis.rank03") %>%
  html_node("a") %>%
  html_text()
artist; title; album

rank_vec = c()
last_vec = c()
title_vec = c()
artist_vec = c()
album_vec = c()

for ( tr in trs) {
  
  rank = tr %>% html_node("span.rank") %>% html_text()
  rank = as.integer(rank); rank
  
  tds = html_nodes(tr, "td")
  spans = html_nodes(tds[3], "span")
  last_str = html_text(spans[3])
  
  if (length(spans) ==4) {
    t = as.integer(html_text(spans[4]))
    if (last_str == "순위동일") {
      last_rank = rank
    } else if (last_str == "단계상승") {
      last_rank = rank + t
    } else {
      last_rank = rank -t
    }
  } else {
    last_rank = 999
  }
  
  title = tr %>% html_node(".ellipsis.rank01") %>%
    html_node("a") %>%
    html_text()
  artist = tr %>% html_node(".ellipsis.rank02") %>%
    html_node("a") %>%
    html_text()
  album = tr %>% html_node(".ellipsis.rank03") %>%
    html_node("a") %>%
    html_text()
  
  rank_vec = c(rank_vec, rank)
  last_vec = c(last_vec, last_rank)
  title_vec = c(title_vec, title)
  artist_vec = c(artist_vec, artist)
  album_vec = c(album_vec, album)
}

week_chart = data.frame(
  rank=rank_vec, last_rank=last_vec, title=title_vec,
  artist=artist_vec, album=album_vec
)
View(week_chart)
