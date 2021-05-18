library(dplyr)
library(readxl)
library(stringr)


### 인구수
dj_pop <- read_xlsx("주민등록인구및세대현황_연간_20152020.xlsx")

str(dj_pop)
head(dj_pop)
dj_pop <- data.frame(dj_pop) # 2020

dj_pop_sum <- dj_pop %>% 
  filter(행정구역 == '대전광역시')
head(dj_pop_sum) # 대전 전체 인구수

dj_pop_sum %>% 
  ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line()+
  ggtitle("연도별 인구수 변화") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15)) # 전체 인구수 변화 그래프

dj_pop <- dj_pop %>% 
  filter(행정구역 != '대전광역시') %>% 
  group_by(연도, 행정구역)
head(dj_pop) # 구별 인구수

dj_pop %>% 
  ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line()+
  ggtitle("연도별 인구수 변화(구)") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15)) # 구별 인구수 변화 그래프

dj_pop = dj_pop[1:25,]; dj_pop #15~20년 자료 >> 19년 자료까지

dj_pop = dj_pop %>% rename("year"="연도","loc"="행정구역","pop"="인구수","fam"="세대수", "pop.fam"="세대당.인구") # 열이름 통일
head(dj_pop)


### 자동차 수
dj_cars <- read_xlsx("자동차_등록자료_통계_20152020.xlsx")
dj_cars <- data.frame(dj_cars)
dj_cars = dj_cars[1:25,] # 15~20년 자료 >> 19년 자료 까지
dj_cars = dj_cars[,-c(3:6)] # 전체 자가용 차량의 합만 추출

dj_cars %>% 
  ggplot(aes(x=연도, y=총계, col=시군구))+geom_point()+geom_line()+
  ggtitle("구별 자동차 등록 수") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))# 연도별 사고 수(구)# 구별 인구수 변화 그래프

dj_cars = dj_cars %>% rename("loc"="시군구", "year"="연도", "car_count"="총계") # 열 이름 통일



dj_p_c <- merge(dj_pop, dj_cars, by=c("year","loc"))
head(dj_p_c)
