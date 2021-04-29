# 210429


# Galton : 부모-자식의 키

# Gaton data load
install.packages("UsingR")
library(UsingR)
library(dplyr)
galton
data("galton")
head(galton)
str(galton)
head(galton)
head(GaltonFamilies)
head(Galton)
g = galton*2.54
head(g)
str(g)

a = read.csv("http://www.randomservices.org/random/data/Galton.txt", sep = "\t")
table(is.na(a))
head(a)
a = as_tibble(a);

str(a)
a %>% select(a$Mother)
select(a, Mother)

# 단순 선형회귀의 적용
plot(g)
g_model = lm(child~parent, data=g); g_model # child = 0.6463*parent + 23.9415
abline(g_model, col="red")

plot(g_model)

coef(g_model)

fitted(g_model)
# 잔차
residuals(g_model)
# 잔차 제곱합
deviance(g_model)
# 평균 제곱 오차
deviance(g_model)/length(g$parent)

g %>% ggplot(aes(parent, child)) + geom_count() + geom_smooth(method = "lm")


# 부모의 키가 176.4일 때 자식의 키는?
ph1 = data.frame(parent=c(170))
predict(g_model, ph1)

0.6463*170 + 23.9415

# 부모의 키가 각각 168.9, 173.5, 176.8, 172.6, 179.2, 182.4 일 때 자식의 키는?
ph2 = data.frame(parent=c(168.9, 173.5, 176.8, 172.6, 179.2, 182.4))
predict(g_model, ph2)

plot(ph1$parent, predict(g_model, ph1), col = "red", cex = 1, pch = 18)
plot(ph2$parent, predict(g_model, ph2), col = "red", cex = 1, pch = 18)
ph = rbind(ph1, ph2); ph
plot(ph$parent, predict(g_model, ph), col = "red", cex = 1, pch = 18)
abline(g_model)

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