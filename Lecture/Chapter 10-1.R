# 210504


# UCLA DT/RF/SVM/K-NN
# 1. UCLA 데이터 - 4가지 모델 DT/RF/SVM/KNN Cross Validation을 하고 정확도 정밀도 재현율 구하기
library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class)

ucla = read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(ucla)
str(ucla)
ucla$admit = factor(ucla$admit)

set.seed(2021)
ucla_index = createDataPartition(ucla$admit, p=0.8, list=F)
ucla_train = ucla[ucla_index,]; str(ucla_train)
ucla_test = ucla[-ucla_index,]; str(ucla_test)

# 4개 모델에 적용
control =  trainControl(method = "cv", number = 5)
dt = train(admit~., ucla, method = "rpart", metric = "Accuracy", trControl = control)
rf = train(admit~., ucla, method = "rf", metric = "Accuracy", trControl = control)
sv = train(admit~., ucla, method = "svmRadial", metric = "Accuracy", trControl = control)
kn = train(admit~., ucla, method = "knn", metric = "Accuracy", trControl = control)

resamp = resamples(list(결정트리 = dt, 랜덤포리스트 = rf, SVM = sv, KNN = kn))
summary(resamp)

# 재현율 = 민감도
confusionMatrix(dt)



# 교수님 풀이
ucla = read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
ucla$admit = factor(ucla$admit)

data = ucla[sample(nrow(ucla)),]

# K-Fold CV, k=5
k = 5
q = nrow(data) / k
l = 1:nrow(data)
accuracy = 0
precision = 0
recall = 0

for (i in 1:k) {
  test_list = ((i-1)*q+1): (i*q)
  data_test = data[test_list,]
  data_train = data[-test_list,]
  dt = train(admit~., data_train, method="rpart")
  pred = predict(dt, data_test)
  t = table(pred, data_test$admit)
  #print((t[1,1]+t[2,2]+t[3,3]))/nrow(data_test)
  accuracy = accuracy + (t[1,1]+t[2,2])/nrow(data_test)
  precision = precision + t[2,2]/(t[2,1]+t[2,2])
  recall = recall + t[2,2]/(t[1,2]+t[2,2])
}

average_acc = accuracy / k
average_prec = precision / k
average_rec = recall / k

options(digits = 4)

# DT
# K-Fold CV, k=5 >> 2nd try
k = 5
q = nrow(data) / k
l = 1:nrow(data)
accuracy = 0
precision = 0
recall = 0

for (i in 1:k) {
  test_list = ((i-1)*q+1): (i*q)
  data_test = data[test_list,]
  data_train = data[-test_list,]
  dt = rpart(admit~., data_train)
  pred = predict(dt, data_test, type = "class")
  t = table(pred, data_test$admit)
  #print((t[1,1]+t[2,2]+t[3,3]))/nrow(data_test)
  accuracy = accuracy + (t[1,1]+t[2,2])/nrow(data_test)
  precision = precision + t[2,2]/(t[2,1]+t[2,2])
  recall = recall + t[2,2]/(t[1,2]+t[2,2])
}

dt_average_acc = accuracy / k
dt_average_prec = precision / k
dt_average_rec = recall / k

options(digits = 4)

# RF
accuracy = 0
precision = 0
recall = 0

for (i in 1:k) {
  test_list = ((i-1)*q+1): (i*q)
  data_test = data[test_list,]
  data_train = data[-test_list,]
  rf = randomForest(admit~., data_train)
  pred = predict(rf, data_test, type = "class")
  t = table(pred, data_test$admit)
  #print((t[1,1]+t[2,2]+t[3,3]))/nrow(data_test)
  accuracy = accuracy + (t[1,1]+t[2,2])/nrow(data_test)
  precision = precision + t[2,2]/(t[2,1]+t[2,2])
  recall = recall + t[2,2]/(t[1,2]+t[2,2])
}

rf_average_acc = accuracy / k
rf_average_prec = precision / k
rf_average_rec = recall / k

options(digits = 4)

# SVM
accuracy = 0
precision = 0
recall = 0

for (i in 1:k) {
  test_list = ((i-1)*q+1): (i*q)
  data_test = data[test_list,]
  data_train = data[-test_list,]
  sv = svm(admit~., data_train)
  pred = predict(sv, data_test, type = "class")
  t = table(pred, data_test$admit)
  #print((t[1,1]+t[2,2]+t[3,3]))/nrow(data_test)
  accuracy = accuracy + (t[1,1]+t[2,2])/nrow(data_test)
  precision = precision + t[2,2]/(t[2,1]+t[2,2])
  recall = recall + t[2,2]/(t[1,2]+t[2,2])
}

sv_average_acc = accuracy / k
sv_average_prec = precision / k
sv_average_rec = recall / k

options(digits = 4)

# K-NN
accuracy = 0
precision = 0
recall = 0

for (i in 1:k) {
  test_list = ((i-1)*q+1): (i*q)
  data_test = data[test_list,]
  data_train = data[-test_list,]
  pred = kn = knn(data_train[,1:4], data_test[,1:4], data_train$admit, k=5)
  t = table(pred, data_test$admit)
  #print((t[1,1]+t[2,2]+t[3,3]))/nrow(data_test)
  accuracy = accuracy + (t[1,1]+t[2,2])/nrow(data_test)
  precision = precision + t[2,2]/(t[2,1]+t[2,2])
  recall = recall + t[2,2]/(t[1,2]+t[2,2])
}

kn_average_acc = accuracy / k
kn_average_prec = precision / k
kn_average_rec = recall / k

options(digits = 4)

sprintf("결정트리 : 정확도=%f, 정밀도=%f, 재현율=%f", dt_average_acc, dt_average_prec, dt_average_rec)
sprintf("랜덤 포레스트 : 정확도=%f, 정밀도=%f, 재현율=%f", rf_average_acc, rf_average_prec, rf_average_rec)
sprintf("SVM : 정확도=%f, 정밀도=%f, 재현율=%f", sv_average_acc, sv_average_prec, sv_average_rec)
sprintf("K-NN : 정확도=%f, 정밀도=%f, 재현율=%f", kn_average_acc, kn_average_prec, kn_average_rec)

