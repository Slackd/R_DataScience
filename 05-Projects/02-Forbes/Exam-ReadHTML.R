# Set Working Directory ----
setwd("C:/Users/budhadis/Downloads/R_DataScience/05-Projects/02-Forbes")

# Package & Library Calls ----
install.packages("XML")
install.packages("dplyr")
library(XML)
library(dplyr)

# Variable Declaration ----
MyURL = "C:/Users/budhadis/Downloads/R_DataScience/assets/web/forbes.html"

# Import Data from the HTML file ----
forbes<-readHTMLTable(MyURL, which = 1, stringsAsFactors = FALSE, colClasses = c("character", "character", "character", "character", "character", "character", "character", "factor") )
class(forbes)

# Analyse Data Structure ----
str(forbes)
summary(forbes)
