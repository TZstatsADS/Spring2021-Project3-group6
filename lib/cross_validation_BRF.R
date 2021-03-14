########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3


cv.function <- function(features, labels, K, num_tree,mtry){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - l: tuning parameters 
  ### - reweight: sample reweighting 
  
  set.seed(2020)
  n <- dim(features)[1]
  n.fold <- round(n/K, 0)
  s <- sample(n) %% K + 1 
  cv.error <- rep(NA, K)
  cv.AUC <- rep(NA, K)

  for (i in 1:K){
    ## create features and labels for train/test
    feature_train <- features[s != i,]
    feature_test <- features[s == i,]
    label_train <- labels[s != i]
    label_test <- labels[s == i]
    
    ##ROSA 
    data_train<-data.frame(cbind(feature_train,label_train))
    data_train<-ROSE(label_train~., data=data_train)$data
    feature_train<-data_train[,-6007]
    label_train<-data_train[,6007]
  
    ## model training
      model_train <- train(feature_train, label_train, num_tree,mtry)
   
    ## make predictions
    prob_pred <- test(model_train, feature_test)$predictions
    length(prob_pred[,2])
    length(label_pred)
    label_pred <- ifelse(prob_pred[,1]>prob_pred[,2],1,2)
    cv.error[i] <- 1 - sum(label_pred == label_test)/length(label_test)
    weight_test<-rep(1,length(label_test))
    tpr.fpr <- WeightedROC(prob_pred[,2],label_test,weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}