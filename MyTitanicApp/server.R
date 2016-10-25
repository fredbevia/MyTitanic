source("init.R")
source("preprocess.R")
source("functions_server.R")

shinyServer(function(input, output) {
 
  output$titanic <- renderDataTable({
    titanic
  }, options = list(bSortClasses = TRUE))
  
  
  output$dataPlot1 <- renderPlot({
    par(mfrow = c(2,3))
    barplot(propsurvivor("pclass"), main = "Survival Rates by Pclass", xlab = "pclass", ylab = "Percent Survived or Perished", col = c("blue", "gray"))
    barplot(propsurvivor("sex"), main = "Survival Rates by Sex", xlab = "sex", ylab = "Percent Survived or Perished", col = c("blue", "gray"))
    barplot(propsurvivor("sibsp"), main = "Survival Rates by Sibps", xlab = "sex", ylab = "Percent Survived or Perished", col = c("blue", "gray"))
    barplot(propsurvivor("parch"), main = "Survival Rates by Parch", xlab = "sex", ylab = "Percent Survived or Perished", col = c("blue", "gray"))
    barplot(propsurvivor("embarked"), main = "Survival Rates by Embarked", xlab = "sex", ylab = "Percent Survived or Perished", col = c("blue", "gray"))
    #barplot(propsurvivor("sex"), main = "Survival Rates by Sex", xlab = "sex", ylab = "Percent Survived or Perished", col = c("blue", "gray"))
    
    
    
    
    
  })
  
  
  
  
  output$dataPlot2 <- renderPlot({
    
    
    p <- ggplot(titanic, aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
  })

  output$dataplot3 <- renderPlot({
        
    p1<-ggplot(titanic, aes(age, fill = survived)) +  geom_histogram(bins  = input$agecat)  
    p1 <- p1 + labs( title = "Survival by Age Categories")
    p1 <- p1 + theme(plot.title = element_text(size=18, face="bold", margin = margin(10, 0, 10, 0)))
    
    p2<-ggplot(titanic, aes(age, fill = pclass), alpha=I(.5)) +  geom_density()
    p2 <- p2 + labs( title = "Class repartition by Age")
    p2 <- p2 + theme(plot.title = element_text(size=18, face="bold", margin = margin(10, 0, 10, 0)))
    
    p <- grid.arrange(p1, p2, ncol=2)
    
    print(p)  
    
    
  })
  output$dataplot4 <- renderPlot({
    
    p1<-ggplot(titanic, aes(fare, fill = survived)) +  geom_histogram(bins  = input$farecat)  
    p1 <- p1 + labs( title = "Survival by Fare Categories")
    p1 <- p1 + theme(plot.title = element_text(size=18, face="bold", margin = margin(10, 0, 10, 0)))
    
    p2<-ggplot(titanic, aes(fare, fill = pclass), alpha=I(.5)) +  geom_density()
    p2 <- p2 + labs( title = "Class repartition by Fare")
    p2 <- p2 + theme(plot.title = element_text(size=18, face="bold", margin = margin(10, 0, 10, 0)))
    
    p <- grid.arrange(p1, p2, ncol=2)
    
    print(p)  
    
    
  }) 

  paramsdt <- reactive({
    par <-NULL     
    par <- paste(input$Paramsdt, collapse="+")
          
    return(par)     
  })
  paramsrf <- reactive({
    par <-NULL     
    par <- paste(input$Paramsrf, collapse="+")
    
    return(par)     
  })
  ncv <- reactive({
         
    cv <- input$ncv
    
    return(cv)     
  })
 
  
  mymodel <- reactive({
    
     r<-NULL
    if(input$modelType == 'dt')
    {
      
      m <- c("dt")
      r<- retmodeldt(m,params = paramsdt())
      return(r)
    }
   
     if(input$modelType == 'rf')
     {
       
       m <- c("rf")
       r<- retmodelrf(m,paramsrf(),ncv())
       return(r)
     }
     
     #r<-retmodel(input$modelType,params())
    
  })
  
 
  output$modelPlot <- renderPlot({mymodel()$plot})
  output$modelModel  <- renderPrint({mymodel()$model})
  output$modelSummary  <- renderPrint({mymodel()$summary})
  output$modelConfMat  <- renderPrint({mymodel()$conf})
  
  
  output$AreYouSurvivor <- renderText({
                
                toTest <- data.frame(sex=input$Sex, age=input$Age, pclass=input$Pclass, sibsp=input$Siblings,
                                     fare=input$Fare, embarked=input$Embarked, familysize = input$FamilySize)
                #toTest$pclass<-factor(toTest$Pclass, levels=c(1,2,3), labels=c("First class", "Second class", "Third class"))
                #the model is the last one selected in the models panel
                #print("model selectioné")
                #summary(mymodel()$model$finalModel)
                Prediction <- predict(mymodel()$model$finalModel, toTest, type="class")
                # write.csv(Prediction, "prediction.csv")
                return(as.character(Prediction))
  })
})
