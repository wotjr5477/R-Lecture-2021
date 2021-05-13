library(dplyr)

a = read_excel("1519_accident.xlsx", header)
b = data.frame(a)


nrow(b)

year_v = c()
month_v = c()

for (i in 1:nrow(b)) {
  year = substr(a[i,1], 1, 4)
  year = as.integer(year); year
  
  month = substr(a[i,1], 5, 6)
  month = as.integer(month); month
  
  
  year_v = c(year_v, year)
  month_v = c(month_v, month)
}
year_v
head(year_v)

b = data.frame(b, year = year_v, month = month_v)
head(b)
tail(b)

for (i in 2015:2019) {
c = b %>% filter(year == i)
}

# 연도별 사고 횟수 : 히스토그램
hist(b$year, main="연도별 교통사고(사망/중상)", xlab="연도", ylab="사고", ylim = c(0,2500), col = "skyblue")

b %>% filter(year==2015) %>% nrow() # 15년도 사고수
b %>% filter(year==2016) %>% nrow() # 16년도 사고수
b %>% filter(year==2017) %>% nrow() # 17년도 사고수
b %>% filter(year==2018) %>% nrow() # 19년도 사고수
b %>% filter(year==2019) %>% nrow() # 19년도 사고수

#
plot(x = b$year)


str(b)
head(b)
head(a)
