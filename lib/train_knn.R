###########################################################
### Train a classification model with training features ###
###########################################################


train.knn <- function(xtrain, xtest, y_train, k = 1){
  model <- knn(xtrain, xtest, y_train, k = k)
  return(model)
}

