# 벡터(1차원 데이터)
s = c(1,2,3,4,5,6,7)
typeof(s)
str(s)
class(s)
summary(s)

# 기본, 단순
s1 = c(1:7)
s1
s
s2 = c(6:1)
s2
s3 = 1:5
s3
c(1, 3, c(4:6))
c(1:30)

# 연속, 규칙설정
seq(1:10) #default by = 1
seq(1,100,by=2)
seq(1,100,3) #by 생략 가능
seq(1,20,0.3)
seq(10, 1)
seq(from=10,to=1)
seq(0,1, by = 0.2)
seq(1,2,by=0.2)
seq(1,5,by=0.2)
seq(5,1,by=-0.2)
seq(12,6,by=2) #안됨
seq(12,7,by=1)

seq(5,1) #됨
seq(5,1,by=1) #안됨
seq(5,1,by=-1) #됨
seq(12,6,by=-2) #감소의 경우 default by = -1, -를 붙여야함
seq(12,6,-2)

#반복
rep(c(1:3),5)
help(rep)
rep(c(1:3),3)
rep(c(1:3),times=3) #전체
rep(c(1:3),each=3) #각각

#인덱싱
x = seq(2,10,2)
x
seq(2,10,2)
x[1] # 다른 랭귀지는 0부터시작,, 0,1,2번째라는 식
x[-1] # -가 붙으면 해당 인덱스 제외

x[3,4]
x[3],[4]
x['3','4']
x[c(3,4)]
x[c(-1,-3)]
x[-c(1,3)]
x[c(-1,3,4)] #+- 섞어서 안되나봄
## 슬라이싱
x[c(1:3)] #다른 랭귀지에서는 2가지 결과(1번째 2번째)만 나옴

# 연산
x = c(1:4); x
y = c(3:6); y
x + y
z = c(2:7); z
x+z #길이가 안맞으면 안됨
w = c(7:14);w
y; y + w #길이가 안맞아도 배수관계이면 반복해서 연산처리됨

x>2
all(x>2) # and : 모두 다 넘어야 됨
any(x>2) # or : 하나라도 넘으면 됨

# fancy 인덱싱
x; y; y>2; x[y>2]
x[y>5]
z>5; w; w[z>5]

# ??
head(x)
head(x,1)
tail(x)
tail(x,2)

# 집합 연산
x = 1:3
y = 3:5
z = c(3,6,2)
x;y;z

union(x,y)
union(x,z)
intersect(x,y)
intersect(union(x,y),z)
setdiff(x,y) #차집합 x-y
setdiff(y,x) #차집합 y-x
setequal(x,y) #동일집합인지 대조
setequal(x,z)
setequal(y,z)

help("setequal")
# example
(x <- c(sort(sample(1:20, 9)), NA))
(y <- c(sort(sample(3:23, 7)), NA))
union(x, y)
intersect(x, y)
setdiff(x, y)
setdiff(y, x)
setequal(x, y)

# examples in page.90
## 1
x = c(1:5);x
append(x,c(6:10))
## 2
x = c(1:10);x
x[seq(2,10,2)]
