# Let's Build a Much Improved Version of the Initial Beginner Model with Kaggle Tutorial
# https://www.kaggle.com/hiteshp/head-start-for-data-scientist

# Set-up the Working Directory
setwd("~/dev/r/R_DataScience/titanic")

# Install all the required libraries 
install.packages(c("tidyverse", "forcats", "stringr", "caTools", "DT",
                   "data.table", "pander", "ggplot2", "scales", "grid",
                   "gridExtra", "corrplot", "VIM", "knitr", "vcd", "caret",
                   "xgboost", "MLmetrics", "randomForest", "rpart", "rpart.plot",
                   "car", "e1071", "ROCR", "pROC", "glmnet"))

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