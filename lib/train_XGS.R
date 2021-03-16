###########################################################
### Train a classification model with training features ###
###########################################################

train_XGS <- function(feature, label,l){
  dtrain<-xgb.DMatrix(feature,label=label)
  model <- xgb.train(params=l,
                     data=dtrain,
                     nrounds=160,
                     eta=0.1,
                     booster = "gbtree",
                     objective = "binary:logistic", 
                     eval_metric="auc",
                     eval_metric="error",
                     verbose=0,
                     gamma=0.1,
                     colsample_bytree=0.8,
                     subsample=0.9,
                     min_child_weight=1.5)
                 
  return(model)
}