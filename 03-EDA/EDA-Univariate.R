# Exploratory Data Analysis (EDA)
# Library Calls ----
library(dplyr)

# Set Working Directory ----
setwd("~/dev/R_DataScience/03-EDA") # For mac
setwd("C:/Users/budhadis/Downloads/R_DataScience/03-EDA") # For windows


# Load the file to do an EDA on ----
# The file format is csv.

# Variable declaration for the file ----
bike<-"C:/Users/budhadis/Downloads/R_DataScience/assets/csv/bike_buyers.csv"

bike_buyers<-read.csv(bike)

# Univariate Analysis ----
# Data Structures

bike_buyers <- read.csv("../assets/csv/bike_buyers.csv")

# Basic Data Integrity Check ----
dim(bike_buyers) # We can see that there are 13 rows and 1000 observations.
str(bike_buyers) # We can see the structure of the data. Appears to have been correctly imported. May need to check some more...

summary(bike_buyers) # Do we need ID column? 
summary(bike_buyers$Children) # Maybe a problem with the column as mean is 1.98?
bike_buyers<-select(bike_buyers, -ID) # Remove the ID column

# Change some variables from continious to categorical variables
bike_buyers$Children<-as.factor(bike_buyers$Children)
bike_buyers$Cars<-as.factor(bike_buyers$Cars)

# Basic Plots to Viz the data at hand ----

### Univariate Analysis ----

# Income, Discrete Variable ----
hist(bike_buyers$Income)
plot(density(bike_buyers$Income), main="Spread of Income")
boxplot(bike_buyers$Income)

# Marital Status, Discrete Variable ----
summary(bike_buyers$Marital.Status)
plot(bike_buyers$Marital.Status)

# Gender Status, Discrete Variable ----
summary(bike_buyers$Gender)
plot(bike_buyers$Gender)

# Children, Discrete Variable ----
summary(bike_buyers$Children)
plot(bike_buyers$Children)

# Let's look at the number of people who bought vs. who had children and others. This might give
# us and idea of why the people bought and a cleaner idea.

bought<-filter(bike_buyers, Purchased.Bike == "Yes")
plot(bought$Children)
plot(bought$Marital.Status)
plot(bought$Gender)
plot(bought$Occupation)
plot(bought$Home.Owner)
plot(bought$Cars)

### Multivariate Analysis ----
library(dplyr)

by(bike_buyers$Income, bike_buyers$Education, summary)
by(bike_buyers$Income, bike_buyers$Education, mean)
by(bike_buyers$Income, bike_buyers$Education, median)

boxplot(bike_buyers$Income~bike_buyers$Education, notch = TRUE, main = "Income Distribution among Edu Levels", col = "grey")


