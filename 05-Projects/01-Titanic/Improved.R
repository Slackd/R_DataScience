# Let's Build a Much Improved Version of the Initial Beginner Model with Kaggle Tutorial
# https://www.kaggle.com/hiteshp/head-start-for-data-scientist

# Set-up the Working Directory
setwd("~/dev/r/R_DataScience/titanic")

# Install all the required libraries 
install.packages(c("tidyverse", "forcats", "stringr", "caTools", "DT",
                   "data.table", "pander", "ggplot2", "scales", "grid",
                   "gridExtra", "corrplot", "VIM", "knitr", "vcd", "caret",
                   "xgboost", "MLmetrics", "randomForest", "rpart", "rpart.plot",
                   "car", "e1071", "ROCR", "pROC", "glmnet", "alluvial"))

# Data wrangling
library(tidyverse)
library(forcats)
library(stringr)
library(caTools)

# Data assessment/visualizations
library(DT)
library(data.table)
library(pander)
library(ggplot2)
library(scales)
library(grid)
library(alluvial)
library(gridExtra)
library(corrplot)
library(VIM) 
library(knitr)
library(vcd)
library(caret)

# Model

library(xgboost)
library(MLmetrics)
library('randomForest') 
library('rpart')
library('rpart.plot')
library('car')
library('e1071')
library(vcd)
library(ROCR)
library(pROC)
library(VIM)
library(glmnet)

# import the Train an Test Files
train <- read.csv(file = "train.csv", header=TRUE, stringsAsFactors = FALSE)
test <- read.csv(file = "test.csv", header=TRUE, stringsAsFactors = FALSE)

# Join both the datasets
train$set <- "train"
test$set  <- "test"
test$Survived <- NA
full <- rbind(train, test)

# Check Structure & Dimension of Full dataframe
str(full)
dim(full)

# Unique values per column
lapply(full, function(x) length(unique(x))) 

#Check for Missing values
missing_values <- full %>% summarize_all(funs(sum(is.na(.))/n()))
missing_values <- gather(missing_values, key="feature", value="missing_pct")
missing_values %>% 
  ggplot(aes(x=reorder(feature,-missing_pct),y=missing_pct)) +
  geom_bar(stat="identity",fill="red")+
  coord_flip()+theme_bw()

#Useful data quality function for missing values
checkColumn = function(df,colname){
  testData = df[[colname]]
  numMissing = max(sum(is.na(testData)|is.nan(testData)|testData==''),0)

  if (class(testData) == 'numeric' | class(testData) == 'Date' | class(testData) == 'difftime' | class(testData) == 'integer'){
    list('col' = colname,'class' = class(testData), 'num' = length(testData) - numMissing, 'numMissing' = numMissing, 'numInfinite' = sum(is.infinite(testData)), 'avgVal' = mean(testData,na.rm=TRUE), 'minVal' = round(min(testData,na.rm = TRUE)), 'maxVal' = round(max(testData,na.rm = TRUE)))
    
  } else{
    list('col' = colname,'class' = class(testData), 'num' = length(testData) - numMissing, 'numMissing' = numMissing, 'numInfinite' = NA,  'avgVal' = NA, 'minVal' = NA, 'maxVal' = NA)
  }
}

checkAllCols = function(df){
  resDF = data.frame()
  for (colName in names(df)){
    resDF = rbind(resDF,as.data.frame(checkColumn(df=df,colname=colName)))
  }
  resDF
}

datatable(checkAllCols(full), style="bootstrap", class="table-condensed", options = list(dom = 'tp',scrollX = TRUE))
miss_pct <- map_dbl(full, function(x) { round((sum(is.na(x)) / length(x)) * 100, 1) })

miss_pct <- miss_pct[miss_pct > 0]

data.frame(miss=miss_pct, var=names(miss_pct), row.names=NULL) %>%
  ggplot(aes(x=reorder(var, -miss), y=miss)) + 
  geom_bar(stat='identity', fill='red') +
  labs(x='', y='% missing', title='Percent missing data by feature') +
  theme(axis.text.x=element_text(angle=90, hjust=1))

# Feature Engnr.

# Age as groups with their medians
full <- full %>%
  
  mutate(
    Age = ifelse(is.na(Age), mean(full$Age, na.rm=TRUE), Age),
    `Age Group` = case_when(Age < 13 ~ "Age.0012", 
                            
                            Age >= 13 & Age < 18 ~ "Age.1317",
                            Age >= 18 & Age < 60 ~ "Age.1859",
                            Age >= 60 ~ "Age.60Ov"))
# Embarked as Mode 
full$Embarked <- replace(full$Embarked, which(is.na(full$Embarked)), 'S')

# Data Fitting
# Names
names <- full$Name
title <-  gsub("^.*, (.*?)\\..*$", "\\1", names)
full$title <- title
table(title)

# MISS, Mrs, Master and Mr are taking more numbers
# Better to group Other titles into bigger basket by checking gender and survival rate to aviod any overfitting

