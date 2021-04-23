#210423


# 반복문

# Repeat
i =1
sum = 0
repeat {
  if(i>10) {
    break
  }
  sum = sum+i
  i=i+1
}
print(sum)

# While
i = 1
sum = 0
while(i<=10) {
  sum = sum+i
  i = i+1
}
print(sum)

# For
sum = 0
for(i in 1:10) {
  sum = sum + i
}
print(sum)

# 10! 구하기
factorial(10)

fact = 1
for(i in 1:10) {
  fact=fact*i
}
print(paste0("10!은 '",fact,"'입니다.."))

# 1~50 홀수만 더하기
sum_odd = 0
for(i in 1:50) {
  if(i%%2 == 0) {
    add = 0
  } else add = i
  
  sum_odd = sum_odd + add
}
print(sum_odd)
print(paste0("1부터 50까지의 수 중 홀수의 합은 '", sum_odd,"'입니다.."))

#1 ~ 100 홀수만 더하깈
sum_odd = 0
for(i in 1:100) {
  if(i%%2 == 0) {
  } else sum_odd = sum_odd + i
}
print(sum_odd)
print(paste0("1부터 50까지의 수 중 홀수의 합은 '", sum_odd,"'입니다.."))

# 1~100 홀수만 더하기 2
sum_odd = 0
for(i in seq(1,100,2)) {
  sum_odd = sum_odd + i
}
print(sum_odd)
print(paste0("1부터 50까지의 수 중 홀수의 합은 '", sum_odd,"'입니다.."))


# 구구단 만들기
for (dan in 1:9) {
  print(paste0("-- ",dan,"단 --"))
  for (k in 1:9) {
    print(paste0(" ",dan,"x",k,"=",dan*k))
  }
  print("---------")
}


# 1~12 in 3x4 : n행 n제곱의 합
table = array(1:12,c(3,4)); table

r = 1
s = 0
while (r <= 3) {
  sr = table[r,]^r
  print(table[r,]^r)
  s = s + sr
  r = r + 1
}
print(s)
print(sum(s))


# 1~12 in 3x4 : n행 n제곱의 합 > 교수님 풀이
mat = matrix(1:12, nrow =3); mat
nrow = 3
ncol = 4

sum1=0
sum2=0
sum3=0

for(i in 1:nrow) {
  for(k in 1:ncol) {
    sum1 = sum1 + mat[i,k]
    sum2 = sum2 + mat[i,k]^2
    sum3 = sum3 + mat[i,k]^i
  }
}
print(paste(sum1, sum2, sum3))


# * 삼각형

for(i in 1:5) {
  star = ""
  for(k in 1:i) {
    star = paste0(star,"*")
  }
  print(star)
}

lst=list()
for (i in 1:5) {
  lst = append(lst, i)
}
lst
lst[4]
lst[[4]]
for(element in lst) {
  print(element)
}
?element

# 약수
n = 32
for(num in 1:n) {
  if(n%%num == 0) {
    print(num)
  }
}
##  약수의 합
n = 32
sum = 0
for(num in 1:n) {
  if(n%%num == 0) {
    sum = sum + num
  }
}
print(sum)


# 완전수(perfect number)
# >> 자기 자신을 제외한 약수의 합이 자기 자신과 같은 수
# 2~10000까지의 수 중 완전수 구하기
for(n in 2:10000) {
  sum = 0
  for(num in 1:(n-1)) {
    if(n%%num == 0) {
      sum = sum + num
    }
  }
  if (sum == n) {
    print(n)
  }
}
