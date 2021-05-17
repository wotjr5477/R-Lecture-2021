library(dplyr)

# 사고 수 - 카메라 수

## 사고 수 
# 대전지역 사고 수
acc = read_excel("1519_accident.xlsx")
acc = data.frame(acc)
acc = subset.data.frame(acc, select = c("사고번호", "시군구", "사고내용", "사망자수", "중상자수"))
head(acc)
nrow(acc)

acc$loc = gsub("대전광역시 ", "", acc$시군구) # 문자열 대체 
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

# 동구
accE = acc %>% filter(loc == "동구"); head(accE)
nrow(accE)

# 동구 15년도
accE15 = accE %>% filter(year == 2015); head(accE15)
nrow(accE15)



## 카메라 수
# 전체 카메라 수
cam = read.csv("전국무인교통단속카메라표준데이터.csv")

# 대전지역 카메라 수
cam_dj = cam %>% filter(시도명 == "대전광역시")
cam_dj = subset(cam_dj, select = c("시군구명","도로종류","소재지도로명주소","설치장소","위도","경도","보호구역구분","설치연도"))
table(is.na(cam_dj$설치연도)) # 결측치 88개

cam_dj$설치연도 = ifelse(is.na(cam_dj$설치연도), 2014, cam_dj$설치연도) # 결측 데이터 14년도 설치로 대체 >> 15년 이전 설치

# 구 별 카메라 수 
cam_dj_E = cam_dj %>% filter(시군구명 == "동구")
head(cam_dj_E)
dim(cam_dj_E)
cam_dj_W = cam_dj %>% filter(시군구명 == "서구")
head(cam_dj_W)
cam_dj_C = cam_dj %>% filter(시군구명 == "중구")
head(cam_dj_C)
cam_dj_D = cam_dj %>% filter(시군구명 == "대덕구")
head(cam_dj_D)
cam_dj_Y = cam_dj %>% filter(시군구명 == "유성구")
head(cam_dj_Y)

# 동구 카메라
cam_dj_E = cam_dj %>% filter(시군구명 == "동구")
nrow(cam_dj_E)

# 15년
cdE15 = cam_dj_E %>% filter(설치연도 <= 2015)
nrow(cdE15)






### 사고수 - 카메라 수
# 동구
ace = c()
for (i in 2015:2019) {
  k = nrow(accE %>% filter(year == i))
  ace = c(ace, k)
  
}
cE = data.frame(loc = "동구", year = (2015:2019), count = ace)
cE
