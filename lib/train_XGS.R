###########################################################
### Train a classification model with training features ###
###########################################################

train_XGS <- function(feature, label,l){
  dtrain<-xgb.DMatrix(feature,label=label)
  model <- xgb.train(params=l,
                     data=dtrain,
                     nrounds=100,
                     booster = "gbtree",
                     objective = "binary:logistic", 
                     eval_metric="auc")
                 
  return(model)
}