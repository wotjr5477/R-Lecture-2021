library(dplyr)
library(ggplot2)

# 사고 수 - 카메라 수

## 사고 수 ######################################
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
accW = acc %>% filter(loc == "서구"); head(accW)
nrow(accW)
accC = acc %>% filter(loc == "중구"); head(accC)
nrow(accC)
accD = acc %>% filter(loc == "대덕구"); head(accD)
nrow(accD)
accY = acc %>% filter(loc == "유성구"); head(accY)
nrow(accY)

# 동구 15년도
accE15 = accE %>% filter(year == 2015); head(accE15)
nrow(accE15)
#########################################################


## 카메라 수 ###########################################33
# 전체 카메라 수
cam = read.csv("전국무인교통단속카메라표준데이터.csv")

# 대전지역 카메라 수
cam_dj = cam %>% filter(시도명 == "대전광역시")
cam_dj = subset(cam_dj, select = c("시군구명","도로종류","소재지도로명주소","설치장소","위도","경도","보호구역구분","설치연도"))
table(is.na(cam_dj$설치연도)) # 결측치 88개

mean(cam_dj$설치연도, na.rm = T)  # 결측치 제외하고 설치연도 평균 산출 = 2017


cam_dj$설치연도 = ifelse(is.na(cam_dj$설치연도), 2017, cam_dj$설치연도) # 결측 데이터 14년도 설치로 대체 >> 15년 이전 설치

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
##################################################





### 사고수 - 카메라 수 ####################################
# 동구
ace = c()
cce = c()
for (i in 2015:2019) {
  k = nrow(accE %>% filter(year == i))
  ace = c(ace, k)
  l = nrow(cam_dj_E %>% filter(설치연도 <= i))
  cce = c(cce, l)
  
}
cE = data.frame(loc = "동구", year = (2015:2019), acc_count = ace, cam_count = cce)
cE

# 서구
acw = c()
ccw = c()
for (i in 2015:2019) {
  k = nrow(accW %>% filter(year == i))
  acw = c(acw, k)
  l = nrow(cam_dj_W %>% filter(설치연도 <= i))
  ccw = c(ccw, l)
  
}
cW = data.frame(loc = "서구", year = (2015:2019), acc_count = acw, cam_count = ccw)
cW

# 중구
acc = c()
ccc = c()
for (i in 2015:2019) {
  k = nrow(accC %>% filter(year == i))
  acc = c(acc, k)
  l = nrow(cam_dj_C %>% filter(설치연도 <= i))
  ccc = c(ccc, l)
  
}
cC = data.frame(loc = "중구", year = (2015:2019), acc_count = acc, cam_count = ccc)
cC

# 대덕구
acd = c()
ccd = c()
for (i in 2015:2019) {
  k = nrow(accD %>% filter(year == i))
  acd = c(acd, k)
  l = nrow(cam_dj_D %>% filter(설치연도 <= i))
  ccd = c(ccd, l)
  
}
cD = data.frame(loc = "대덕구", year = (2015:2019), acc_count = acd, cam_count = ccd)
cD

# 유성구
acy = c()
ccy = c()
for (i in 2015:2019) {
  k = nrow(accY %>% filter(year == i))
  acy = c(acy, k)
  l = nrow(cam_dj_Y %>% filter(설치연도 <= i))
  ccy = c(ccy, l)
  
}
cY = data.frame(loc = "유성구", year = (2015:2019), acc_count = acy, cam_count = ccy)
cY
###################################################################

## 전체 카메라 - 사고수
cam_acc = rbind.data.frame(cE, cW, cC, cD, cY)
cam_acc

# ggplot 산점도
cam_acc %>%
  ggplot(aes(acc_count,cam_count,
             col=year, size= acc_count)) +
  geom_point(alpha=0.5) +
  scale_x_log10() #+
#  geom_smooth(method="lm")

cam_acc %>%
  ggplot(aes(acc_count,cam_count,
             col=year)) +
  geom_point() +
  geom_smooth(method = "lm")

# 단순 선형회귀 적용
cam_acc_model <- lm(cam_count~acc_count, data=cam_acc)
coef(cam_acc_model)

# 회귀식: cam = 62.58994672 - 0.03407163 * 교통사고
plot(cam_acc$acc_count, cam_acc$cam_count)
abline(cam_acc_model, col='red')
summary(cam_acc_model, col='red')
par(mfrow=c(2,2))
plot(cam_acc_model)

par(mfrow=c(1,1))


## 전체 카메라 - 사고수 (유성 제외)
cam_acc_1 = rbind.data.frame(cE)
cam_acc_1

# ggplot 산점도
cam_acc_1 %>%
  ggplot(aes(acc_count,cam_count,
             col=year, size= acc_count)) +
  geom_point(alpha=0.5) +
  scale_x_log10()

cam_acc_1 %>%
  ggplot(aes(acc_count,cam_count,
             col=year)) +
  geom_point() + geom_smooth(method = "lm")

# 단순 선형회귀 적용
cam_acc_1_model <- lm(cam_count~acc_count, data=cam_acc_1)
coef(cam_acc_1_model)

# 회귀식: cam = 62.58994672 - 0.03407163 * 교통사고
plot(cam_acc_1$acc_count, cam_acc_1$cam_count)
abline(cam_acc_1_model, col='red')
summary(cam_acc_1_model, col='red')
par(mfrow=c(2,2))
plot(cam_acc_1_model)

par(mfrow=c(1,1))


# 구 별 카메라 수 변화 시각화
cam_acc
cam_acc %>% ggplot(aes(x=year, y=cam_count, col=loc))+geom_point()+geom_line() # 이거

cam_acc %>% group_by(loc) %>% summarise( acc_count)
cam_acc %>% filter(loc == "동구")# %>% sum(acc_count)
