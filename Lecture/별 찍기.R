#210423

# 별 그리기
# cat()을 이용해야함, cat()을 쓰면 한번 실행 될 때 콘솔에서 다음 줄로 넘어가지 않고 이어서 한번에 실행됨
print(3);print(3)
cat(3);cat(3)
cat(3)
cat(3)

# 다음 줄로 넘길 때는 cat("\n") 사용
cat(3);cat(4);cat(5);cat("\n")
cat(3);cat(4);cat(5);cat("\n");cat(6);cat(7) #이런식

## 직각 삼각형
cat("*"); cat("\n");  cat("*"); cat("*"); cat("\n");  cat("*"); cat("*"); cat("*"); cat("\n");  cat("*"); cat("*"); cat("*"); cat("*"); # 이런식으로 되야함

n = 4 # 4줄로 만들어보자
for(i in 1:n) {
  for(j in 1:i) cat("*"); cat("\n")
}

## 직각 삼각형(오른쪽 정렬)
cat(" "); cat(" "); cat(" "); cat("*"); cat("\n");  cat(" "); cat(" "); cat("*"); cat("*"); cat("\n");  cat(" "); cat("*"); cat("*"); cat("*"); cat("\n");  cat("*"); cat("*"); cat("*"); cat("*"); cat("\n"); # 이런식으로 되어야 함

for(i in 1:n) {
  for(j in 1:i) {
    
  }
}



num = 3
for (i in 1:num) {
  for (j in 1:(num-1)) {
    if (num-i>0) cat(" ")
  }
  for (j in 1:i) {
    cat("*")
  }
  cat("\n")
}



