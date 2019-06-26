# Case study on Marketing Mix Model (MMX).

setwd("C:\\Users\\avinash17.singh\\Documents\\Corporate Training - Advanced Machine Learning with R\\Day 4")
mmix <- read.csv("simpleotc.csv", header = T, stringsAsFactors = T)

# Data Exploration

dim(mmix)
str(mmix)
View(mmix)

# Data Summaries

# Check for missing values

summary(mmix)

# Data Tabulation

table(mmix$Website.Campaign)
table(mmix$NewspaperInserts)
unique(mmix$Website.Campaign)

# Visualizations

library("ggplot2")

# Univariate visualization

qplot(mmix$NewVolSales)
hist(mmix$NewVolSales)  # positively skewed
hist(mmix$Price) # negatively skewed
hist(mmix$Radio) # negatively skewed
hist(mmix$TV) # Not so skewed

# Bivariate Visualization

qplot(mmix$Price, mmix$NewVolSales)# Negative Correlation
qplot(mmix$Instore, mmix$NewVolSales)# Positive Correlation
qplot(mmix$Radio,mmix$NewVolSales) # No correlation


# Check correlation values

cor(mmix$NewVolSales, mmix$Price)
cor(mmix$NewVolSales, mmix$Radio)
cor(mmix$NewVolSales, mmix$Instore)

library(corrgram)

cormmix <-corrgram(mmix)

cormmix
#cor: how 2 vars are related to each other
write.csv(cormmix,"cormix.csv")

# =======Data Preparation ============

# Check for outliers in the dependent variable

x <- boxplot(mmix$NewVolSales)
x

out <- x$out # the $out will give me the outlier
out

# Remove Outliers from the dependent variable

index <- which(mmix$NewVolSales %in% x$out) # outliers lying in these rows: 3,21,27,......
index
mmixnonout <- mmix[-index,] #removed 6 outliers : 6 rows
dim(mmixnonout)


# Convert categoric to numeric variables or dummy variables

mmixnonout$npi <- as.numeric(mmixnonout$NewspaperInserts)


mmixnonout$npinsert <- ifelse(mmixnonout$NewspaperInserts == "Insert",1,0)
mmixnonout$fb <- ifelse(mmixnonout$Website.Campaign == 'Facebook',1,0)
mmixnonout$tw <- ifelse(mmixnonout$Website.Campaign == 'Twitter',1,0)
mmixnonout$webcamp <- ifelse(trimws(mmixnonout$Website.Campaign) == "Website Campaign",1,0)

View(mmixnonout)

# R Alreday convert strings to numbers internally so encoding to number everytime is not compulsory

# ==== Data Exploration & Preparation ends=====#

# ----------Building the model -----------------#

?lm


# lm function is used to fit linear models. 
# It can be used to carry out regression.

# Sinple Linear Regression


Reg <- lm(NewVolSales ~ Price, data = mmixnonout)
#Y: NewVolSales, X = Price
Reg
# sales = -289633 * price + 98162
summary(Reg)

# Residual is cost function error , J(theta)


# When price is increased by INR 1, NewVolSales decreases by 28633


# Multivariate Linear Regression Iteration # 1

MulReg <- lm(NewVolSales ~ Price+Instore+webcamp, mmixnonout)
MulReg
summary(MulReg) # 
# "+" symbol b/w x vars is syntax.

# Multivariate Linear Regression Iteration # 2

colnames(mmixnonout)
MulReg <- lm(NewVolSales ~ Price+Radio+StockOut.+TV+Instore+Discount
             +npinsert+fb+tw+webcamp, mmixnonout)

# MulReg <- lm(NewVolSales ~ ., mmixnonout)
# INclude all X vars if "."

MulReg
summary(MulReg)

# # Multivariate Linear Regression Iteration # 3

MulReg <- lm(NewVolSales ~ Price+StockOut.+Instore+Discount
             +tw+webcamp, mmixnonout)

MulReg
summary(MulReg)

MulReg$fitted.values # Gives you predicted values.

predsales <- MulReg$fitted.values
predsales
class(predsales)
length(predsales)
head(predsales)
mmixnonout$pred <- predsales

#### Judging the predicted values:
# Fit Chart

qplot(mmixnonout$NewVolSales, mmixnonout$pred) # scatterplt b/w actual & predicted

dat <- data.frame(act = mmixnonout$NewVolSales, est = mmixnonout$pred)

# Creating a blended-axis graph

library(ggplot2)

rnum <- as.numeric(rownames(dat))

head(rnum)

p<-ggplot(dat, aes(x= rnum, y= act))

p+geom_line(color = "blue", size = 1)+geom_line(data = dat, aes(y=est), color="orange", size = 1)


#geom_line: line chart; +geom_line: more charts on same graph
# Checking correlation

cor(dat$act, dat$est)

# Lieaar Regression Model Assumptions

# Checking residuals

mmixnonout$resi <- MulReg$residuals

# Residuals should be normally distributed

summary(mmixnonout$resi)

?hist()

hist(mmixnonout$resi)

library(car)

qqPlot(mmixnonout$resi)


# Residuals should be homoscedastic - no pattern

plot(mmixnonout$resi)
qplot(mmixnonout$pred, mmixnonout$resi)


# There should be no multicollinearity

vif(MulReg) # vif function

#There is no multicollinearity
# Independent variables should not be correlated


# Mean Absolute Percentage Error (MAPE)


mmixnonout$PE <- (abs(mmixnonout$resi)/mmixnonout$NewVolSales)*100

MAPE <- mean(mmixnonout$PE)
MAPE

# rm(list = ls())

#-----Applying the model on another dataset ---------


#-----Training and Test Splits -------------


sampling<-sort(sample(nrow(mmixnonout), nrow(mmixnonout)*.7))
head(sampling)
length(sampling)
#Select training sample
train<-mmixnonout[sampling,]
test<-mmixnonout[-sampling,]
nrow(train)
nrow(test)

predict(MulReg,data=test)

#==========End ==========

# Models can improved using log transform, sqroot/cuberoot transform 
# or combining variable


# Log transformation

mmixnonout$LnSales = log(mmixnonout$NewVolSales)
mmixnonout$LnPrice = log(mmixnonout$Price)

#Combine Variables
mmixnonout$offlineSpend = mmixnonout$Radio+ mmixnonout$TV + mmixnonout$Instore


# Creating Price Buckets

summary(mmixnonout$Price)
mmixnonout$Price_Bkt[mmixnonout$Price <= 2.71] <- 'Low'
mmixnonout$Price_Bkt[mmixnonout$Price > 2.71 & mmixnonout$Price <= 2.732] <- 'Avg'
mmixnonout$Price_Bkt[mmixnonout$Price > 2.732 & mmixnonout$Price <= 2.75] <- 'High'
mmixnonout$Price_Bkt[mmixnonout$Price >  2.75] <- 'Very High'

View(mmixnonout)

str(mmixnonout)



