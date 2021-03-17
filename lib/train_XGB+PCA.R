###########################################################
### Train a classification model with training features  ###
###########################################################

require(xgboost)
library(Matrix)

train <- function(features, labels, w = NULL, l = 1){
  model <- glmnet(features, labels, weights = w, alpha = 1, family = "binomial", lambda = l)
  return(model)
}

## XGBOOST MODEL
train.xgboost <- function(data_ ,label_, w = NULL, depth_=4){
  
  #Create appropriate format function for xgboost model
  #x.train <- xgb.DMatrix(data = as.matrix(data_))
  #y.train <- xgb.DMatrix(data = as.matrix(label_))
  dtrain <- xgb.DMatrix(data = as.matrix(data_), label = as.matrix(label_))
  
  #print(dtrain)
  #Create xgboost model
  model <- xgboost(dtrain,booster = "gbtree", max.depth=4, eta = 0.08, nrounds = 55, objective = "binary:logistic", verbose = FALSE, eval_metric="error", nthread=50, w= NULL, min_child_weight=13,lambda=3)
  
  return(model)
}
