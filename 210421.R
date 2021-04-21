#디렉토리
getwd()
# a = choose.dir()
# setwd(a)
#getwd()

# 패키지
search()
# 패키지 설치
  # install.packages()
## 패키지 적용
library(dplyr)
library(ggplot2)
search()

iris
str(iris)

head(iris) #default = 6
head(iris,10)
tail(iris)
plot(iris)

# 두 속성의 상관 관계
plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species, pch = 18 )


# tips.csv download
tips = read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)

summary(tips)

# ggplot2로
tips %>% ggplot(aes(size))+geom_histogram() #히스토그램
tips %>% ggplot(aes(total_bill, tip))+geom_point() #산점도
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day)) #포인트 색지정
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day, pch=sex)) #포인트 성별로 분류
tips %>% ggplot(aes(total_bill, tip))+geom_point(aes(col=day, pch=sex),size=3) #포인트 사이즈 설정

