###########################################################
### Make predictions with test features ###
###########################################################

test.boost <- function(model, features, pred.type){
  dtrain <- xgb.DMatrix(data = data.matrix(as.matrix(features)))
  res <- predict(model, dtrain, type = pred.type)
  return(res)
}
