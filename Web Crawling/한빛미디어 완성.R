# 210510

# 한빛미디어 웹 크롤링 완성본


# 웹 사이트 읽기
base_url = "https://www.hanbit.co.kr/media/books" # 본주소
sub_url = "new_book_list.html" # 부주소
url = paste(base_url, sub_url, sep="/") # 풀 주소
html = read_html(url)

container = html_node(html, "#container") # id = "container"
book_list = html_node(container, ".new_book_list_wrap") # class="new~"
sub_book_list = html_node(book_list, ".sub_book_list_area") # 책 리스트
book_list = html_nodes(sub_book_list, "li") # <li> 모두 찾기기

title_vector = c()
writer_vector = c()
page_vector = c()
price_vector = c()

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
      print(page)
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
  
  
  title_vector <- c(title_vector, title)
  writer_vector <- c(writer_vector, writer)
  page_vector <- c(page_vector, page)
  price_vector <- c(price_vector, price)
}

new_books = data.frame(
  title=title_vector,
  writer=writer_vector,
  page=page_vector,
  price=price_vector
)

View(new_books)

