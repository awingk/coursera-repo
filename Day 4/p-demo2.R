#-------Importing the data---------
setwd("C:\\Users\\avinash17.singh\\Documents\\Corporate Training - Advanced Machine Learning with R\\Day 4")
hr<-read.csv("HR dataset for Employee Attrition.csv")

# Data Exploration

dim(hr)
str(hr)
View(hr)

# Convert Attrition to numeric variable

hr$AttritionTarget <- as.numeric(hr$Attrition)-1 # NO is 1 yes is 2 so encoding vars
View(hr)

# What is the ratio of Attrited vs. not Attritted?

# Frequency Distribution of the binary dependent variable 

table(hr$AttritionTarget)
table(hr$AttritionTarget)/nrow(hr)

#Checking for missing values in all the columns

colSums(is.na(hr))

# No missing values

# Partition the dataset into training and validation dataset

sampling<-sort(sample(nrow(hr), nrow(hr)*.7))

length(sampling)

#Row subset and create training and validation samples using the index numbers

train<-hr[sampling,]
dim(train)
test<-hr[-sampling,]
dim(test)
nrow(train)
nrow(test)

# Checking the frequency Distribution of the target variable 

table(train$AttritionTarget)
table(train$AttritionTarget)/nrow(train)
table(test$AttritionTarget)/nrow(test)

#Renaming Age column

colnames(train)
names(train)[1] <- "Age"
colnames(train)
names(test)[1] <- "Age"

#Are any of the independent variables correlated?


#Finding correlation between numeric variables 

str(train)
traincor<-cor(train[,c(1,4,6,7,11,13,14,15,17,19,20,21,24,25,26,28:35)])
class(traincor)
traincor

library(corrgram)
?corrgram
cormat<-corrgram(traincor)

write.csv(cormat,"Correlation.csv")

# After Conditional formatting, we find :
# High correlation between:
# Job Level and Monthly Income *
# Job Level and Total Working Years *
# Monthly Income and Total Working Years *
# Percent Salary Hike and Performance Rating *

str(train)
colnames(train)

?glm()
# Family of dependent variable is binary or binomial 
myresult<-glm(data=train,AttritionTarget ~ Age+BusinessTravel+
                +DailyRate+Department+DistanceFromHome+Education+
                EnvironmentSatisfaction+Gender+HourlyRate+JobInvolvement+
                JobSatisfaction+MaritalStatus+MonthlyIncome+MonthlyRate+
                NumCompaniesWorked+OverTime+PercentSalaryHike+
                RelationshipSatisfaction+StandardHours+StockOptionLevel+
                TrainingTimesLastYear+WorkLifeBalance+YearsAtCompany+
                YearsInCurrentRole+YearsSinceLastPromotion+YearsWithCurrManager,family=binomial)

summary(myresult)

#Gives best fitted model
#To choose a good model

?step
reduced<-step(myresult,direction="backward")


# Iteration 2: 
myresult<-glm(data=train,AttritionTarget ~ Age + BusinessTravel + Department + DistanceFromHome + 
                EnvironmentSatisfaction + Gender + JobInvolvement + JobSatisfaction + 
                MaritalStatus + MonthlyIncome + NumCompaniesWorked + OverTime + 
                RelationshipSatisfaction + StockOptionLevel + TrainingTimesLastYear + 
                WorkLifeBalance + YearsInCurrentRole + YearsSinceLastPromotion + 
                YearsWithCurrManager,family=binomial)

summary(myresult)

# Creating dummy variables for significant vars; check summary for that | > 3 stars
# dummy values is encoding string values to 0,1,2.....

train$BTF <- ifelse(train$BusinessTravel == "Travel_Frequently",1,0)
train$OTY <- ifelse(train$OverTime == "Yes",1,0)

# Creating dummy variables for testing dataset

test$BTF <- ifelse(test$BusinessTravel == "Travel_Frequently",1,0)
test$OTY <- ifelse(test$OverTime == "Yes",1,0)

#Iteration # 3 (Retain significant variables)


myresult<-glm(data=train,AttritionTarget ~ BTF + EnvironmentSatisfaction + JobInvolvement + 
                JobSatisfaction + MonthlyIncome + OTY + 
                YearsSinceLastPromotion,family=binomial)

summary(myresult)

# Iteration # 4

myresult<-glm(data=train,AttritionTarget ~ EnvironmentSatisfaction + JobInvolvement + 
                JobSatisfaction + MonthlyIncome +  
                OTY,family=binomial)

summary(myresult)

#Finding Predicted Values

?glm

myresult$fitted.values

# here fitted vaules give predicted values
train$predicted <- myresult$fitted.values
train$predicted

#Compare with actual data

head(train$AttritionTarget)

head(train$predicted)

# Let us convert the probabilities also into Attrited/Not Attrited
# based on a cut-off probability

#Confusion Matrix
train$predclass<-ifelse(train$predicted>0.5,1,0)
table(train$predclass,train$AttritionTarget)

#True Positive+ True Negative should be high. 

# Accuracy = (TP+TN)/(P+N)

(851+33)/(851+33+132+13)

# For different cutoff probabilities, the confusion matrix will be different

# To find accuracies for different cut-off probabilities

# There are a lot of performance parameters available in ROCR package

#install.packages("ROCR")
library(ROCR)

# to find different accuracy for different threshold

# The prediction function of the ROCR library basically creates 
# a structure to validate our predictions with actual values

pred<-prediction(train$predicted,train$AttritionTarget)
class(pred)


?performance

perf <- performance(pred,"acc")
class(perf)
perf
# x values contain the cut-off probabilities

#use @ to access the slots

perf@x.values
class(perf@x.values)
cutoffprob <- as.numeric(unlist(perf@x.values))

cutoffprob

perf@y.values
class(perf@y.values)
accuracies <- as.numeric(unlist(perf@y.values))
accuracies

cutoffs <- data.frame(cutoffprob, accuracies )
# In the decreasing order of accuracy
cutoffs <- cutoffs[order(cutoffs$accuracies, decreasing=TRUE),]

# Pick cutoff for which Accuracy is highest 

train$predclass <- ifelse(train$predicted>0.51321993,1,0)

table(train$predclass,train$AttritionTarget)

(855+30)/(855+30+135+9)

# Confusion Matrix from caret package

#install.packages("caret")
#install.packages("irr")

library(caret)
library(irr)



confusionMatrix(as.factor(train$AttritionTarget),as.factor(train$predclass), positive = "1")


## computing a simple ROC curve (x-axis: fpr, y-axis: tpr)

#ROC: a plot b/w fpr and tpr.

perf<-performance(pred,"tpr","fpr") #tpr=TP/P fpr=FP/N
plot(perf,col="red")
# Receiver Operating Characteristic Curve (ROC) a plot of TPR versus FPR 
# for the possible cut-off classification probability values.
# A good ROC curve should be almost vertical in the beginning and 
# almost horizontal in the end.
# "tpr" and "fpr" are arguments of the "performance" function 
# indicating that the plot is between the true positive rate and 
# the false positive rate.

?abline
# Draw a straight line with intercept 0 and slope = 1
# lty is the line type (dotted or dashed etc.)
# The straight line is a random chance line
# ROC curve should be higher than the AB line

abline(0,1, lty = 8, col = "blue")


# Area under the curve should be more than 50%

auc<-performance(pred,"auc")
auc

?performance


# To obtain predictions from the model, use the predict() function.

?predict()
test$pred <- predict(myresult, type = "response",newdata = test)


# The value 'response' to the parameter type would make sure 
# that these predictions are returned as probability of events.

