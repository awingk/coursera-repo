# Regression Trees using rpart

library(dplyr)
library(rpart)
library(caret)
library(irr)


#Tree plotting
library(rattle)
library(rpart.plot)
library(RColorBrewer)


#load  dataset

setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 5")
dm <- read.csv("dm.csv", header = T)

#=====Data Exploration =============#

dm

dim(dm)
str(dm)

# Target variable is Amount Spent

summary(dm)


#=============== Data Preparation ============#


colSums(is.na(dm))

#Treating missing values

# Replacing NA values in History column

dm$History <- as.character(dm$History)
dm$History[which(is.na(dm$History))] <- "Missing"

table(dm$History)

dm$History <- as.factor(dm$History)


colSums(is.na(dm))

# No missing values

# Converting Children & Catalogs to Factor variables 

dm$Children <- as.factor(dm$Children)
dm$Catalogs <- as.factor(dm$Catalogs)

str(dm)

# ============= Removing Cust ID column =================#

dm <- dm[,-11]

str(dm)


# Regression Trees

fit <- rpart(AmountSpent ~ ., 
             data = dm,
             method = "anova",
             control=rpart.control(cp = 0.009, maxdepth = 3 ))

plot(fit, margin=0.1, main = "Regression tree for dm")
text(fit, use.n = TRUE, all = TRUE, cex = 0.7)

#Prettier way of plotting tree

fancyRpartPlot(fit, main="Decision Tree")

fit

# Terminal nodes are 4,10,11,6, 14 and 15.
  
# If Salary is less than 31750, then amount spent would be at 
# an average of 387. The number of such people in the dataset is 258
# and constitutes 26% of the entire dataset.

#Population Mean and Std. Deviation of Amount Spent

mean(dm$AmountSpent)
sd(dm$AmountSpent)

(387-1216.77)/961.06
