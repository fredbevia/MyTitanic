# Load Libraries

pkgs<-c("shiny",
        "randomForest",
        "Rook",
        "rpart",
        "rattle",
        "rpart.plot",
        "RColorBrewer",
        "ggplot2",
        "gridExtra",
        "dplyr",
        "Amelia",
        "caret"
        )
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(char=pkgs)










