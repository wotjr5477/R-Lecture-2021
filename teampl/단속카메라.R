library(dplyr)

# 전국 무인 교통단속 카메라
cam = read.csv("전국무인교통단속카메라표준데이터.csv")
dim(cam)
head(cam)
str(cam)

## 대전지역 무인 교통단속 카메라
cam_dj = cam %>% filter(시도명 == "대전광역시")
cam_dj = subset(cam_dj, select = c("시군구명","도로종류","소재지도로명주소","설치장소","위도","경도","보호구역구분","설치연도"))
#cam_dj[1] = as.factor(cam_dj[1])
dim(cam_dj)
head(cam_dj)
str(cam_dj)
nrow(cam_dj)


## 구 : 동(E) / 서(W) / 중(C) / 대덕(D) / 유성(Y) 
cam_dj_E = cam_dj %>% filter(시군구명 == "동구")
head(cam_dj_E)
nrow(cam_dj_E)
dim(cam_dj_E)
cam_dj_W = cam_dj %>% filter(시군구명 == "서구")
head(cam_dj_W)
cam_dj_C = cam_dj %>% filter(시군구명 == "중구")
head(cam_dj_C)
cam_dj_D = cam_dj %>% filter(시군구명 == "대덕구")
head(cam_dj_D)
cam_dj_Y = cam_dj %>% filter(시군구명 == "유성구")
head(cam_dj_Y)

## 시각화
boxLocation = c(127.25305, 36.225, 127.51639, 36.485) # 대전 위도 경도 끝값
djMap = get_map(location=boxLocation) # 해당 위도 경도로 지도 범위 지정
ggmap(djMap) + # 지도 그리기
  geom_point(data = cam_dj, aes(x=경도,y=위도,colour=시군구명))



boxLocation <- c(127.25305, 36.23972, 127.51639, 36.47306)
krMap <- get_map(location=boxLocation)
ggmap(krMap)+geom_point(data=data.school, aes(x=경도,y=위도, colour=구분))


## 설치연도
cam_dj_21 = cam_dj %>% filter(설치연도 == 2021)
head(cam_dj_21)
dim(cam_dj_21)


cam_dj_200 = cam_dj %>% filter(설치연도 <= 2020)

ggmap(krMap) + # 지도 그리기
  geom_point(data = cam_dj_200, aes(x=경도,y=위도,colour=시군구명))

cam_dj_20 = cam_dj %>% filter(설치연도 <= 2020)
dim(cam_dj_20)
cam_dj_19 = cam_dj %>% filter(설치연도 <= 2019)
dim(cam_dj_19)
cam_dj_18 = cam_dj %>% filter(설치연도 <= 2018)
dim(cam_dj_18)
cam_dj_17 = cam_dj %>% filter(설치연도 <= 2017)
dim(cam_dj_17)
cam_dj_16 = cam_dj %>% filter(설치연도 <= 2016)
dim(cam_dj_16)
cam_dj_15 = cam_dj %>% filter(설치연도 <= 2015)
dim(cam_dj_15)
cam_dj_14 = cam_dj %>% filter(설치연도 < 2015)
dim(cam_dj_14)

head(cam_dj_17)
dim(cam_dj_17)




aa = cam_dj_E %>% filter(설치연도 == 2019) 
dim(aa)

  #ggmap(krMap)+geom_point(data=data.school, aes(x=경도,y=위도, colour=시군구명))

### 4. 주어진 자료를 이용하여 대전광역시 관내 초중고의 학교 위치를 지도에 나타내시오, 점의 색은 "구분"으로 표시
data.school <- read.csv("http://youngho.iwinv.net/data/daejeon_school.csv", header=T,
                        fileEncoding="UTF-8")
data.school %>% str()
library(ggmap)

boxLocation <- c(127.25305, 36.23972, 127.51639, 36.47306)

krMap <- get_map(location=boxLocation)

ggmap(krMap)+geom_point(data=data.school, aes(x=경도,y=위도, colour=구분))

### 5. 주어진 대전광역시 행정동 자료(지도)와 병원의 수 자료를 이용하여 그림을 그리시오.

### 대전광역시 행정동 자료
data.map <- read.csv("http://youngho.iwinv.net/data/daejeon_level3.csv", header=T,
                     fileEncoding="UTF-8")
data.map %>% head()

### 대전광역시 병원의 수
data.hospital <- read.table("http://youngho.iwinv.net/data/daejeon_hospital.txt", header=T,
                            fileEncoding="UTF-8", sep="\t")
data.hospital %>% head()

data.hospital = left_join(data.hospital, data.map, by="adm_cd2")

ggplot()+geom_polygon(data=data.hospital, aes(x=long, y=lat, fill=))
