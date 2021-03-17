###########################################################
### Make predictions with test features ###
###########################################################

test_GBM <- function(model, testdf){
  gbm.res <- predict.gbm(model, newdata = testdf,  type = "response")
  labels <- apply(gbm.res, 1, which.max)
  prob <- gbm.res[ ,2,1]
  return(list(labels,prob))
}

