# 한빛미디어 사이트 웹 크롤링 
library(rvest)
library(stringr)
library(dplyr)

title_vector <- c()
writer_vector <- c()
page_vector <- c()
price_vector <- c()
for (p in c(1:11,13:25)) {
  # 웹 사이트 읽기
  base_url = "https://www.hanbit.co.kr/media/books" # 메인주소
  sub_url = "new_book_list.html" # 서브주소
  url <- paste(base_url, sub_url, sep='/')
  page_url = paste0(url, "?page=", p) # 1~25 page 주소
  print(page_url)
  html = read_html(page_url)
  
  container = html_node(html, "#container") # id = "container"
  book_list = html_node(container, ".new_book_list_wrap") # class="new~"
  sub_book_list = html_node(book_list, ".sub_book_list_area") # 책 리스트
  lis <- html_nodes(sub_book_list, 'li')      # <li> 모두 찾기
  
  for (li in lis) {
    info <- html_node(li, '.info')
    title <- info %>% 
      html_node('.book_tit') %>% 
      html_text()
    writer <- info %>% 
      html_node('.book_writer') %>% 
      html_text()
    href <- li %>% 
      html_node('.info') %>% 
      html_node('a') %>% 
      html_attr('href')
    book_url <- paste(base_url, href, sep='/')
    book_html <- read_html(book_url)
    info_list <- html_node(book_html, 'ul.info_list')
    book_lis <- html_nodes(info_list, 'li')
    
    for (book_li in book_lis) {
      item <- book_li %>% 
        html_node('strong') %>% 
        html_text()
      if (substring(item, 1, 3) == '페이지') {
        page <- book_li %>% 
          html_node('span') %>% 
          html_text()
        len <- str_length(page) 
        page <- as.integer(substring(page, 1, len-2))
        break
      }
    }
    pay_info <- html_node(book_html, '.payment_box.curr')
    ps <- html_nodes(pay_info, 'p')
    price <- ps[2] %>% 
      html_node('.pbr') %>% 
      html_node('strong') %>% 
      html_text()
    price <- as.integer(gsub(',','',price))
    
    title_vector <- c(title_vector, title)
    writer_vector <- c(writer_vector, writer)
    page_vector <- c(page_vector, page)
    price_vector <- c(price_vector, price)
  }
}

new_books <- data.frame(
  title=title_vector,
  writer=writer_vector,
  page=page_vector,
  price=price_vector
)

View(new_books)
