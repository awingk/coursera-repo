# Using Base Graphics
# Bivariate Scatter Plots


personid <- c(1,2,3,4,5)
personwt <- c(30,40,45,52,61)
person <- data.frame(personid,personwt)
plot(person)

data("iris")
str(iris)
?plot
plot(x = iris$Petal.Length,y = iris$Petal.Width, 
     main = c("Petal Length vs Petal Width"),
     xlab = c("Length of Petal"), 
     ylab = c("Width of Petal"), 
     col = "red", pch = 3, lwd = 5)

# Factor variables on x axis

unique(iris$Species)

plot(x = iris$Species,y = iris$Petal.Width,  
     main = c("Species vs Petal Width"),
     xlab = c("Species"), 
     ylab = c("Width of Petal"), 
     col = "red", pch = 2, lwd = 2 )

# Conditional Bivariate Analysis
# Scatter Plots

windows(width=10, height=8)

plot(x = iris$Petal.Length,y = iris$Petal.Width, 
     main = c("Petal Length vs Petal Width"),
     xlab = c("Length of Petal"), 
     ylab = c("Width of Petal"), 
     col = iris$Species, pch = as.numeric(iris$Species), lwd = 2 )

# Adding Legends
?legend
legend("topleft",  c("Setosa", "Versicolor", "Verginica"),pch = 1:3, col = 1:3)

# Plotting entire dataframe

plot(iris)

# Multiple plots in a single window
?par
par(mfrow=c(1,2))

plot(x= iris$Species, y= iris$Sepal.Width,
     xlab = "Species",
     main = "Sepal width across species",
     col = "red")
plot(x= iris$Species, y= iris$Sepal.Length,
     xlab = "Species",
     main = "Sepal length across species",
     col = "blue")

dev.off()

# Univariate Analysis

# Boxplots 

b1<-boxplot(iris$Petal.Width, main = "Width of Petal",
            col = "blue", horizontal = T)
?boxplot
b1

setosa <- iris[iris$Species == "setosa",]

b1<-boxplot(setosa$Petal.Width, main = "Width of Petal", col = "blue", horizontal = T)
b1
b1$out
ind<-which(setosa$Petal.Width %in% b1$out)
ind

setosa1 <- setosa[-ind,]  # removing

setosa[ind,"Petal.Width"] <- 0.2 # imputing


# Histograms

hist(iris$Sepal.Width, col = "orange", labels = T)
summary(iris$Sepal.Width)
# with 5 bins
hist(iris$Sepal.Width, breaks = 5, col = "orange", labels = T)
# With range for x axis
summary(iris$Sepal.Width)
?hist
hist(iris$Sepal.Width, xlim = c(1,5), breaks = 5, col = "orange", labels = T)


# Using ggplot2

setwd("E:\\Jaishree\\Data Science with R\\Datasets")
mk <- read.csv("DirectMarketing.csv")
head(mk)
#install.packages("ggplot2")
library(ggplot2)

# Scatter Plots

p<-ggplot(mk,aes(x=Salary, y= AmountSpent))
p+geom_point()

p+geom_point(aes(colour = Gender))

p+geom_point(aes(colour = Gender)) + xlab("Salary in $") + ylab("Expenditure in $")  

# Histograms

summary(mk$AmountSpent)
p<-ggplot(mk,aes(x = AmountSpent))

p+geom_histogram()

p+geom_histogram(aes(fill = Gender),position = "dodge")


p+geom_histogram(aes(fill = Gender, color = Gender), alpha= 0.3)+facet_grid(Gender~.)

# Boxplots

p<-ggplot(mk,aes(x=Gender,y=AmountSpent,fill = Gender))
p+geom_boxplot()

# Heat Maps

str(mk)
p <- ggplot(mk,aes(x = Salary, y=  AmountSpent))
p+geom_bin2d()
p <- ggplot(mk,aes(x =  Age,y= Gender))
p+geom_bin2d()
