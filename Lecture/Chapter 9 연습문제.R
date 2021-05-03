# 210503
library(rpart)
library(rpart.plot)
library(e1071)
library(caret)
library(randomForest)
library(class)


# 1. UCLA 데이터 - 4가지 모델 DT/RF/SVM/KNN 예측/평가
ucla = read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(ucla)
str(ucla)
ucla$admit = factor(ucla$admit)

set.seed(2021)
ucla_index = createDataPartition(ucla$admit, p=0.8, list=F)
ucla_train = ucla[ucla_index,]; str(ucla_train)
ucla_test = ucla[-ucla_index,]; str(ucla_test)

## DT

### 학습
dt = rpart(admit~., ucla_train);
### 예측
dt_pred = predict(dt, ucla_test, type="class")
### 평가
confusionMatri(dt_pred, iris_test$Species)
### 시각화
rpart.plot(dt)


## RF

### 모델링 / 학습
rf = randomForest(admit~., ucla_train)
rf
### 예측
rf_pred = predict(rf, ucla_test, type="class")
### 평가
confusionMatrix(rf_pred, ucla_test$admit)
### 시각화
plot(rf)


## SVM

### 모델링
sv = svm(admit~., ucla_train)
### 예측
sv_pred = predict(sv, ucla_test, type="class")
### 평가
confusionMatrix(sv_pred, ucla_test$admit)
table(sv_pred, ucla_test$admit)


## K-NN

###
kn = knn(ucla_train[,1:4], ucla_test[,1:4], ucla_train$admit, k=5)
kn
confusionMatrix(kn, ucla_test$admit)



# 2. WINE 데이터
wine = read.table("data/wine.data.txt", header = F, sep = ",")
head(wine)
colnames(wine)[2:14] = readLines("data/wine.name.txt")
colnames(wine) = substr(colnames(wine), 4, nchar(colnames(wine)))
head(wine)




##
ucla = read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(ucla)
str(ucla)
ucla$admit = factor(ucla$admit)

set.seed(2021)
ucla_index = createDataPartition(ucla$admit, p=0.8, list=F)
ucla_train = ucla[ucla_index,]; str(ucla_train)
ucla_test = ucla[-ucla_index,]; str(ucla_test)

## DT

### 학습
dt = rpart(admit~., ucla_train);
### 예측
dt_pred = predict(dt, ucla_test, type="class")
### 평가
confusionMatri(dt_pred, iris_test$Species)
### 시각화
rpart.plot(dt)


## RF

### 모델링 / 학습
rf = randomForest(admit~., ucla_train)
rf
### 예측
rf_pred = predict(rf, ucla_test, type="class")
### 평가
confusionMatrix(rf_pred, ucla_test$admit)
### 시각화
plot(rf)


## SVM

### 모델링
sv = svm(admit~., ucla_train)
### 예측
sv_pred = predict(sv, ucla_test, type="class")
### 평가
confusionMatrix(sv_pred, ucla_test$admit)
table(sv_pred, ucla_test$admit)


## K-NN

###
kn = knn(ucla_train[,1:4], ucla_test[,1:4], ucla_train$admit, k=5)
kn
confusionMatrix(kn, ucla_test$admit)