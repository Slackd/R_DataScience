setwd("C:/Users/budhadis/Downloads/R_DataScience/05-Projects/02-Forbes")


install.packages("XML")

library(XML)

MyURL = "C:/Users/budhadis/Downloads/R_DataScience/assets/web/forbes.html"

forbes<-readHTMLTable(MyURL, which = 1, stringsAsFactors = FALSE, colClasses = c("character", "character", "character", "character", "character", "character", "character", "factor") )
class(forbes)


str(forbes)

summary(forbes)
