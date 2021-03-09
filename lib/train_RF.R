###########################################################
### Train a classification model with training features ###
###########################################################

train <- function(features, labels, num_tree,mtry,w = NULL){
  labels<-ifelse(labels==2,0,1)
  model <- ranger(labels~.,
                  data=data.frame(features,labels),
                  num.trees=num_tree,
                  mtry=mtry,
                  case.weights=w,
                  classification=TRUE,
                  verbose = F,
                  importance = "none",
                  min.node.size = 1,
                  max.depth = 0
                 )
  return(model)
}