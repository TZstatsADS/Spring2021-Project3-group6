###########################################################
### Make predictions with test features ###
###########################################################

test.lda <- function(model, features){
  res <- predict(model=lda_M, 
                 features=feature_test_new)
  return(res)
  }

# This function is not necessary.
# We put it here just to show the structure.