# Load required packages
library(readr)
library(dplyr)
library(caret)

cat("Packages loaded successfully.\n")

# Load the training data
cat("Loading training data...\n")
train_data <- read_csv("data/train.csv")
cat(paste("Training records loaded:", nrow(train_data), "\n"))

# Preserve PassengerId? Not needed for training
# Select basic features
cat("Selecting key features: Survived, Pclass, Sex, Age, SibSp, Parch, Fare...\n")
train_data <- train_data %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare)

# Handle missing values
cat("Handling missing Age values...\n")
train_data$Age[is.na(train_data$Age)] <- median(train_data$Age, na.rm = TRUE)

# Encode categorical variables
train_data$Sex <- factor(train_data$Sex, levels = c("male", "female"))

# Convert Survived to factor for classification
train_data$Survived <- factor(train_data$Survived)

cat("Training logistic regression model...\n")
model <- train(
  Survived ~ .,
  data = train_data,
  method = "glm",
  family = "binomial"
)

cat("Model training complete.\n")

# Load test dataset
cat("Loading test dataset...\n")
test_data <- read_csv("data/test.csv")
cat(paste("Test records loaded:", nrow(test_data), "\n"))

# Store PassengerId for output
passenger_ids <- test_data$PassengerId

# Select same predictor features as training
test_data <- test_data %>%
  select(Pclass, Sex, Age, SibSp, Parch, Fare)

# Handle missing values in test set
test_data$Age[is.na(test_data$Age)] <- median(test_data$Age, na.rm = TRUE)
test_data$Fare[is.na(test_data$Fare)] <- median(test_data$Fare, na.rm = TRUE)
test_data$Sex <- factor(test_data$Sex, levels = c("male", "female"))

# Generate predictions
cat("Generating predictions...\n")
test_pred <- predict(model, newdata = test_data, type = "raw")

# Convert factor predictions to numeric (0 or 1)
test_pred_num <- ifelse(test_pred == "1", 1, 0)

# Save predictions to CSV
output <- data.frame(
  PassengerId = passenger_ids,
  Survived = test_pred_num
)

output_file <- "R_predictions_test.csv"
write_csv(output, output_file)

cat(paste("Predictions saved to", output_file, "\n"))