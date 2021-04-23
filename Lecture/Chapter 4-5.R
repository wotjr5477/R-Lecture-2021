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
