###########################################################
### Train a classification model with training features ###
###########################################################


train.lda <- function(y_train=label_train, data){
  lda_M <- lda(y_train~., data=as.data.frame(pca$x))
  return(lda_M)
}