tabPanelAbout<-function(){
  tabPanel("About",
           HTML('
                <p style="text-align:justify"> "This R Shiny web app allows the user to perform basic exploratory analysis and test some predictives models (decisiontree and random forrest).
        The simulated data, one of many version you can find on the net, is not the one from Kaggle s Titanic challenge, but come from the site 
                http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.xls. It is inspired on Trevor Stephens R tutorial, which  you can find at
                http://trevorstephens.com/post/72916401642/titanic-getting-started-with-r.Currently, features are very limited. "</p>
                
                <p style="text-align:justify"> According to Wikipedia :"RMS Titanic was a British passenger liner that sank in the North Atlantic Ocean in the early morning of 15 April 1912, 
after colliding with an iceberg during her maiden voyage from Southampton to New York City. Of the 2,224 passengers and crew aboard, 
                more than 1,500 died in the sinking, making it one of the deadliest commercial peacetime maritime disasters in modern history." </p>'),
           
           HTML('
                <div style="clear: left;"><img src="http://img1.mxstatic.com/wallpapers/381dad49c6c4d19ec1d4503f44d60f5a_large.jpeg" alt="" style="float: left; margin-right:5px" /></div>
                '
           
          
           ),
           value="about"
           )
}



