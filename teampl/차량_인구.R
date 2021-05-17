library(dplyr)
library(readxl)
library(stringr)
getwd()
srl_info <- read_xlsx("주민등록인구및세대현황_연간_20152020.xlsx")

str(srl_info)
srl_info$행정구역

dj_info_sorted <- srl_info %>% 
    filter(행정구역 != '대전광역시') %>% 
    group_by(연도, 행정구역)

dj_info_sorted %>% 
    ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()
dj_info_sorted %>% 
    ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line()
dj_pop <- data.frame(dj_info_sorted) # 2020

dj_pop = dj_pop[1:25,]; dj_pop
dj_pop = dj_pop %>% rename("year"="연도","loc"="행정구역","pop"="인구수","fam"="세대수", "pop.fam"="세대당.인구")


dj_cars <- read_xlsx("자동차_등록자료_통계_20152020.xlsx")
dj_cars <- data.frame(dj_cars)
dj_cars = dj_cars[1:25,]
dj_cars = dj_cars[,-c(3:6)]

dj_cars = dj_cars %>% rename("loc"="시군구", "year"="연도", "car_count"="총계")


dj_p_c <- merge(dj_pop, dj_cars, by=c("year","loc"))

