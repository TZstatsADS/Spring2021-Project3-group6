###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(features, labels, num_tree,mtry,w = NULL){
  model <- ranger(labels~.,
                  data=data.frame(cbind(features,labels)),
                  num.trees=num_tree,
                  mtry=mtry,
                  case.weights=w,
                  classification=TRUE,
                  #probability = T,
                  verbose = F,
                  write.forest = T,
                  regularization.factor = 1,
                  importance = "none",
                  min.node.size = 10
                 )
  return(model)
}