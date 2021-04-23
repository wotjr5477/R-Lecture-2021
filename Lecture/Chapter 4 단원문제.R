#210423

# CHAPTER 4, 단원문제

#1
a = 0
for(i in seq(3,100,3)) {
  if(i%%4 != 0) {
    print(i) #3의 배수이면서 4의 배수는 아닌 수
    a = a + i;
  }
}
print(paste0("정답은 '",a,"'입니다."))

#2
xts = function(x, n) {
  b = 0
  for(i in 1:n) {
    if(i%%x == 0) {
      b = b + i
    }
  }
  print(paste0("1부터 ",n,"까지의 수 중 ",x,"의 배수의 합은 ",b,"입니다"))
}
xts(3,10)

#3
install.packages("hflights")
library("hflights")
sum(is.na(hflights))
print(paste0("정답은 '",sum(is.na(hflights)),"'개 입니다."))

#4
?hflights
str(hflights)
sum(is.na(hflights$AirTime))
time = max(na.omit(hflights$AirTime)); time # 549min
print(paste0(time%%60,"시간 ",time%/%60,"분"))

#5
head(hflights$Distance)
#sum(is.na(hflights$Distance))
max(hflights$Distance, na.rm = T)
print(paste0(max(hflights$Distance)," miles"))

#6
head(hflights$Cancelled)
#sum(is.na(hflights$Cancelled))
sum(hflights$Cancelled, na.rm = T)
print(paste0(sum(hflights$Cancelled),"건"))

