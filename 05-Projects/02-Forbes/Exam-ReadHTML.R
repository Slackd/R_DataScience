#### Code for Assignment on Jigsaw Academy ####
### Smart Certificate - Case study - R for Data Science
### Submitting as a proxy to the quiz, as per support recommendation


# Set Working Directory ----
# Unable to access JLC Lab HTML file, download the same file from the website and using that.
# There are no changes in the structure of the file. (Amswers may differ a bit because of new updates)
setwd("C:/Users/budhadis/Downloads/R_DataScience/05-Projects/02-Forbes")

# Package & Library Calls ----
install.packages("XML")
install.packages("dplyr")
library(XML)
library(dplyr)

# Variable Declaration ----
MyURL = "C:/Users/budhadis/Downloads/R_DataScience/assets/web/forbes.html"

# Import Data from the HTML file ----
# Importing the same as a data frame directly with specific col classes
forbes<-readHTMLTable(MyURL, which = 1, stringsAsFactors = FALSE, colClasses = c("character", "character", "character", "character", "character", "character", "character", "factor") )

# Analyse Data Structure ----
str(forbes)
summary(forbes)

### Question 1
class(forbes)

### Question 2
dim(forbes)

### Question 3
ncol(forbes)

### Question 4
str(forbes)

### Question 5
class(forbes$`Brand Value`)

### Question 6
unique(forbes$Industry)

### Question 7
count(forbes %>%
        select(Industry) %>%
        filter(Industry == "Automotive"))

### Question 8
g<-grep("M", forbes$`Company Advertising`)
length(g)

### Question 9
sum(is.na(forbes$`Company Advertising`))

### Question 10
colSums(is.na(forbes))
cx<-forbes[complete.cases(forbes), ]
colSums(is.na(cx))

### Question 11
View(cx$`Company Advertising`)
a<-gsub("[A-Z]", "", cx$`Company Advertising`)
a<-gsub("[\\$]", "",a)
d<-as.numeric(a)
round(mean(d, na.rm = TRUE), 2)

### Question 12
View(cx$`Brand Value`)
b<-gsub("[A-Z]", "", cx$`Brand Value`)
b<-gsub("[\\$]", "", b)
c<-as.numeric(b)
round(mean(c), 2)

