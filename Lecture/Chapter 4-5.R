#210423


# 데이터 정제
getwd()
score = read.csv("data/students2.csv")
score

for (i in 2:4) {
  score[, i] = ifelse(score[,i]>100 | score[,i]<0, NA, score[,2])
}
score



#score[,2:4] = ifelse(score[,2:4]<0 | score[,2:4]>100, NA, score[,2:4])

#score_fn = function(x) {
#  if(x > 100 | x < 0) {
#    return(NA)
#  }
#  return(x)
#}

#score[,2:4] = apply(score[,2:4]score_fn(score[,2:4])

 
# 결측값 처리
head(airquality)
sum(is.na(airquality))
table(is.na(airquality))

sum(is.na(airquality$Temp)) # 결측치 없음
mean(airquality$Temp) # 평균 구할 수 있음

sum(is.na(airquality$Ozone)) #결측치 존재
mean(airquality$Ozone) # >> 평균 구할 수 없음
mean(airquality$Ozone, na.rm = T) #na.rm을 T로 설정해주면 결측값을 제거
mean(na.omit(airquality$Ozone)) #na.omit()으로 결측값을 제거

# 결측값 제거
airq_narm = na.omit(airquality); head(airq_narm)
sum(is.na(airq_narm))

# 결측값 대체 - 평균(mean)으로 대체
airquality$Ozone = replace(airquality$Ozone, is.na(airquality$Ozone),mean(airquality$Ozone, na.rm = T))
head(airquality$Ozone)

# 결측값 대체 - 중위값(median)으로 대체
airquality$Solar.R = replace(airquality$Solar.R, is.na(airquality$Solar.R),median(airquality$Solar.R, na.rm = T))
head(airquality$Solar.R)


# 이상값 처리
patients = data.frame(name = c("환자1","환자2","환자3", "환자4", "환자5"),
                      age = c(22, 20, 25, 30, 27),
                      gender = factor(c("M","F","M","K","F")),
                      blood.type = factor(c("A","O","B","AB","C")))
patients

# 성별 이상치 제거
patients_outrm = patients[patients$gender == "M" | patients$gender == "F",]; 
patients_outrm = patients[patients$gender %in% c("M","F"),]; 
patients_outrm

# 혈액형 이상치 제거
patients_outrm2 = patients[patients$blood.type %in% c("A","B","AB","O"),]; patients_outrm2

patients_outrm3 = patients[patients$gender %in% c("M","F") & patients$blood.type %in% c("A","B","AB","O"),]; patients_outrm3

patients_outrm3 = merge(patients_outrm, patients_outrm2); patients_outrm3

# 이상치를 NA로 대체
patients2 = patients; patients2
patients2$gender = ifelse(patients2$gender %in% c("M","F"),
                          patients2$gender, NA); patients2$gender
patients2$blood.type = ifelse(patients2$blood.type %in% c("A","B","AB","O"),
                          patients2$blood.type, NA); patients2$blood.type

patients2


# 숫자의 이상치
rm(airquality)
boxplot(airquality[,c(1:4)])
boxplot(airquality[,1])$stats
boxplot(airquality$Ozone)$stats

head(airquality)

air = airquality
air$Ozone = ifelse(air$Ozone <1 | air$Ozone > 122, NA, air$Ozone)
air$Ozone
boxplot((airquality$Ozone)$stats[1])


air$Ozone = ifelse(air$Ozone < boxplot(airquality$Ozone)$stats[1]&                              air$Ozone > boxplot(airquality$Ozone)$stats[5],
                   NA, air$Ozone); air$Ozone


sum(is.na(air$Ozone))
sum(is.na(airquality$Ozone))
mean(air$Ozone, na.rm = T)
mean(airquality$Ozone, na.rm = T)
