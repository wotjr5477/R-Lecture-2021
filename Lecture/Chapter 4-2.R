# 210422


# 조건문

## 1. []에 행/열 조건 명시
### 벡터
testv = c(15,20,32,NA,46); testv
testv[testv<40] # NA(결측값) 포함
testv[testv<40 & !is.na(testv)] # NA 제외
is.na(testv)
!is.na(testv)
testv[testv%%3==0 & !is.na(testv)] # 3의 배수

###데이터 프레임
testdf = data.frame(name=c('길동','춘향','철수'),
                    age=c('29','17','21'),
                    gender = factor((c('M','F','M'))))
testdf

df = testdf
df[df$gender=='F',] # 여성인 행 추출
df[df$gender =='M'&df$age>=25,] # 25세 이상 남성


# if문
x = 5
if(x%%2 == 0){
  print('짝수입니다') #indentation(들여쓰기) 신경쓰기
} else
  print('홀수입니다.')

x = 0
if(x>0) {
  print('양수입니다')
} else if(x<0) {
  print('음수입니다')
} else print('Zero')


# ifelse 문 // ifelse(데이터 조건문, T일 때, F일 때)
score = 75
pass = ifelse(score>=60, '합격','불합격')
pass


#students.csv에서 학점 부여하기
students = read.csv(file='data/students.csv'); students
str(students)

apply(students[,2:4], 1, mean)
options(digits = 5)
apply(students[,2:4], 1, mean)

students['avg'] = c(apply(students[,2:4],1,mean))
students

students['grade'] = ifelse(students$avg > 90, 'A',
                           ifelse(students$avg > 80, 'B',
                                  ifelse(students$avg > 70, 'C', 'D')))
students
