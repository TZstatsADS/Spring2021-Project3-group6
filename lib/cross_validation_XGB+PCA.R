########################
### Cross Validation ###
########################

### Author: Aurore Gosmant
### Project 3


cv.function.xgboost <- function(features, labels, K, depth, reweight = FALSE){
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
    

    #dtrain <- xgb.DMatrix(data = as.matrix(feature_train), label = as.matrix(label_train))
    #dtest <- xgb.DMatrix(data = as.matrix(feature_test), label = as.matrix(label_test))

    
    ## sample reweighting
    weight_train <- rep(NA, length(label_train))
    weight_test <- rep(NA, length(label_test))
    for (v in unique(labels))
    {
      weight_train[label_train == v] = 0.5 * length(label_train) / length(label_train[label_train == v])
      weight_test[label_test == v] = 0.5 * length(label_test) / length(label_test[label_test == v])
    }
    
    ## model training
    if (reweight){
      model_train <- train.xgboost(feature_train,label_train,depth_=depth, w = weight_train )
    } else {
      model_train <- train.xgboost(feature_test, label_test, depth_=depth, w = NULL )
    }
    
    
    ## make predictions
    label_pred <- ifelse(test.boost(model_train, feature_test, pred.type = 'response')>0.5,1,0)
    prob_pred <- test.boost(model_train, feature_test,pred.type = 'response')
    cv.error[i] <- 1 - sum(weight_test * (label_pred == label_test)) / sum(weight_test)
    tpr.fpr <- WeightedROC(prob_pred, label_test, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}