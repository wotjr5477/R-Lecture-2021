# 210426


# AVOCADO
avocado = read.csv("data/avocado.csv")
head(avocado)
str(avocado)
summary(avocado)

glimpse(avocado)
?glimpse

# 지역별 평균 판매량과 가격
avocado %>%
  group_by(region) %>%
  summarize(P_avg = mean(AveragePrice), V_avg = mean(Total.Volume))

# 지역/연도별 평균 판매량과 가격
avocado %>%
  group_by(region, year) %>%
  summarize(P_avg = mean(AveragePrice), V_avg = mean(Total.Volume))

# 지역/연도별 유기농 여부에 따른 평균 판매량과 가격
avocado %>%
  group_by(region, year, type) %>%
  summarize(P_avg = mean(AveragePrice), V_avg = mean(Total.Volume))

# p.164
library(ggplot2)
x_avg = avocado %>%
  group_by(region, year, type) %>%
  summarize(P_avg = mean(AveragePrice), V_avg = mean(Total.Volume))
x_avg %>%
  filter(region != "TotalUS") %>%
  ggplot(aes(year, V_avg, col = type)) + geom_line() + facet_wrap(~region)
x_avg = x_avg %>%
  filter(region != "TotalUS")
head(x_avg)
arrange(x_avg, desc(V_avg)) %>% head(10)

avocali18 = avocado%>%
  filter(region == "California" & year == 2018) %>%
  select(region, Date, AveragePrice, Total.Volume, type)
head(avocali18)

# 연도별이 아닌 월 별 집계
library(lubridate)
year(now())
month(now())
day(now())
day(as.Date("2021-04-26"))
wday("2021-04-26")

m_avg = avocado%>%
  group_by(region, year, month(Date), type) %>%
  summarize(P_avg = mean(AveragePrice), V_avg = mean(Total.Volume))
m_avg
head(avocali18)


# wine
wine = read.table("data/wine.data.txt", header = F, sep = ",")
head(wine)

# wine 데이터의 컬럼 명
columns = readLines("data/wine.name.txt"); columns
  
names(wine)
names(wine)[2:14] = columns
names(wine)
names(wine) = substr(names(wine), 4, nchar(names(wine)))
names(wine)[1] = "Y"
names(wine)
head(wine)

# 데이터 셋 분할
train_set = sample_frac(wine, 0.75)
str(train_set)
head(train_set)
table(wine$Y)
table(train_set$Y)

test_set = setdiff(wine, train_set); head(test_set)
table(test_set$Y)
