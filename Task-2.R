# Load necessary libraries
library(dplyr)        # For data manipulation
library(randomForest) # For building Random Forest models
library(caret)        # For splitting data and confusion matrix
library(knitr)        # For creating formatted tables

# Read the dataset
data <- read.csv("data2.csv")

# Convert relevant columns to factors (categorical variables)
data$AgeGroup <- as.factor(data$AgeGroup)
data$LocationType <- as.factor(data$LocationType)
data$ROVDivision <- as.factor(data$ROVDivision)
data$TerritorialAuthority <- as.factor(data$TerritorialAuthority)
data$PersonOrOrganization <- as.factor(data$PersonOrOrganization)
data$AnzsocDivision <- as.factor(data$AnzsocDivision)
data$PoliceArea <- as.factor(data$PoliceArea)

# Check structure of the dataset
str(data)

# Convert the Date column to proper date format
data$Date <- as.Date(data$Date)

# Remove rows with missing values
data_clean <- na.omit(data)

# Split the data into training (70%) and testing (30%) sets
set.seed(123)  # Set seed for reproducibility
trainIndex <- createDataPartition(data_clean$AnzsocDivision, p = 0.7, list = FALSE)
train_data <- data_clean[trainIndex, ]
test_data <- data_clean[-trainIndex, ]

# Train a Random Forest model
rf_model <- randomForest(AnzsocDivision ~ AgeGroup + LocationType + ROVDivision + 
                           PersonOrOrganization + PoliceArea, 
                         data = train_data, 
                         ntree = 30,  # Number of trees
                         mtry = 3,    # Number of features considered at each split
                         importance = TRUE)  # Calculate variable importance

# Print model summary
print(rf_model)

# Plot the Random Forest model error rate as trees are added
plot(rf_model)

# Plot variable importance (how significant each variable is for prediction)
varImpPlot(rf_model)

# Predict on the test dataset
rf_predictions <- predict(rf_model, newdata = test_data)

# Create a confusion matrix to evaluate the model's performance
conf_matrix_rf <- confusionMatrix(rf_predictions, test_data$AnzsocDivision)

# Convert the confusion matrix into a data frame for visualization
conf_matrix_df <- as.data.frame(conf_matrix_rf$table)

# Simplify Prediction labels (if needed)
conf_matrix_df$Prediction <- sapply(strsplit(as.character(conf_matrix_df$Prediction), " "), `[`, 1)

# Visualize the confusion matrix as a heatmap
ggplot(conf_matrix_df, aes(Prediction, Reference)) +
  geom_tile(aes(fill = Freq), colour = "white") +  # Heatmap tiles
  scale_fill_gradient(low = "lightblue", high = "blue") +  # Color scale
  labs(x = "Predicted Class", y = "Actual Class", title = "Confusion Matrix") +
  theme_minimal(base_size = 10) +  # Simple theme
  geom_text(aes(label = Freq), vjust = 1, size = 3) +  # Add frequencies as text
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 10),  # Rotate x-axis labels
        axis.text.y = element_text(size = 8),  # Y-axis label size
        plot.title = element_text(size = 10, hjust = 0.5))  # Centered title

# Extract overall model statistics
overall_stats <- data.frame(
  Statistic = c("Accuracy", "95% CI", "No Information Rate", "P-Value [Acc > NIR]", "Kappa"),
  Value = c(
    round(conf_matrix_rf$overall['Accuracy'], 4),  # Overall accuracy
    paste0("(", round(conf_matrix_rf$overall['AccuracyLower'], 3), ", ", 
           round(conf_matrix_rf$overall['AccuracyUpper'], 3), ")"),  # Confidence interval
    round(conf_matrix_rf$overall['AccuracyNull'], 2),  # No Information Rate
    format.pval(conf_matrix_rf$overall['AccuracyPValue'], digits = 3, scientific = TRUE),  # P-value
    round(conf_matrix_rf$overall['Kappa'], 3)  # Kappa statistic
  )
)

# Display the statistics as a table
kable(overall_stats, caption = "Overall Statistics for the Random Forest Model")

# Print accuracy as a quick check
accuracy <- conf_matrix_rf$overall['Accuracy']
print(paste("Accuracy:", accuracy))
