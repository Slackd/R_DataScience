# Set Working directory
setwd("~/dev/r/titanic")

# Read in the files
titanic.train <- read.csv(file = "train.csv", header=TRUE, stringsAsFactors = FALSE)
titanic.test <- read.csv(file = "test.csv", header=TRUE, stringsAsFactors = FALSE)

# Differentiate before combining at the later stage
titanic.train$IsTrainSet <- TRUE
titanic.test$IsTrainSet <- FALSE

# Fill Test File Survived Col with NA values
titanic.test$Survived <- NA

# Combine
titanic.full <- rbind(titanic.train, titanic.test)

## Cleaning Missing Values
# Clean Embarked with the mode of the dataset object Embarked
titanic.full[titanic.full$Embarked=='', "Embarked"] <- 'S'

# Use Median to fill the Ages
age.median <- median(titanic.full$Age, na.rm = TRUE)
titanic.full[(is.na(titanic.full$Age)), "Age"] <- age.median

# Use Median to fill the Fares
fare.median <- median(titanic.full$Fare, na.rm = TRUE)
titanic.full[(is.na(titanic.full$Fare)), "Fare"] <- fare.median

# Casting into categories
titanic.full$Pclass <- as.factor(titanic.full$Pclass)
titanic.full$Sex <- as.factor(titanic.full$Sex)
titanic.full$Embarked <- as.factor(titanic.full$Embarked)


# Split out the training and test set after they are cleaned
titanic.train<-titanic.full[titanic.full$IsTrainSet==TRUE,]
titanic.test<-titanic.full[titanic.full$IsTrainSet==FALSE,]

# Convert into factors for train set, the Survived Column.
titanic.train$Survived <- as.factor(titanic.train$Survived)

# Build a formula for RandomForest

survived.equation <- "Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
survived.formula <- as.formula(survived.equation)

# Install RandomForest Package
install.packages("randomForest")
# Import the Random Forest Libs
library(randomForest)

# Build the Model
titanic.model <- randomForest(formula = survived.formula, data = titanic.train, ntree = 500, mtry = 3, nodesize = 0.01 * nrow(titanic.train))

# Build the features for predict function
features.equation <- "Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"

# Predict Function 
Survived <- predict(titanic.model, newdata = titanic.test)


# Ready to write out the new csv with the predictions
PassengerId <- titanic.test$PassengerId
output.df <- as.data.frame(PassengerId)
output.df$Survived <- Survived

write.csv(output.df, file = "kaggle_submission.csv", row.names = FALSE)
