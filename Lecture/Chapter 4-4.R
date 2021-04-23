#210423


# 함수
fact = function(x) {
  prod = 1
  for(i in 1:x) {
    prod = prod * i
  }
  return(prod)
}
fact(5)
fact(10)


# a~b의 합을 구하는 함수
rsum = function(a,b) {
  k = 0
  for(i in a:b) {
    k = k + i
  }
  return(k)
}
rsum(2,5)
rsum(1,4)

# 재귀 함수
facto = function(n) {
  if (n == 0) {
    return(1)
  }
  return(n *facto(n-1))
}
facto(10)


#
fibo(n) = fibo(n-1) + fibo(n-2)
fibo = function(n) {
  if(n==0 | n==1) return(1)
  return(fibo(n-1) + fibo(n-2))
}

for (i in 0:10) {
  print(paste(i, fibo(i)))
}

#
peak2peak = function(x) {
  return(max(x)-min(x))
}

mat = matrix(1:12, nrow = 3);mat
apply(mat, 1, mean)
apply(mat, 1, peak2peak)
apply(mat, 2, peak2peak)
