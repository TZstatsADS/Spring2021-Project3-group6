###########################################################
### Train a classification model with training features ###
###########################################################

train_XGB <- function(feature, label,l, w=NULL){
dtrain<-xgb.DMatrix(feature,label=label)

  model <- xgboost(params=l,
                     data=dtrain,
                     weight=w,
                     booster = "gbtree",
                     objective = "binary:logistic", 
                     eval_metric="auc",
                   verbose=0,
                   early_stopping_rounds=10,
                   maximize=TRUE
  )
                 
  return(model)
}