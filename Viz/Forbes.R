setwd("~/dev/r/Viz")

install.packages("XML")

library(XML)
library(dplyr)


MyURL<-"~/dev/r/Viz/forbes.html"

forbes<-readHTMLTable(MyURL, stringsAsFactors = FALSE, which = 1)

str(forbes)

class(forbes)
unique(forbes$Industry)

count(forbes %>%
        select(Industry) %>%
        filter(Industry == "Automotive"))

is.na(forbes)

sum(is.na(forbes$`Company Advertising`))

summary(forbes)
