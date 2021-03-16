###########################################################
### Make predictions with test features ###
###########################################################

test_BRF <- function(model, features){
  res <- predict(model, 
                 data.frame(features))
  return(res)
}

