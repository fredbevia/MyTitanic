Johns Hopkins Developing Data Products Course Project 
=====================================================

Course Project Assignment Requirements:
=======================================

Your Shiny Application

1.  Write a shiny application with associated supporting documentation. The documentation should be thought of as         whatever a user will need to get started using your application.
2.  Deploy the application on Rstudio's shiny server
3.  Share the application link by pasting it into the text box below
4.  Share your server.R and ui.R code on github

The application must include the following:

1.  Some form of input (widget: textbox, radio button, checkbox, ...)
2.  Some operation on the ui input in sever.R
3.  Some reactive output displayed as a result of server calculations
4.  You must also include enough documentation so that a novice user could use your application.
5.  The documentation should be at the Shiny website itself. Do not post to an external link.

The Shiny application in question is entirely up to you. However, if you're having trouble coming up with ideas, you could start from the simple prediction algorithm done in class and build a new algorithm on one of the R datasets packages. Please make the package simple for the end user, so that they don't need a lot of your prerequisite knowledge to evaluate your application. You should emphasize a simple project given the short time frame.  

Description 
============

This is a Shiny Application based on a variant of Kaggle's Titanic dataset that predicts the fate of the passengers aboard the RMS Titanic (for the Histor, follow the link...)
The dataset come from yhe site:
biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.xls
Since it's just for predict and do some basic analysis, the full dataset (1309 passengers) was preferred from the train/test set of kaggle.
So the App present 5 panels.

a) The firts one is just a presentation.
b) The Data  display the dataset
c) the Data Analysis panel  can display several graphs and plots, and you can, via reactivity, select and change the values of the main paraméters
d) the Age & Fare, which are important variables ,display some graphs and stats about theses variables. Again, you can tweak the parameters of the plots.
e) In fine, the Models panel,depending on wether your choices, will plot a nice decision tree, ors the results and the confusion matrix of a random forest model, cross validated (parameter ncv: number of cross-validated samples)

About the Datas
==============================

(Excerpt from http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3info.txt)

NAME:  titanic3
TYPE:  Census
SIZE:  1309 Passengers, 14 Variables

DESCRIPTIVE ABSTRACT: The titanic3 data frame describes the survival
status of individual passengers on the Titanic.  The titanic3 data
frame does not contain information for the crew, but it does contain
actual and estimated ages for almost 80% of the passengers.

SOURCES: Hind, Philip.  "Encyclopedia Titanica."  Online.  Internet.
n.p.  02 Aug 1999.  Avaliable http://atschool.eduweb.co.uk/phind

VARIABLE DESCRIPTIONS:
pclass          Passenger Class
                (1 = 1st; 2 = 2nd; 3 = 3rd)
survival        Survival
                (0 = No; 1 = Yes)
name            Name
sex             Sex
age             Age
sibsp           Number of Siblings/Spouses Aboard
parch           Number of Parents/Children Aboard
ticket          Ticket Number
fare            Passenger Fare
cabin           Cabin
embarked        Port of Embarkation
                (C = Cherbourg; Q = Queenstown; S = Southampton)
boat            Lifeboat
body            Body Identification Number
home.dest       Home/Destination

SPECIAL NOTES:
Pclass is a proxy for socio-economic status (SES)
 1st ~ Upper; 2nd ~ Middle; 3rd ~ Lower

Age is in Years; Fractional if Age less than One (1)
 If the Age is Estimated, it is in the form xx.5

Fare is in Pre-1970 British Pounds (£)
 Conversion Factors:  1£ = 12s = 240d and 1s = 20d

With respect to the family relation variables (i.e. sibsp and parch)
some relations were ignored.  The following are the definitions used
for sibsp and parch.

Sibling:  Brother, Sister, Stepbrother, or Stepsister of Passenger Aboard Titanic
Spouse:   Husband or Wife of Passenger Aboard Titanic (Mistresses and Fiancées Ignored)
Parent:   Mother or Father of Passenger Aboard Titanic
Child:    Son, Daughter, Stepson, or Stepdaughter of Passenger Aboard Titanic

Other family relatives excluded from this study include cousins,
nephews/nieces, aunts/uncles, and in-laws.  Some children travelled
only with a nanny, therefore parch=0 for them.  As well, some
travelled with very close friends or neighbors in a village, however,
the definitions do not support such relations.


Additional Info
===============


These are the files produced for the Developing Data Products final project from Johns Hopkins University.

1. gitHub Repo: https://github.com/fredbevia/MyTitanic                  
    


2.  For more information about the Kaggle Titanic challenge visit:
    https://www.kaggle.com/c/titanic-gettingStarted

3.  For a good tutorial about the Kaggle Titanic challenge :
    http://trevorstephens.com/post/72916401642/titanic-getting-started-with-r





