library(dplyr)
library(RColorBrewer)
library(leaflet)
library(geojsonio)

city <- read.csv('대전자치단체.csv', fileEncoding='utf-8')[-1,]
city

cam = read.csv("C:/workspace/R/teampl/전국무인교통단속카메라표준데이터.csv")
cam_dj = cam %>% filter(시도명 == "대전광역시")
cam_dj = subset(cam_dj, select = c("시군구명","도로종류","소재지도로명주소","설치장소","위도","경도","보호구역구분","설치연도"))
head(cam_dj)

#cam_dj$div = c()
#for (i in 1:nrow(cam_dj)) {
#  if(cam_dj[i,]$시군구명=="동구") {
#    n = "E"} else if(cam_dj[i,]$시군구명=="서구") {
#      n = "W"} else if (cam_dj[i,]$시군구명=="중구") {
#        n = "C"} else if (cam_dj[i,]$시군구명=="대덕구") {
#          n = "D"} else if (cam_dj[i,]$시군구명=="유성구") n="Y"
#  cam_dj$div = c(cam_dj$div, n)
#}


# 지도에 카메라 위치 찍기
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

