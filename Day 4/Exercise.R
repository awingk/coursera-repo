# Loading the dataset
setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 4")
data <- read.csv("membership.csv")

#rm(list = ls())

# Data Exploration
str(data)

# Data Preprocessing Steps
# NA values in Marital, Gender, Occupation
# Outliers is Annual Income
# Impute Marital, gender by "Missing"
# Remove missing values in Occupation
## Impute outliers first so that you'll get a normal mean.
# Impute outliers in Annual Fee, Annual Income
# Impute missing values in Annual Income
# Create target 1/0 -> 1 means Cancelled.







