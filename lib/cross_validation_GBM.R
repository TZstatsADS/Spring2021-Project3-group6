########################

########################

### Author: Weiwei Song
### Project 3


cv.function_GBM <- function(traindf, K = 5, num.trees,rate,depth,
                        bag_f, n_m, reweight = FALSE){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - n.trees: number of trees 
  ### - shrinkage: learning rate 
  ### - bag.fraction: introduce stochastic gradient descent
  ### - n.minobsinnode: the minimum number of observations allowed in the trees terminal nodes
  ### - reweight: sample reweighting 
  
  set.seed(2020)
  n <- dim(traindf)[1]
  n.fold <- round(n/K, 0)
  s <- sample(n) %% K + 1
  cv.error <- rep(NA, K)
  cv.AUC <- rep(NA, K)
  
  for (i in 1:K){
    ## create features and labels for train/test
    data_train <- traindf[s != i,]
    data_test <- traindf[s == i,]
    label_train <- as.integer(data_train$label)
    label_test <- as.integer(data_test$label)
    
    ## sample reweighting
    weight_train <- rep(NA, length(label_train))
    weight_test <- rep(NA, length(label_test))
    for (v in unique(label_train)){
      weight_train[label_train == v] = 0.5 * length(label_train) / length(label_train[label_train == v])
      weight_test[label_test == v] = 0.5 * length(label_test) / length(label_test[label_test == v])
    }
    
    ## model training
    if (reweight){
      model_train <- train_GBM(data_train,weight = weight_train, num.trees,rate,depth,
                           bag_f,n_m)
    } else {
      model_train <- train_GBM(dat_train, weight = NULL, num.trees,rate,depth,
                           bag_f,n_m)
    }
    
    ## make predictions
    pred <- test_GBM(model_train, data_test)
    prob_pred <- pred[[2]]
    label_pred <- as.integer(pred[[1]])
    #cv.error[i] <- mean(label_pred != label_test)
    cv.error[i] <- 1 - sum(weight_test * (label_pred == label_test)) / sum(weight_test)
    tpr.fpr <- WeightedROC(prob_pred, label_test, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}

