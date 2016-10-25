propsurvivor<-function(colname) {
  t <- prop.table(table(titanic$survived,titanic[[colname]] ),2)
}

plotitanic <-function(X="age",Y="pclass",Col="sex", facet_row="survived",facet_col=".",jitter=F,smooth=F){
p <- ggplot(titanic, aes_string(x="age", y="pclass")) + geom_point()

if (Col != 'None') 
  p <- p + aes_string(color=Col)

facets <- paste(facet_row, '~', facet_col)
if (facets != '. ~ .')
  p <- p + facet_grid(facets)

if (jitter)
  p <- p + geom_jitter()
if (smooth)
  p <- p + geom_smooth()
return(p)
}


trainmodel <- function (modeltype, params, ncv){
  
  set.seed(1960)
  
  #print(params)
  # Training Models
  
  if (modeltype == "lr") {
  # A) Logistic Regression
  # set seed for reproductibility
  

  model.lr <- train(survived ~ pclass + sex + agecategory + farecategory, 
                    data = titanic, 
                    method="glm", family="binomial",
                    trControl = trainControl(method = "cv", 
                                             number = ncv) )

  #summary(model.lr)
  #confusionMatrix(model.lr)
  
  return(model.lr)
  }
  
  
  if (modeltype == "dt") {
  # B) Random forest algorithm
  # set seed for reproductibility

  
  
  if (nchar(params)<2){ params<-"sex"}
  args<-list()
  args$form <- as.formula(paste("survived ~ ", params))
  args$data<-titanic
  args$method<-"rpart"
  args$cp<- 0.002
  args$maxdepth<-12
  
  
  model.dt <- do.call("train",args)                
  
  
  
  return(model.dt)
  }
  if (modeltype == "rf") {
  # C) Random forest algorithm
  # set seed for reproductibility
  
  #model.rf <- train(survived ~ pclass + sex + agecategory + farecategory, data = titanic, method = "rf",
                    
    if (nchar(params)<2){ params<-"sex"}
    args<-list()
    args$form <- as.formula(paste("survived ~ ", params))
    args$data<-titanic
    args$method<-"rf"
    args$trControl <- trainControl(method = "cv",number = ncv) 
  
  
    model.rf <- do.call("train",args)  
  
  
  return(model.rf)
  } 
}



retmodeldt <- function(modtype, params) {
  
  ret <-list()
  
 # print(params)
    
    # computing the decision tree
    model <- trainmodel(modtype, params, ncv =0)
    ret$model<- model
    ret$summary<- summary(model)
    ret$plot <- fancyRpartPlot(model$finalModel)
    
    
    return(ret) 
    
    }
retmodelrf <- function(modtype, params,ncv) {
  
  ret <-list()
  
  #print(params)
  
  # computing the random forrest
  model <- trainmodel(modtype, params, ncv )
  ret$model<- model
  ret$summary<- summary(model)
  ret$plot <- plot(model$finalModel)
  ret$conf<- confusionMatrix(model)
  
  
  return(ret) 
  
} 
