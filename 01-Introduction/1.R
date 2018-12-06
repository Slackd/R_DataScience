# Set Working Directory ----
setwd("C:/Users/budhadis/Downloads/R_DataScience/01-Introduction")

# Package & Library Calls ----
install.packages("dplyr")
install.packages("ggplot2")
install.packages("xlsxjars")
install.packages("rJava")
install.packages("xlsx")
install.packages("arules")
install.packages("lubridate")


library(lubridate)
library(arules)
library(dplyr)
library(ggplot2)
library(rJava)
library(xlsxjars)
library(xlsx)

# Environment Variable Declaration ----
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_191')

data("iris")

head(iris)
summary(iris)
names(iris)

dim(iris)
nrow(iris)
ncol(iris)

tail(iris)
tail(iris)

str(iris)
?iris

class(iris)

summary(iris$Sepal.Length)
attach(iris)
summary(Sepal.Length)

detach(iris)
getwd()

write.csv(iris, file = "iris.csv",  row.names = FALSE)

getwd()

a<-read.xlsx(file = "Book4.xlsx", header=TRUE, colClasses=NA, sheetIndex = 1)


numbers<-c(2,3,5,6,7,10,15,45,76,89)
order(numbers)
num2<-order(-numbers)


class(aggregate(iris$Sepal.Length, by=list(iris$Species), mean))

class(tapply(iris$Sepal.Length,iris$Species,mean))

dat3<-filter(iris,Species == "setosa"| Species == "versicolor")

dat5<-select(iris, Sepal.Length)
rm(list = ls())

dat7<-mutate(iris, colTest=log(Sepal.Length))


dat8<-arrange(iris, desc(Sepal.Length))

iris%>%filter(Sepal.Length>1.0)%>%summarise(mean(Sepal.Length))

iris%>%filter(Species == "setosa")%>%summarise(mean(Sepal.Length))

dat9<-iris%>%filter(Sepal.Length>1.0)


data(AdultUCI)

summary(AdultUCI)

count(AdultUCI %>%
  select(sex, race, age) %>%
  filter(sex == "Female" & race == "Black" & age < 50))




data("lakers")
dim(lakers)

str(lakers)
lakers$date<-date(ymd(lakers$date))

lakers$month<-month(lakers$date, label = TRUE)

lakers$year1<-year(lakers$date)

lakers$dow<-weekdays(as.POSIXct(lakers$date), abbreviate = F)

count(lakers %>%
        select(dow, opponent, player) %>%
        filter(dow == "Sunday" & opponent == "POR" & player == "Pau Gasol"))

count(lakers %>%
        select(opponent, team) %>%
        filter(opponent == "POR" & team == "LAL"))

data("mtcars")
head(mtcars)

str(mtcars)

mtcars$gear<-as.numeric(mtcars$gear)

attach(mtcars)

data(lakers)
dim(lakers)


aggregate(mtcars[1], list(mtcars$gear), mean)


attach(lakers)

lakers$month<-as.character(month)

count(lakers, month)

data("AdultUCI")
str(AdultUCI)


str(AdultUCI$`marital-status`)

count(AdultUCI %>%
        select(age, `marital-status`) %>%
        filter(age == 38 & `marital-status` == "Divorced"))

