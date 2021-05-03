# 210503
install.packages("rpart")

# 2. WINE 데이터
# 1. UCLA 데이터 - 4가지 모델 DT/RF/SVM/KNN 예측/평가
ucla = read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(ucla)
str(ucla)

set.seed(2021)
ucla_index = createDataPartition(ucla$admit, p=0.8, list=F)
ucla_train = ucla[ucla_index,]; str(ucla_train)
ucla_test = ucla[-ucla_index,]; str(ucla_test)

## DT
table(ucla_train$admit)
table(ucla_test$admit)

### 학습
dt = rpart(admit~., ucla_train)

### 예측
pred = predict(dtc, iris_test, type="class")

# 평가
confusionMatri(pred, iris_test$Species)

# 시각화
rpart.plot(dtc)





