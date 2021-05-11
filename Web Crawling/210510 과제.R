# 210510
library(rvest)
library(stringr)
library(dplyr)
library(httr)

# 한빛 미디어 책목록 25페이지까지 (제목/저자/페이지수/가격)

title_v = c() # 제목
writer_v = c() # 저자
page_v = c() # 페이지 수
price_v = c() # 가격

for (p in c(1:25)) {
  if (p==12) next;
  # 웹 사이트 읽기
  base_url = "https://www.hanbit.co.kr/media/books" # 메인주소
  sub_url = "new_book_list.html" # 서브주소
  url <- paste(base_url, sub_url, sep='/') # 전체 주소
  page_url = paste0(url, "?page=", p) # 1~25 page 주소
  print(page_url)
  html = read_html(page_url)
  
  container = html_node(html, "#container") # id = "container"
  book_list = html_node(container, ".new_book_list_wrap") # class="new~"
  sub_book_list = html_node(book_list, ".sub_book_list_area") # 책 리스트
  book_list = html_nodes(sub_book_list, "li") # <li> 모두 찾기기
  
  for (bli in book_list) { 
    
    # 책 제목 / 저자
    info = html_node(bli, ".info")
    title = info %>% html_node(".book_tit") %>%
      html_text() # 제목
    writer = info %>% html_node(".book_writer") %>%
      html_text() # 저자
    
    ## 해당 도서 세부정보 리스트 접근
    href = bli %>% html_node(".info") %>%
      html_node("a") %>% html_attr("href") # 선택된 책 주소?
    book_url = paste(base_url, href, sep="/" ) # 베이스 + 선택주소
    book_html = read_html(book_url) # 해당 도서 세부 정보 url
    
    ## 선택된 책 세부정보 목록
    info_list = html_node(book_html, "ul.info_list") # 정보 리스트
    info_list = html_nodes(info_list, "li") # li 모두 찾기
    
    for (ili in info_list) { # ili 는 여기서 생성
      item = ili %>% html_node("strong") %>% html_text()
      if(substring(item, 1, 3) == "페이지") {
        page = ili %>% html_node("span") %>% html_text()
        page = as.integer(substr(page, 1, nchar(page)-2))
        #len <- str_length(page) 
        #page <- as.integer(substring(page, 1, len-2))
        break;
      }
    }
    
    # 가격
    pay_info = html_node(book_html, ".payment_box.curr")
    ps = html_nodes(pay_info, "p")
    price = ps[2] %>% 
      html_node(".pbr") %>% 
      html_node("strong") %>% 
      html_text()
    price = as.integer(gsub(",","",price))
    
    
    title_ve <- c(title_v, title)
    writer_v <- c(writer_v, writer)
    page_v <- c(page_v, page)
    price_v <- c(price_v, price)
  }
  
  new_books = data.frame(
    title=title_v,
    writer=writer_v,
    page=page_v,
    price=price_v
  )
}
str(new_books)
head(new_books)

# 지니차트 일간 / 1~100위, 순위 지난 순위 제목 가수 앨범

rank_v = c()
last_v = c()
title_v = c()
artist_v = c()
album_v = c()

for (p in c(1:2)) { # 1: 1~50위/ 2: 51~100위
  #main_url = "https://www.genie.co.kr/chart/top200"
  #sub_url = "?ditc=D&ymd=20210509&hh=17&rtm=N"
  #page_url = paste0(main_url, sub_url, "&pg=", p)
  page_url = "https://www.genie.co.kr/chart/top200?ditc=D&ymd=20210509&hh=17&rtm=N&pg=1"
  html = read_html(page_url)
  html
  
  table = html %>%
    html_node("div.music-list-wrap") %>%
    html_node("table")
  
  
  trs = table %>%
    html_node("tbody") %>% html_nodes("tr")
  
  #for (tr in trs) {
    # 순위
    tr= trs[1]
    rank = tr %>% html_node("td.number") %>% html_text()
    rank
    rank = str_split(rank, "\n"); rank
    rank = str_trim(rank[[1]])
    rank[1]
    rank = as.integer(rank); rank
  }
}   
