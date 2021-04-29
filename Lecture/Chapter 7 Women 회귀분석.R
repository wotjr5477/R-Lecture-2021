# 210429


# women 데이터
women # inch, pound
plot(women)
m = lm(weight~height, women); m
abline(m, col="red", lwd=1) # 2차식에 더 가까워보임 >>
summary(m)

# 2차식 모델링
m2 = lm(weight~poly(height,2), women); m2
x = seq(58,72, length.out=300)
y = predict(m2, data.frame(height=x))
lines(x,y, col="blue", lwd=1)
summary(m2)
 