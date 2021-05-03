# 21503

# 비율대로 훈련/테스트 데이터 셋 만들기
train_index = createDatePartition(iris$Species, p=0.8, list=F)
iris_train = iris[train_index,]
iris_test = iris[-train_index,]
table(iris_train$Species)
table(iris_test$Species)

# 학습
dtc = rpart(Species~., iris_train)

# 예측
pred = predict(dtc, iris_test, type="class")

# 평가
confusionMatri(pred, iris_test$Species)

# 시각화
rpart.plot(dtc)

 