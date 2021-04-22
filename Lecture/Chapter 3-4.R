#210422


# 데이터 프레임 
## 데이터 생성
name = c('철수','춘향','길동')
age = c(22, 20,25)
gender = factor(c('M','F','M'))
blood_type = factor(c('A','AB','O'))

## 데이터 프레임 만들기
patients = data.frame(name, age, gender, blood_type); patients

## 구조
str(patients)
summary(patients)

typeof(patients)
typeof(patients$name)
typeof(patients$gender)
typeof(patients$blood_type)
typeof(patients$age)

# 데이터 추출
patients$age
patients[1,]
patients[,2]
patients[2,4]
patients['blood_type'] # 열 이름으로 추출도 가능
patients[1,]
patients['1'] # 행 이름으로는 안되는데 설정하면 될듯?
patients['blood_type',2] # 이런 식은 안됨

patients$gender[3] # 열을 직접 지정한 후 추출 가능
patients[patients$name == '춘향',]


# 데이터 프레임의 속성 명을 변수명으로 사용/해제 : attach/detach
attach(patients)
name
detach(patients)
name # 내부적으로 만든 데이터 >> 이미 존재 처음에 만듬

cars # 값이 겹치지 않는 데이터 사용
str(cars)
attach(cars) # 속성을 변수로 사용
speed
detach(cars) # 속성을 변수로 사용 해제
speed

cars$speed # 안쓸거면 이렇게 써야함
min(cars$speed)
mean(cars$speed) # 이런식

# subset
subset(cars, speed > 20) # subset(데이터, 속성에 대한 논리식)
subset(cars, speed == 17)
subset(cars, speed > 19, select = c(dist)) # select를 사용해서 데이터 특정
subset(cars, speed > 19, select = -c(dist)) # select를 사용해서 데이터 특정
subset(cars, speed > 19, select = 'dist') # 이런식로도 됨

cars[cars$speed > 20,] # 서브셋 잘 안쓰고 보통 이런식으로 씀

# 결측값(NA) 처리
head(airquality)
str(airquality)
sum(airquality$Ozone)

head(airquality)
head(na.omit(airquality)) # 결측치가 있는 데이터 제외

# 병합(Merge)
patients
patients1 = data.frame(name, age)
patients2 = data.frame(name, gender, blood_type)
merge(patients1, patients2, by = 'name')

