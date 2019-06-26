# Classification Trees using rpart

library(dplyr)
library(rpart) # for decision trees
library(caret)
library(irr)

#Tree plotting
library(rattle)
library(rpart.plot)
library(RColorBrewer)


#load  dataset

setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 5")
health <- read.csv("Patient Data.csv", header = T)
health

str(health)
summary(health)
dim(health)

# Target variable is heart failure - 1 means heart failure
# will happen

table(health$HEARTFAILURE)

colSums(is.na(health))

# No missing values

# Recursive Partitioning and Regression Trees

?rpart

fit <- rpart(HEARTFAILURE ~ ., 
             data = health,
             method = "class", # class for classification Tree
             control=rpart.control(cp = 0.002, maxdepth = 3 ),
             parms = list(split="gini"))

# Any split which does not improve the fit, for example
# gini, by complexity paramter,cp, is likely to be 
# pruned off or is not attempted

# parms is a list of algorithms to be used 

# The splitting index can be gini or Entropy in R.
# Gini Method is the default method 
# split = "information" for Information gain


plot(fit, margin=0.1, main = "Classification tree for health")
text(fit, use.n = TRUE, all = TRUE, cex = 0.7)

# use.n = true prints the numbers
#cex is character expansion factor for character size
# all = True labels all the nodes, not just the terminal ones


#Prettier way of plotting tree

fancyRpartPlot(fit, main="Decision Tree")

fit

# Terminal nodes are 8,9,5,6,14 and 15
  
# Rule # 1: If family history = N and BMI < 32.5 and average 
# AVGHEARTBEATSPERMIN< 129.5 then there is
# 92% probability that there will be no heart failure

# Confusion Matrix

actual<-health$HEARTFAILURE
predicted<-predict(fit,type = "class")

head(predicted)

confusionMatrix(as.factor(actual),predicted,positive="1")

#Accuracy is 86%

library(ROCR)
#AUC

?prediction
pred<-prediction(actual, as.integer(predicted))
perf<-performance(pred,"tpr","fpr")
plot(perf,col="red")
abline(0,1, lty = 8, col = "grey")

auc<-performance(pred,"auc")
unlist(auc@y.values)
