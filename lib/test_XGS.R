###########################################################
### Make predictions with test features ###
###########################################################

test <- function(model, test_data){
  res <- predict(model, 
                test_data )
  return(res)
}

# This function is not necessary.
# We put it here just to show the structure.
