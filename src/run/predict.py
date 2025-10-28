import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

print("Loading training data...")
train_df = pd.read_csv("src/data/train.csv")

print("Initial training data shape:", train_df.shape)

# Simple preprocessing
print("Handling missing values for Age with median...")
train_df["Age"].fillna(train_df["Age"].median(), inplace=True)

print("Encoding Sex feature as numeric...")
train_df["Sex"] = train_df["Sex"].map({"male": 0, "female": 1})

# Feature selection
features = ["Pclass", "Sex", "Age", "SibSp", "Parch", "Fare"]
print("Dropping rows with missing Fare values...")
train_df.dropna(subset=["Fare"], inplace=True)

X = train_df[features]
y = train_df["Survived"]

# Split training set to evaluate accuracy on held-out portion
print("Splitting training data into train/test subsets...")
X_train, X_valid, y_train, y_valid = train_test_split(X, y, test_size=0.2, random_state=42)

print("Training logistic regression model...")
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

train_predictions = model.predict(X_train)
valid_predictions = model.predict(X_valid)

print("Training accuracy:", accuracy_score(y_train, train_predictions))
print("Validation accuracy:", accuracy_score(y_valid, valid_predictions))

# Predict on provided test.csv
print("Loading test dataset...")
test_df = pd.read_csv("src/data/test.csv")

print("Handling missing values for Age and Fare in test data...")
test_df["Age"].fillna(train_df["Age"].median(), inplace=True)
test_df["Fare"].fillna(train_df["Fare"].median(), inplace=True)
test_df["Sex"] = test_df["Sex"].map({"male": 0, "female": 1})

X_test = test_df[features]

print("Generating predictions on test set...")
test_df["Survived_Prediction"] = model.predict(X_test)

output_file = "python_predictions_test.csv"
test_df[["PassengerId", "Survived_Prediction"]].to_csv(output_file, index=False)

print(f"Predictions saved to {output_file}")