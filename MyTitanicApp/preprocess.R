titanic<- read.csv("data/titanic3.csv", sep=";", stringsAsFactors=FALSE)
str(titanic)
if (dim(titanic)[1]> 1309) titanic <-titanic[1:1309,]

names(titanic)<-tolower(names(titanic))

titanic$survived<- as.factor(titanic$survived)
titanic$pclass<- as.factor(titanic$pclass)
titanic$age<- as.numeric(gsub(",",".",titanic$age))
titanic$fare<- as.numeric(gsub(",",".",titanic$fare))


titanic$age[is.na(titanic$age)] <- median(titanic$age,na.rm = TRUE)
titanic$fare[is.na(titanic$fare)] <-mean(titanic$fare,na.rm = TRUE)
titanic$embarked[which(titanic$embarked == '')]<-"S"
titanic$embarked<-factor(titanic$embarked)






# Processing generics Titles
titanic$name = as.character(titanic$name)
titanic$title<-sapply(titanic$name, FUN=function(x){strsplit(x, split='[,.]')[[1]][2]})
titanic$title<-sub(' ', '', titanic$title)
titanic$title[titanic$title=='Mlle']<-'Miss'
titanic$title[titanic$title %in% c('Mme', 'Ms')]<-'Mrs'
titanic$title[titanic$title %in% c('Capt', 'Don', 'Major', 'Sir')]<-'Sir'
titanic$title[titanic$title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')]<-'Lady'
titanic$title<-factor(titanic$title)

# Computing family size
titanic$familysize <-titanic$sibsp+titanic$parch

# Creating a family id

titanic$familyid<-as.factor(paste(sapply(titanic$name, FUN=function(x){strsplit(x, split='[,.]')[[1]][1]}),as.character(titanic$familysize), sep="_"))


# Creating a family id

titanic$familyname<-as.factor(sapply(titanic$name, FUN=function(x){strsplit(x, split='[,.]')[[1]][1]}))


# Creating age categories
titanic$agecategory = cut(titanic$age, breaks=c(0,21,39,80),labels=c("Child","Adult","Senior"))

# Creating fare categories
titanic$farecategory = cut(titanic$age, breaks=c(0,10,20,30,40,513))





