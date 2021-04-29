# 210429

# 현실 세계의 모델링
x = c(3,6,9,12)
y = c(3,4,5.5,6.5)
plot(x,y)

# model 1 : y=0.5x + 1.0
y1 = 0.5*x + 1.0
y1

# 평균 제곱 오차 : Mean Squared Error
(y-y1)^2
sum((y-y1)^2)
mse = sum((y-y1)^2) / length(y); mse

# model 2 : y=5/12x +7/4
y2 = 5*x/12 +7/4
y2
mse2 = sum((y-y2)^2)/length(y); mse2

# r의 단순 선형회귀 모델 : lm
model = lm(y~x); model

plot(x, y)
abline(model, col = "red")
fitted(model)
mse_model = sum((y - fitted(model))^2) / length(y); mse_model

# 잔차 : Residuals
residuals(model)

# 잔차 제곱합
deviance(model)

# 평균 제곱 오차 (MSE)
deviance(model) / length(y) # 잔차 / n(y)
mse

summary(model)

# 예측
newx = data.frame(x=c(1.2, 2.0, 20.65)); newx
newy = predict(model, newdata = newx); newy
