# 210510

# 한빛 미디어 사이트로 웹 크롤링 연습하기

library(rvest)
library(stringr)
library(dplyr)

# 웹 사이트 읽기
base_url = "https://www.hanbit.co.kr/media/books"
sub_url = "new_book_list.html"
url = paste(base_url, sub_url, sep="/")
url
html = read_html(url)

container = html_node(html, "#container") # id = "container"

book_list = html_node(container, ".new_book_list_wrap") # class="new~"
sub_book_list = html_node(book_list, ".sub_book_list_area")
sub_book_list

lis = html_nodes(sub_book_list, "li") # <li> 모두 찾기기
lis # sub_book_list 와동일 "li"로 필터링
li = lis[1]

info = html_node(li, ".info")

title = html_node(info, ".book_tit")
title = html_text(title)
title

writer = info %>% html_node(".book_writer") %>%
  html_text()
writer

title_vector = c()
writer_vector = c()

for (li in lis) {
  info = html_node(li, ".info")
  title = info %>% html_node(".book_tit") %>%
    html_text()
  writer = info %>% html_node(".book_writer") %>%
    html_text()
  title_vector = c(title_vector, title)
  writer_vector = c(writer_vector, writer)
}

new_books = data.frame(
  title = title_vector,
  writer = writer_vector
)

View(new_books)


#########################
# 도서 세부 내용 크롤링 #
#########################
li = lis[1]
li # 첫번째 책
href = li %>% html_node(".info") %>%
  html_node("a") %>% html_attr("href")
href

book_url = paste(base_url, substr(href,2, length(base_url)), sep="/" )
book_url = paste(base_url, href, sep="/" )
book_html = read_html(book_url)

# 페이지 수
info_list = html_node(book_html, "ul.info_list"); info_list
lis = html_nodes(info_list, "li"); lis # info_list 안에 li밖에 없어서 안해도 됨

for (li in lis) {
  item = li %>% html_node("strong") %>% html_text() # li 내 strong 선택
  if(substring(item, 1, 3) == "페이지") { # strong 선택 >> "페이지"필터링
    page = li %>% html_node("span") %>% html_text()
    #print(page) # "284 쪽"
    #as.integer(substr(page, 1, 3)) 
    #print(as.integer(substr(page, 1, nchar(page)-2)))
    page = as.integer(substr(page, 1, nchar(page)-2))
    print(page)
    break;
  }
}

#page_li = lis[4]
#page = html_node(page_li, "span") %>% html_text()
#page

# 가격
pay_info = html_node(book_html, ".payment_box.curr")
ps = html_nodes(pay_info, "p")
price = ps[2] %>% 
  html_node(".pbr") %>% 
  html_node("strong") %>% 
  html_text()
price = as.integer(gsub(",","",price))


