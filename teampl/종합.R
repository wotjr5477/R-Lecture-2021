library(dplyr)
library(RColorBrewer)
library(leaflet)
library(geojsonio)

### 카메라
cam = read.csv("C:/workspace/R/teampl/전국무인교통단속카메라표준데이터.csv")
cam_dj = cam %>% filter(시도명 == "대전광역시")
cam_dj = subset(cam_dj, select = c("시군구명","도로종류","소재지도로명주소","설치장소","위도","경도","보호구역구분","설치연도"))
head(cam_dj)

# 지도에 카메라 위치 찍기
map <- geojson_read('daejon.json', what='sp')
city <- read.csv('대전자치단체.csv', fileEncoding='utf-8')[-1,]

leaflet(cam_dj) %>% 
  setView(lng=127.39, lat=36.35, zoom=11) %>% 
  addProviderTiles("CartoDB.Positron") %>%
  addCircles(lng = ~경도, lat = ~위도, color = "#006633")

# 지도에 카메라 위치 찍고 구별로 나누기
map <- geojson_read('daejon.json', what='sp')
pal <- colorFactor("Set1")

leaflet(map) %>% 
  setView(lng=127.39, lat=36.35, zoom=11) %>% 
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(
    color = "skyblue",
    label = ~gsub("청", "", city$place)) %>%
  addCircles(lng = ~cam_dj$경도, lat = ~cam_dj$위도, color = "#006633")

# 지도에 구마다 다른 색으로 카메라 위치 찍고 구별로 나누기
map <- geojson_read('daejon.json', what='sp')
div = colorFactor("Accent", cam_dj$시군구명)

leaflet(map) %>% 
  setView(lng=127.39, lat=36.35, zoom=11) %>% 
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(
    color = "#87CEFA",
    label = ~gsub("청", "", city$place)) %>%
  addCircles(lng = ~cam_dj$경도, lat = ~cam_dj$위도, color = ~div(cam_dj$시군구명))

# 지도에 구마다 다른 색으로 카메라 위치 찍고 구별 카메라 수로 나누기
map <- geojson_read('daejon.json', what='sp')
div = colorFactor("Dark2", cam_dj$시군구명)
pal <- colorNumeric("Blues", NULL)
pop = cam_dj %>% group_by(시군구명) %>% summarise(n=n()); pop

leaflet(map) %>% 
  setView(lng=127.39, lat=36.35, zoom=11) %>% 
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(
    color = "#87CEFA",
    weight = 3,
    opacity = 1,
    dashArray = '3',
    fillOpacity = 0.5, 
    label = ~gsub("청", "", city$place),
    fillColor = ~pal(pop$n)) %>%
  addCircles(lng = ~cam_dj$경도, lat = ~cam_dj$위도, color = ~div(cam_dj$시군구명)) %>%
  addLegend(pal=pal, values = ~pop$n, opacity = 0.7,
            title='카메라 수', position='bottomright')

### 사고수
acc = read_excel("1519_accident.xlsx")
acc = data.frame(acc)
acc = subset.data.frame(acc, select = c("사고번호", "시군구", "사고내용", "사망자수", "중상자수"))
head(acc)
nrow(acc)

acc$loc = gsub("대전광역시 ", "", acc$시군구)
head(acc)

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

# 연도별 사고 횟수 : 히스토그램
hist(acc$year, main="연도별 교통사고(사망/중상)", xlab="연도", ylab="사고", ylim = c(0,2500), col = "skyblue")


### 인구수
dj_pop <- read_xlsx("주민등록인구및세대현황_연간_20152020.xlsx")

str(dj_pop)
head(dj_pop)
dj_pop <- data.frame(dj_pop) # 2020

dj_pop_sum <- dj_pop %>% 
  filter(행정구역 == '대전광역시')
head(dj_pop_sum) # 대전 전체 인구수

dj_pop_sum %>% 
  ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line() # 전체 인구수 변화 그래프

dj_pop <- dj_pop %>% 
  filter(행정구역 != '대전광역시') %>% 
  group_by(연도, 행정구역)
head(dj_pop) # 구별 인구수

dj_pop %>% 
  ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line() # 구별 인구수 변화 그래프

dj_pop = dj_pop[1:25,]; dj_pop #15~20년 자료 >> 19년 자료까지

dj_pop = dj_pop %>% rename("year"="연도","loc"="행정구역","pop"="인구수","fam"="세대수", "pop.fam"="세대당.인구") # 열이름 통일
head(dj_pop)


### 자동차 수
dj_cars <- read_xlsx("자동차_등록자료_통계_20152020.xlsx")
dj_cars <- data.frame(dj_cars)
dj_cars = dj_cars[1:25,] # 15~20년 자료 >> 19년 자료 까지
dj_cars = dj_cars[,-c(3:6)] # 전체 자가용 차량의 합만 추출

dj_cars %>% 
  ggplot(aes(x=연도, y=총계, col=시군구))+geom_point()+geom_line() # 구별 인구수 변화 그래프

dj_cars = dj_cars %>% rename("loc"="시군구", "year"="연도", "car_count"="총계") # 열 이름 통일



dj_p_c <- merge(dj_cars, dj_pop, by=c("year","loc"))
head(dj_p_c)


### 데이터 통합
data = merge(cam_acc, dj_p_c, by=c("year","loc"))
data

data$car.pop = data$car_count/data$pop
data$car.fam = data$car_count/data$fam
data$cam.car = data$cam_count/data$car_count
data


### 시각화

# 전체 인구수
dj_pop_sum %>% 
  ggplot(aes(x=연도, y=인구수, col=행정구역))+geom_point()+geom_line()+
  ggtitle("연도별 인구수 변화") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))

data %>% 
  ggplot(aes(x=year, y=pop, col=loc))+geom_point()+geom_line()+
  ggtitle("연도별 인구수 변화(구)") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))

data %>% 
  ggplot(aes(x=year, y=pop.fam, col=loc))+geom_point()+geom_line()+
  ggtitle("가구별 구성인원 비율") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))

data %>% 
  ggplot(aes(x=year, y=car.pop, col=loc))+geom_point()+geom_line()+
  ggtitle("대전시 인당 자동차 보유율") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))

data %>% 
  ggplot(aes(x=year, y=car.fam, col=loc))+geom_point()+geom_line()+
  ggtitle("대전시 가구별 자동차 보유율") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 15))
