###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(feature, label,l){
  dtrain<-xgb.DMatrix(feature,label=label)
  model <- xgb.train(params=l,
                     data=dtrain,
                     nrounds=160,
                     booster = "gbtree",
                     objective = "binary:logistic", 
                     eval_metric="error",
                     eval_metric="auc")
                 
  return(model)
}