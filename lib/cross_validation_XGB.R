########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3


cv.function_XGB<- function(data, K,l,p=0.5,reweight = FALSE){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - l: tuning parameters 
  ### - p: the classification threshold
  ### - reweight: sample reweighting 
  
  set.seed(2020)
  n <- dim(data)[1]
  n.fold <- round(n/K, 0)
  s <- sample(n) %% K + 1
  cv.error <- rep(NA, K)
  cv.AUC <- rep(NA, K)
  
  for (i in 1:K){
    ## create features and labels for train/test
    dat_train <- data[s != i,]
    dat_test <- data[s == i,]
    label_test<- as.integer(dat_test$label)-1
    feature_test<- as.matrix(dat_test[,-6007])
    feature_train<- as.matrix(dat_train[,-6007])
    label_train<- as.integer(dat_train$label)-1

    
    ## sample reweighting
    weight_train <- rep(NA, length(label_train))
    weight_test <- rep(NA, length(label_test))
    for (v in unique(label_train)){
      weight_train[label_train == v] = 0.5 * length(label_train) / length(label_train[label_train == v])
      weight_test[label_test == v] = 0.5 * length(label_test) / length(label_test[label_test == v])
    }
    
    ## model training
    if (reweight){
      model_train <- train_XGB(feature_train, lab_train,l,w = weight_train)
    } else {
      model_train <- train_XGB(feature_train, lab_train, l, w = NULL)
    }
    
  
    ## make predictions
    prob_pred<-  predict(model_train, feature_test)
    label_pred <- ifelse(prob_pred>p,1,0)
    cv.error[i] <- 1 - sum(weight_test * (label_pred == label_test)) / sum(weight_test)
    tpr.fpr <- WeightedROC(prob_pred, label_test, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}