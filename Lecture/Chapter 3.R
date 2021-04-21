### 210421


# 변수 : data 저장 공간
# 데이터 형 : 숫자형, 문자형, 범주형, 논리형, 특수 상수 ...
# 연산자 : 산술, 비교, 논리 연산자
## 산술 : +, -, *, /, %...
## 비교 : >, <, =>, =<, ==, =!
## 논리 : and, or, not...
# 벡터 : 단일 값들의 모임
# 배열(array: : 열과 행을 가지는 데이터 집합, 벡터의 요소들이다시 벡터로 구성된 형태
# 데이터 프레임 : 서로 다른 데이터 형이 표 형태로 정리된 구조, 각 속성의 크기가 같음
# 리스트 : 데이ㅓ 프레임과 유사한 표 형태의 구조, 각 속성의 크기가달라도 됨

getwd()

# 변수
x = 1
y = 2
z = x + y
z

# 대치
x = y
x


# 데이터 형
## 숫자 : int

typeof(x)
a = 'string'
typeof(a)
b = 'double quote'
typeof(b)
c = '한글'
typeof(c)

# 실수(NUMeric)
x = 5
y = 2
typeof(x)
x/y

# 복소수(COMplex)
xi = 1
yi = 1 -2i
xi - yi
xi + yi

# 범주형(Category)
blood_type = factor(c('a','b','ab','o'))
blood_type
typeof(blood_type)

# 논리형(Boolean)
TRUE
FALSE
T
F

xinf = Inf
yinf = -Inf
xinf/yinf # NaN = Not a Number

# 데이터형 확인 함수
class(x) # R객체 지향 관점
type(x) # 틀림
typeof(x) # R언어 지향 관점
is.integer(x)
is.numeric(x)
is.complex(xi)
is.complex(yi)
is.character(c)
is.na(xinf/yinf) #확인 함수 안에 꼭 변수가 나올 필요 없음
#>>> 계산식이나 상수가 나와도 됨

#데이터형 변환 함수
as.integer(x)
typeof(x)
x=as.integer(x)
typeof(x)
is.integer(x)
x

is.factor(as.factor(c))
c
typeof(c)
c = as.factor(c)
typeof(c)
is.factor(c)

# 연산자 (operator)
5^2
5**2
4^(1/2)
4**-2
1/4^2

73%%3 #나머지
72%/%3 # 몫몫

# 비교연산자
x < y
x > y
x  >= y
x <= y
x == y
x !=y

# 논리 연산자
!T
!F
x|y
x&y
T|F
T&F
a = c(F,F,T,F)
b = c(T,F,T,T)
a|b
a&b

help
help(operator)
??operator
