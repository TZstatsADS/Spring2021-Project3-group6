########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3


cv.function_XGS<- function(data, K,l,p=0.5){
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
    
    data_train.S<- SMOTE(label~.,dat_train)
    feature_train.S<-as.matrix(data_train.S[,-6007])
    label_train.S<-as.integer(data_train.S$label)-1
    ## sample reweighting
 
    weight_test <- rep(NA, length(label_test))
    for (v in unique(data$label))
    {
      weight_test[label_test == v] = 0.5 * length(label_test) / length(label_test[label_test == v])
    }
    
    ## model training( if not want to use SMOTE, can just input feature_train and label_train)
    model_train <- train_XGS(feature=feature_train.S,label=label_train.S,l) #l is the parameter test 
   
    ## make predictions
    prob_pred<-  predict(model_train, feature_test)
    label_pred <- ifelse(prob_pred>p,1,0)
    cv.error[i] <- 1 - sum(weight_test * (label_pred == label_test)) / sum(weight_test)
    tpr.fpr <- WeightedROC(prob_pred, label_test, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}