full$title[full$title == 'Mlle'] <- 'Miss' 
full$title[full$title == 'Ms'] <- 'Miss'
full$title[full$title == 'Mme'] <- 'Mrs' 
full$title[full$title == 'Lady'] <- 'Miss'
full$title[full$title == 'Dona'] <- 'Miss'

## I am afraid creating a new varible with small data can causes a overfit
## However, My thinking is that combining below feauter into original variable may loss some predictive power as they are all army folks, doctor and nobel peoples 
full$title[full$title == 'Capt'] <- 'Officer' 
full$title[full$title == 'Col'] <- 'Officer' 
full$title[full$title == 'Major'] <- 'Officer'
full$title[full$title == 'Dr']  <- 'Officer'
full$title[full$title == 'Rev'] <- 'Officer'
full$title[full$title == 'Don'] <- 'Officer'
full$title[full$title == 'Sir'] <- 'Officer'
full$title[full$title == 'the Countess'] <- 'Officer'
full$title[full$title == 'Jonkheer'] <- 'Officer'  

# Family Groups
full$FamilySize <-full$SibSp + full$Parch + 1 
full$FamilySized[full$FamilySize == 1] <- 'Single' 
full$FamilySized[full$FamilySize < 5 & full$FamilySize >= 2] <- 'Small' 
full$FamilySized[full$FamilySize >= 5] <- 'Big' 
full$FamilySized=as.factor(full$FamilySized)

##Engineer features based on all the passengers with the same ticket

ticket.unique <- rep(0, nrow(full))
tickets <- unique(full$Ticket)

for (i in 1:length(tickets)) {
  current.ticket <- tickets[i]
  party.indexes <- which(full$Ticket == current.ticket)

  for (k in 1:length(party.indexes)) {
    ticket.unique[party.indexes[k]] <- length(party.indexes)
  }
}

full$ticket.unique <- ticket.unique

full$ticket.size[full$ticket.unique == 1]   <- 'Single'
full$ticket.size[full$ticket.unique < 5 & full$ticket.unique>= 2]   <- 'Small'
full$ticket.size[full$ticket.unique >= 5]   <- 'Big'

# Test
# The independent variable, Survived, is labeled as a Bernoulli trial where a passenger or crew member surviving is encoded with the value of 1. Among observations in the train set, approximately 38% of passengers and crew survived.

full <- full %>%
  
  mutate(Survived = case_when(Survived==1 ~ "Yes", 
                              
                              Survived==0 ~ "No"))

crude_summary <- full %>%
  filter(set=="train") %>%
  select(PassengerId, Survived) %>%
  group_by(Survived) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

crude_survrate <- crude_summary$freq[crude_summary$Survived=="Yes"]
kable(crude_summary, caption="2x2 Contingency Table on Survival.", format="markdown")

# Survival Exploratory Research
# Correlation Plot
tbl_corr <- full %>%
  
  filter(set=="train") %>%
  select(-PassengerId, -SibSp, -Parch) %>%
  select_if(is.numeric) %>%
  cor(use="complete.obs") %>%
  corrplot.mixed(tl.cex=0.85)

# Mosaic Plot
tbl_mosaic <- full %>%
  filter(set=="train") %>%
  select(Survived, Pclass, Sex, AgeGroup=`Age Group`, title, Embarked, `FamilySize`) %>%
  mutate_all(as.factor)
mosaic(~Pclass+Sex+Survived, data=tbl_mosaic, shade=TRUE, legend=TRUE)


# Alluvial Diagram
library(alluvial)

tbl_summary <- full %>%
  filter(set=="train") %>%
  group_by(Survived, Sex, Pclass, `Age Group`, title) %>%
  summarise(N = n()) %>% 
  ungroup %>%
  na.omit

alluvial(tbl_summary[, c(1:4)],
         freq=tbl_summary$N, border=NA,
         col=ifelse(tbl_summary$Survived == "Yes", "blue", "gray"),
         cex=0.65,
         ordering = list(
           order(tbl_summary$Survived, tbl_summary$Pclass==1),
           order(tbl_summary$Sex, tbl_summary$Pclass==1),
           NULL,
           NULL))

# Code for ML Algos
###lets prepare and keep data in the proper format

feauter1<-full[1:891, c("Pclass", "title","Sex","Embarked","FamilySized","ticket.size")]
response <- as.factor(train$Survived)
feauter1$Survived=as.factor(train$Survived)

###For Cross validation purpose will keep 20% of data aside from my orginal train set
##This is just to check how well my data works for unseen data

set.seed(500)
ind=createDataPartition(feauter1$Survived,times=1,p=0.8,list=FALSE)
train_val=feauter1[ind,]
test_val=feauter1[-ind,]

round(prop.table(table(train$Survived)*100),digits = 1)

# Models

set.seed(1234)

Model_DT=rpart(Survived~.,data=train_val,method="class")

rpart.plot(Model_DT,extra =  3,fallen.leaves = T)


