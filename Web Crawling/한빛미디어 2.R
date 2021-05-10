# 210510

# 한빛미디어 웹 크롤링 완성본

### 종합? ###
# 웹 사이트 읽기
base_url = "https://www.hanbit.co.kr/media/books" # 본주소
sub_url = "new_book_list.html" # 부주소
url = paste(base_url, sub_url, sep="/") # 풀 주소
url
html = read_html(url)

container = html_node(html, "#container") # id = "container"

book_list = html_node(container, ".new_book_list_wrap") # class="new~"
sub_book_list = html_node(book_list, ".sub_book_list_area")
sub_book_list # 책 리스트

book_list = html_nodes(sub_book_list, "li") # <li> 모두 찾기기
book_list # sub_book_list 와동일 "li"로 필터링
bli = book_lis[1] # 첫번째 책

info = html_node(bli, ".info") # 첫번째 책 정보

title = html_node(info, ".book_tit")
title = html_text(title)
title # 책 제목

writer = info %>% html_node(".book_writer") %>%
  html_text()
writer # 책 저자

title_vector = c()
writer_vector = c()

for (bli in book_list) { # bli는 여기서 생성
  
  # 책 제목 / 저자
  info = html_node(bli, ".info")
  title = info %>% html_node(".book_tit") %>%
    html_text() # 제목
  writer = info %>% html_node(".book_writer") %>%
    html_text() # 저자
  
  ## 선택된 책 세부정보 리스트 접근
  href = bli %>% html_node(".info") %>%
    html_node("a") %>% html_attr("href")
  href # 선택된 책 링크?
  
  book_url = paste(base_url, substr(href,2, length(base_url)), sep="/" )
  book_url = paste(base_url, href, sep="/" ) # 베이스 + 선택주소
  book_html = read_html(book_url) # 선택된 책 세부 정보 url
  
  ## 선택된 책 세부정보 목록
  info_lis = html_node(book_html, "ul.info_list")
  info_lis = html_nodes(info_lis, "li")
  
  for (ili in info_lis) { # ili 는 여기서 생성
    item = ili %>% html_node("strong") %>% html_text()
    if(substring(item, 1, 3) == "페이지") {
      page = li %>% html_node("span") %>% html_text()
      #print(page) # "284 쪽"
      #as.integer(substr(page, 1, 3)) 
      #print(as.integer(substr(page, 1, nchar(page)-2)))
      page = as.integer(substr(page, 1, nchar(page)-2))
      print(page)
      break;
    }
  }
  
  
  
  
  
  
  title_vector = c(title_vector, title)
  writer_vector = c(writer_vector, writer)
}

new_books = data.frame(
  title = title_vector,
  writer = writer_vector
)

View(new_books)

