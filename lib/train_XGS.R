###########################################################
### Train a classification model with training features ###
###########################################################

train.XGB <- function(feature, label,l,w=1){
  dtrain<-xgb.DMatrix(feature,label=label)
  model <- xgb.train(params=l,
                     data=dtrain,
                     nrounds=160,
                     booster = "gbtree",
                     objective = "binary:logistic", 
                     scale_pos_weight=w,
                     eval_metric="error",
                     eval_metric="auc")
                 
  return(model)
}