# 210429


# 단순 선형회귀의 적용
# cars 데이터
str(cars)
plot(cars)
car_model = lm(dist~speed, data=cars); car_model
coef(car_model)
abline(car_model, col="red")

par(mfrow=c(1,1))


# 속도: 21.5 / 제동거리는?
nx1 = data.frame(speed=c(21.5))
predict(car_model,nx1)
nx2 = data.frame(speed=c(25.0, 25.5, 26.0, 26.5, 27.0, 27.5, 28.0))
predict(car_model, nx2)

plot(nx1$speed, predict(car_model, nx1), col = "red", cex = 2, pch = 20)
plot(nx2$speed, predict(car_model, nx2), col = "red", cex = 2, pch = 20)
nx = rbind(nx1, nx2); nx
plot(nx$speed, predict(car_model, nx), col = "red", cex = 2, pch = 20)

abline(car_model)

# 고차식(polynomial) 적용하면 어떻게 될까
lm2 = lm(dist~poly(speed, 2), data=cars); lm2
plot(cars)
x = seq(4, 25, length.out=211)
head(x)
y=predict(lm2, data.frame(speed=x)); y
lines(x,y,col="purple", lwd=2)
abline(car_model, col="red", lwd =2)

summary(lm2)

# cars 1차식 부터 고차식 까지
x = seq(4,25,length.out=211)
colors = c("red","purple","darkorange","blue")
plot(cars)
for (i in 1:4) {
  m = lm(dist~poly(speed, i), data=cars)
  assign(paste("m",i,sep="."),m)
  y = predict(m, data.frame(speed=x))
  lines(x,y,col=colors[i], lwd=2)
}
summary(m)