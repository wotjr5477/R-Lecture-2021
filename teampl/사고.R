library(dplyr)

acc = read_excel("1519_accident.xlsx")
acc = data.frame(acc)
acc = subset.data.frame(acc, select = c("사고번호", "시군구", "사고내용", "사망자수", "중상자수"))
head(acc)
nrow(acc)

acc$loc = gsub("대전광역시 ", "", acc$시군구)
head(acc)

#acc$loc[1]
#a = strsplit(acc$loc[1], split=" ")
#a[[1]][1]

year_v = c()
month_v = c()

for (i in 1:nrow(acc)) {
  year = substr(acc[i,1], 1, 4)
  year = as.integer(year); year
  
  month = substr(acc[i,1], 5, 6)
  month = as.integer(month); month
  
  a = strsplit(acc$loc[i], split=" ")
  acc$loc[i] = a[[1]][1]
  
  year_v = c(year_v, year)
  month_v = c(month_v, month)
}

acc = data.frame(acc, year = year_v, month = month_v)
head(acc)
tail(acc)





e = c()
for (i in 2015:2019) {
c = acc %>% filter(year == i) %>% nrow()
e = c(e, c)
}

# 연도별 사고 횟수 : 히스토그램
hist(acc$year, main="연도별 교통사고(사망/중상)", xlab="연도", ylab="사고", ylim = c(0,2500), col = "skyblue")

d = c(2015, 2016, 2017, 2018, 2019)
f = data.frame(year = d, times = e)

acc %>% filter(year==2015) %>% nrow() # 15년도 사고수
acc %>% filter(year==2016) %>% nrow() # 16년도 사고수
acc %>% filter(year==2017) %>% nrow() # 17년도 사고수
acc %>% filter(year==2018) %>% nrow() # 19년도 사고수
acc %>% filter(year==2019) %>% nrow() # 19년도 사고수

#
ggplot(f) + geom_line(f, aes(year, times))

ggplot(b,aes(year)) + geom_histogram() + geom_line(f, aes(year, times))

ggplot(f) + geom_bar(aes(year, times))
+ geom_line()

str(b)
head(b)
head(a)
