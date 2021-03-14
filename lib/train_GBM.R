###########################################################
### Train a classification model with training features ###
###########################################################

train_GBM <- function(traindf, weight=NULL,num.trees,rate,
                  depth,bag_f, n_m){
  gbm.model <- gbm(formula=label~.,
               distribution="multinomial",
               data = traindf,
               n.trees = num.trees,
               shrinkage=rate,
               interaction.depth=depth,
               bag.fraction=bag_f,
               n.minobsinnode=n_m,
               verbose=FALSE,
               keep.data = TRUE,
               weights = weight,
               n.cores=NULL)
  return(gbm.model)
}


