###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(dtrain,l){
  dtrain<-xgb.DMatrix(feature,label=label)
  model <- xgb.train(params=l,
                     data=dtrain,
                     nrounds=160,
                     gamma=0,
                     booster = "gbtree",
                     objective = "binary:logistic", 
                     scale_pos_weight=sumwneg/sumwpos,
                     eta=0.3,
                     watchlist=list(val=dtest,train=dtrain),
                     early_stop_round=10,
                     eval_metric="error",
                     eval_metric="auc")
                 
  return(model)
}