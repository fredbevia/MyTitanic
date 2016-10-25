library(shiny)
library(shinythemes)

source("functions_ui.R",local=T)

dataset<- read.csv("data/titanic3.csv", sep=";", stringsAsFactors=FALSE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("flatly"),
  


  #titlePanel("Running R Code in the cloud"),
  
  tabsetPanel( "About",
    
    tabPanelAbout(),
   

    "The Data Table",
    tabPanel('The Data', dataTableOutput('titanic')),
    
    
    
    
     "Graphs",
    
           tabPanel("Data Analysis", 
             sidebarPanel(  
               
               h3(' Titanic Explorer'),
               
               sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                           value=min(1000, nrow(dataset)), step=500, round=0),
               
               selectInput('x', 'X', names(dataset)),
               selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
               selectInput('color', 'Color', c('None', names(dataset))),
               
               checkboxInput('jitter', 'Jitter'),
               checkboxInput('smooth', 'Smooth'),
               
               selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
               selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
                 ),
               
               mainPanel(
                 h3("Basic Visual  Exploration"),
                 plotOutput("dataPlot1") ,
                 plotOutput("dataPlot2")
               )
             ),
    
            
    "Age&Fare Analysis",
            tabPanel("Age & Fare repartition",
                       sidebarLayout(  
                             sidebarPanel(
                                          sliderInput("agecat", "Number of Age Categories", min=1, max=30, value=8),
                                          sliderInput("farecat", "Number of Fare Categories", min=1, max=10, value=4)
                                      
                                    ),
                             mainPanel(
                                    # h2("Survival by Age Categories"),
                                     plotOutput("dataplot3") ,
                                     plotOutput("dataplot4")
                              )
                      )) ,
            
    "Modeling",
    
          tabPanel("Models", 
                   sidebarLayout(  
                     sidebarPanel(
                       selectInput(
                         "modelType", "Choose a Model",
                         c("Decision Tree"="dt","Random Forest"="rf")),
                       
                       # Only show this panel if the model type is a dt
                       conditionalPanel(
                         condition = "input.modelType == 'dt'",
                         checkboxGroupInput("Paramsdt", label = h4("Variables to take into account"), 
                                            choices = list("Sex" = "sex", "Age" = "age", "Class" = "pclass", "Fare"="fare", 
                                                           "Embarkment"="embarked", "Family Size"="familysize", "Number of Siblings on board"="sibsp"), 
                                            selected = list("Sex" = "sex", "Age" = "age")
                         )),
                         
                         # Only show this panel if Custom is selected
                         conditionalPanel(
                           condition = "input.modelType == 'rf'",
                           sliderInput("ncv", "Number of Cross Validation", min=1, max=1000, value=5),
                           checkboxGroupInput("Paramsrf", label = h4("Variables to take into account"), 
                                              choices = list("Sex" = "sex", "Age" = "age", "Class" = "pclass", "Fare"="fare", 
                                                             "Embarkment"="embarked", "Family Size"="familysize", "Number of Siblings on board"="sibsp"), 
                                              selected = list("Sex" = "sex", "Age" = "age")
                         )
                       )
                   ),
                   
                   
                   
                   mainPanel(
                     
                     conditionalPanel( condition = "input.modelType == 'dt'",
                                       h2("Decision tree obtained with rpart"),
                                       plotOutput("modelPlot")
                     ),
                     
                     conditionalPanel( condition = "input.modelType == 'rf'",
                                       h2("Random forest with crossvalidation") ,
                                       #plotOutput("plotmodel")
                                       verbatimTextOutput("modelSummary"),
                                       verbatimTextOutput("modelModel"),
                                       verbatimTextOutput("modelConfMat")
                                       
                     )                       
                     
                     
                     
                     ))) #,
    
    
   # tabPanel("Are You a Survivor?", 
    #         sidebarLayout(  
    #          
    #           sidebarPanel(
    #             "Select your characteristic of the passenger :",
    #             radioButtons("Sex", "Sex", choices=list("Male"=1,"Female"= 0), selected=0),
    #             sliderInput("Age", "Age", min=0, max=100, value = 25),
    #             radioButtons("Pclass", "Class", choices=list("First"=1, "Second"=2, "Third"=3), selected=2),
    #             sliderInput("Fare", "Fare", min=1, max=100, value=10),
    #             selectInput("Embarked", "Embarked at", choices=list("Cherbourg"="C", "Queenstown"="Q", "Southhampton"="S"), selected="S"),
    #             sliderInput("FamilySize", "Family size", min=1, max=15, value=3),
    #             sliderInput("Siblings", "Number of Siblings on board", min=0, max=10, val=2)
    #                                                 
    #             ),
    #           
    #           mainPanel(
    #             h2("Prediction according to the current prediction model"),
    #             "According to the currently computed model, you must have",
    #             textOutput("AreYouSurvivor", container=strong), " !",
    #             br()
    #                             
    #           )
    #         ))
             
    )

  
  
))


