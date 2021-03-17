###########################################################
### Make predictions with test features ###
###########################################################

test_WRF <- function(model, features){
  res <- predict(model, 
                 data.frame(features))
  return(res)
}

# This function is not necessary.
# We put it here just to show the structure.