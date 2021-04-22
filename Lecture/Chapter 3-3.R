#210422


# 배열_Array / 행열_Matrix
# 행열=2차원, 배열=n차원 >> 서로 다름

# 배열 생성 > array, matrix(2차원), cbind, rbind
# 데이터는 열마다 입력
x = array(1:5, c(2,4)) # array(데이터, n차원'c(행/열)')
x

x[1,] # 1행 / x[n,] > n행
x[,1] # 1열 / x[,n] > n열

name = list(c('1st','2nd'), c('1st','2nd','3rd','4th'))
x = array(1:5, c(2,4), dimnames = name) 
x
x[1,]
x['1st',] # 행이나 열만 추출할 때 기존 행/열번호와 행/이름도 사용 가능

# 2차원 배열(행렬) 생성
matrix(1:8, nrow=4) # matrix(데이터, 행(row)/열(column))
matrix(1:8, ncol=4) # 열(column)으로 해도 됨

y = c(1:12); y
matrix(y, nrow =4)
matrix(y, ncol=5) # 행/열은 데이터 수의 배수만 가능
matrix(y, nrow=24) # 지정한 행/열의 크기보다 데이터가 클 경우 반복
matrix(y, nrow=3, byrow = T) # byrow는 행 단위로 배치할지 물어봄 > 기본 열 단위
matrix(y, nrow=3, byrow = T, dimnames = list(c('a','b','c')))
matrix(y, nrow=3, byrow = T, dimnames = list(c('a','b','c')))

array(y, c(3,4)) # data를 미리 정해둔 값으로 입력가능
array(y, c(2,3)) # 지정한 크기가 데이터를 담지 못할 경우 짤림
array(y, c(4,5)) # 지정한 크기보다 데이터가 클 경우 처음 부터 반복


v1 = c(1,2,3,4)
v2 = c(5,6,7,8)
v3 = c(9,10,11,12)
cbind(v1, v2, v3) # 벡터를 열(Column/c) 단위로 묶어서 배열 생성
rbind(v1,v2,v3) # 벡터를 행(row/r) 단위로 묶어서 배열 생성

# 배열 연산
a1 = array(2:5, c(2,2)); a1
a2 = array(8:11, c(2,2)); a2
a1+a2
a1-a2
a1*a2 # 행열의 곱셈이 아닌 각 원소별 곱
a1%*%a2 # 이게 행렬 곱
a1; t(a1) # 전치행렬
a1; solve(a1) # 역행렬
det(a1)

a3 = array(3:8, c(2,3)); a3
a1+a3 # 같은 차원이 아니면 안됨
a1*a3
a1%*%a3 # 행렬곱 연산은 가능 (수학)

# 배열의 크기/차원 수
dim(a3)

d1 = data.frame(hi=c('hi','안녕'),bye=c('bye','잘가'),night=c('good night','잘자')); d1
dim(d1) # 데이터 프레임에도 됨

l1 = list(c('안녕','hi'),c('bye','잘가'),c('good night','')); l1
dim(l1) # 리스트는 당연히 안됨

# 샘플링
a = array(1:12, c(3,4))
a
sample(a)
sample(a,3)
length(sample(a))
