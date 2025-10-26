# Load required packages
library(readr)
library(dplyr)
library(caret)

print("Packages loaded successfully.")

# Load the training data
print("Loading training data...")
train_data <- read_csv("data/train.csv")
print(paste("Training records loaded:", nrow(train_data)))

# Preview structure
print("Training data columns:")
print(names(train_data))

# Select basic features
print("Selecting key features: Survived, Pclass, Sex, Age, SibSp, Parch, Fare...")
train_data <- train_data %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare)

# Handle missing values
print("Filling missing Age values with median...")
train_data$Age[is.na(train_data$Age)] <- median(train_data$Age, na.rm = TRUE)

print("Encoding Sex as a factor...")
train_data$Sex <- factor(train_data$Sex, levels = c("male", "female"))

# Convert Survived to factor for classification
train_data$Survived <- factor(train_data$Survived)

print("Data preprocessing complete.")

# Build logistic regression model
print("Training logistic regression model...")
model <- train(Survived ~ ., 
               data = train_data, 
               method = "glm", 
               family = "binomial")

print("Model training complete.")
print("Model summary:")
print(summary(model))

# Training accuracy
train_predictions <- predict(model, train_data)
train_accuracy <- mean(train_predictions == train_data$Survived)
print(paste("Training Accuracy:", round(train_accuracy, 4)))

# Load test dataset
print("Loading test dataset...")
test_data <- read_csv("data/test.csv")
print(paste("Test records loaded:", nrow(test_data)))

# Select same features
print("Selecting matching features in test set...")
test_data <- test_data %>%
  select(Pclass, Sex, Age, SibSp, Parch, Fare)

# Handle missing Age values in test set
print("Filling missing Age values in test set...")
test_data$Age[is.na(test_data$Age)] <- median(test_data$Age, na.rm = TRUE)

print("Encoding Sex as a factor in test set...")
test_data$Sex <- factor(test_data$Sex, levels = c("male", "female"))

print("Predicting test survivability...")
test_predictions <- predict(model, test_data)

print("Prediction complete.")
print("First 10 test predictions:")
print(head(test_predictions, 10))

print("Script finished successfully!")