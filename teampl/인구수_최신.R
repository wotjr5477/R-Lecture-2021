library(dplyr)
library(readxl)
library(stringr)
getwd()
srl_info = read_xlsx("주민등록인구및세대현황_연간_20152020.xlsx")

str(srl_info)
srl_info$행정구역

dj_info_sorted <- srl_info %>% 
    filter(행정구역 != '대전광역시') %>% 
    group_by(연도, 행정구역)

dj_info_sorted %>% 
    ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()
dj_info_sorted %>% 
  ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line()
