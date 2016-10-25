library(dplyr)
library(Amelia)
library(caret)
library(rattle)
library(randomForest)



propsurvivor<-function(colname) {t <- prop.table(table(titanic[[colname]], titanic$survived),1)}

titanic<- read.csv("D:/Developpement/R/MyTitanic/titanic3.csv", sep=";", stringsAsFactors=FALSE)
str(titanic)
if (dim(titanic)[1]> 1309) titanic <-titanic[1:1309,]

titanic$survived<- as.factor(titanic$survived)


titanic$age<- as.numeric(gsub(",",".",titanic$age))
titanic$fare<- as.numeric(gsub(",",".",titanic$fare))

missmap(titanic, main = "Missingness Map for Titanic Datas")

titanic$age[is.na(titanic$age)] <- median(titanic$age,na.rm = TRUE)
titanic$fare[is.na(titanic$fare)] <-mean(titanic$fare,na.rm = TRUE)

propsurvivor<-function(colname) {t <- prop.table(table(titanic[[colname]], titanic$survived),1)}

prop.table(table(titanic$survived))
t<-propsurvivor("pclass")
t

plot(as.factor(titanic$pclass),as.factor(titanic$survived))
t<-propsurvivor("sex")
t

plot(as.factor(titanic$sex),as.factor(titanic$survived))

summary(titanic$age)

titanic$agecategory = cut(titanic$age, breaks=c(0,21,39,80),labels=c("Child","Adult","Senior"))
#aggregate(survived ~ agecategory + sex, data=titanic, FUN=function(x) {(sum(x)/length(x))*100})
mosaicplot(~ sex + agecategory + survived, data=titanic)


summary(titanic$fare)

titanic$farecategory = cut(titanic$age, breaks=c(0,10,20,30,40,513))
# aggregate(survived ~ farecategory + pclass + sex, data=titanic, FUN=function(x){(sum(x)/length(x))*100})
mosaicplot(~ sex + agecategory + survived, data=titanic)

# Training Models
# A) Logistic Regression
# set seed for reproductibility
set.seed(1960)
ncv <- 5
model.lr <- train(survived ~ pclass + sex + agecategory + farecategory, 
                  data = titanic, 
                  method="glm", family="binomial",
                  trControl = trainControl(method = "cv", 
                                           number = ncv) )

summary(model.lr)
confusionMatrix(model.lr)

# B) Random forest algorithm
# set seed for reproductibility
set.seed(1960)
ncv <- 5
model.dt <- train(survived ~ pclass + sex + agecategory + farecategory, 
                  data = titanic, 
                  method =  "rpart",cp=0.002,maxdepth=8
                 
)

summary(model.dt)
fancyRpartPlot(model.dt$finalModel)

# C) Random forest algorithm
# set seed for reproductibility
set.seed(1960)
ncv <- 5
model.rf <- train(survived ~ pclass + sex + agecategory + farecategory, 
               data = titanic, 
               method = "rf",
               trControl = trainControl(method = "cv", 
                                        number = ncv) )

summary(model.rf)
confusionMatrix(model.rf)

