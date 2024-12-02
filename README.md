# Crime Prediction with Random Forest:Improving Law Enforcement with Data

## Description

The project focuses on using the Random Forest algorithm to predict different crime types based on features such as the relationship between offender and victim, location of the crime, age group, and police area. The goal is to assist law enforcement in identifying crime patterns, allocating resources effectively, and supporting investigations with data-driven predictions.

---

## Objective

- To build a machine learning model for classifying crimes into categories like "Theft" or "Assault."
- To analyze the importance of features in predicting crime types.
- To evaluate the model's performance and identify areas for improvement.

---

## Tools and Libraries

- **Programming Language**: R
- **Libraries Used**:
  - `dplyr`: For data manipulation.
  - `randomForest`: To build the Random Forest model.
  - `caret`: For data splitting and confusion matrix.
  - `knitr`: For creating formatted tables.
  - `ggplot2`: For visualizing data and model outputs.

---

## Key Functions Used

- `randomForest()`: To train the Random Forest model with specific parameters.
- `createDataPartition()`: To split the dataset into training and testing sets.
- `confusionMatrix()`: To evaluate the model's performance.
- `varImpPlot()`: To visualize feature importance.
- `na.omit()`: To remove rows with missing values.
- `kable()`: To create well-formatted tables for presenting results.
- `ggplot()`: To visualize the confusion matrix as a heatmap.

---

## Tasks Completed

1. **Data Preparation**:
   - Loaded and cleaned the dataset.
   - Converted relevant columns to categorical variables.
   - Split the data into training (70%) and testing (30%) sets.

2. **Model Building**:
   - Trained a Random Forest model using key features.
   - Configured the model with 30 trees and 3 random features per split.

3. **Evaluation**:
   - Assessed model accuracy, Kappa, and confidence intervals using a confusion matrix.
   - Visualized feature importance and model errors.

4. **Visualization**:
   - Created a heatmap to represent the confusion matrix.
   - Plotted the importance of features in the Random Forest model.

---

## Output

- **Model Summary**: Provided details about the Random Forest, including feature importance and error rates.
- **Confusion Matrix**: A heatmap showing correct predictions and misclassifications.
- **Performance Statistics**: Metrics such as accuracy (72.5%), No Information Rate (47%), and Kappa (0.555).
- **Feature Importance**: Visualization highlighting key predictors like `LocationType` and `ROVDivision`.

---

## Key Findings

- The model achieved an accuracy of **72.5%**, which is significantly better than the baseline (No Information Rate) of 47%.
- **`LocationType`** was identified as the most important feature for predicting crime types, followed by `ROVDivision` and `AgeGroup`.
- The model struggled to distinguish between certain similar crime types, suggesting the need for further tuning and additional features.
- The small p-value confirms that the model's accuracy is statistically significant and not due to random guessing.
- Insights from the model can support law enforcement in allocating resources, identifying high-risk areas, and assisting investigations.

---

This structured approach demonstrates how machine learning can be effectively applied to real-world problems like crime prediction.
