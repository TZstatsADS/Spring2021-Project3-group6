########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3


cv.function <- function(features,labels, K,l){
  ### Input:
  ### - features: feature data frame
  ### - labels: label data vector
  ### - K: a number stands for K-fold CV
  ### - l: tuning parameters 
  ### - reweight: sample reweighting 
  set.seed<-2020
  sumwpos<-sum(labels==1)
  sumwneg<-sum(labels==0)
  dtrain<-xgb.DMatrix(features,label=labels)
 xgbcv<- xgb.cv( params = l,
          data = dtrain, 
          nrounds = 160, 
          nfold = K, 
          gamma=0,
          showsd = T, 
          stratified = T, 
          early_stop_round = 20, 
          eval_metric="auc",
          eval_metric="error",
          booster = "gbtree",
          objective = "binary:logistic", 
          scale_pos_weight=sumwneg/sumwpos,
          eta=0.3
          )
 result<-xgbcv$evaluation_logt
 cv.error<-result$test_error_mean
 cv.AUC<-result$test_auc_mean

  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}