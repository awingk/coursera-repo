"Hello!"

print("Hello World!")

# Data Structures in R - Vectors, Matrices, Data Frames, and Lists

# What is a vector?
x <- c(1,2,3,4,5,6)
x

class(x)

# R is case-sensitive

y <- c(1:6)

# class of x is numeric, class of y is integer

class(x)
class(y)

View(x)

mixed <- c(1,2,3,"Hi")

mixed

class(mixed)

logic <- c(TRUE, FALSE, TRUE)

class(logic)

# What is a matrix?

?matrix

B <- matrix(c(1:9), nrow = 3)
B

C <- matrix(c(2,5,7,3,6,8), nrow = 2)
C

B <- matrix(c(1:9), nrow = 3, byrow = TRUE)

B
colnames(B)

colnames(B) = c("A", "B", "C")
colnames(B)
B

rownames(B) <- c("R1", "R2", "R3")
B

# What are data Frames?

product <- c("Bag","Shoes", "Belt", "Belt")
total_price <- c(300,1000,150,200)
color <- c("BLue","red","red","blue")
quantity <- c(5,2,3,4)

product_details <-data.frame(product, total_price, color, quantity)

product_details

class(product_details)

str(product_details)

product_details$color <- as.factor(product_details$color)

str(product_details)

# Now it will convert it back to character var
product_details$color <- as.factor(product_details$color)

product_details <-data.frame(product, total_price, color, quantity, stringsAsFactors = F)

str(product_details)

product_details <- data.frame(product = c("Bag", "Shoes"),
                              total_price = c(300,1000),
                              quantity = c(5,2), stringsAsFactors = FALSE)

product_details$color <-as.factor(product_details$color)

str(product_details)

product_details

class(product_details)

product_details[1,]
product_details[2,2]

product_details[,1]

product_details$product

product_details$product[2]    # now its a vector

# R has some in-built data frames. Let's use them.
# To load the datasets in the package "datasets"

# install.packages("datasets")
library(datasets)

?datasets

?data() # what datasets are availble in this package

data()

ls() # list of env. objects

# To load the dataset "iris"
data("iris")
iris
?iris
view(iris) #spreadsheet view

# To display the column names in the "iris" dataset
?colnames
?names

names(iris)
colnames(iris)

#To know the class of the dataset "iris"
class(iris)
str(iris) # to know the structure

dim(iris) # dimensions

# To find the number of rows in the "iris" dataset
nrow(iris)
# To find the number of columns in the "iris" dataset
ncol(iris)

# To invoke a spreadsheet-style data viewer

dat2 <- iris

view(dat2)

# To dispaly the top 6 rows of the "iris" dataset

head(iris)
tail(iris)

head(iris,10)

str(iris)

head(iris$Species)

iris[3,3]
iris[,2]
iris[,"Species"] # specify the name of the col

iris$Species
iris[,5]
iris[c(2,4),]
iris[2:4,]
iris[iris$Sepal.Length == 5,] # this is a condition

iris[,-c(2,4)] # exclude col number 2,4 for display purpose

# To remove col altogether

subiris <- iris
head(subiris)
str(subiris)
subiris[,1] <- NULL  # will permanetly remove col 1 from subiris

str(subiris)

subiris[,2] <- NULL
subiris
obs <- subiris[-c(2,4),]
dim(obs)

head(subiris)
dim(subiris)

# To display the strutre of the dataset "iris"
str(iris)
unique(iris$Species) # diasplays unique value in a col

iris$Species

# To display summary stats fo the dataset "iris"
summary(iris) # discriptive stats for each variable
sumiris <- summary(iris)
class(sumiris)
sumiris
sumiris[1,3]

str(iris)

# to check teh type of col
is.character(iris$Species)
is.factor(iris$Species)
is.numeric(iris$Sepal.Length)

#Finding duplicate rows
duplicated(iris) # row number 143 is duplicate
which(duplicated(iris))
iris[143,]
iris[iris$Sepal.Length == 5.8 & iris$Sepal.Width == 2.7,]
iris[102,]

#What are Arrays?

?array
stat <- array(c(1:6,11:20), dim = c(2,4,3))
stat
lenght(stat)
stat
stat[2,2,3]


# what is a list?
y <- list(1,2,3,4)

# Example 2
df <- c(12,3,4) #vector
df 
stat <- array(c(1:8,11:18,111:118), dim = c(2,3,4)) # array
stat
mylist <- list(iris, stat, df) # list

mylist

mylist[[2]][1,2,3] # element number 2, row1,col2,group3


rm()
ls()
getwd()

setwd("C:/Users/avinash17.singh/Desktop/Day 2")
setwd("C:\\Users\\avinash17.singh\\Desktop\\Day 2")

# both the above syntax are correct

# To save all objects in workspace 
?save.image
save.image(file = "myobj.RData")

load("myobj.RData")

# To save specific Objects
save(product_details, file = "mixed.rda")

#save: save specific object, save.image: save full env

load("mixed.rda")

customer_details <- c(Name = c("Ramya","Ali","Jim"),
                      Age = c("25","30","35"),
                      Telephone_bill_rs = c("600","400","200"),
                      Month = c("Aug","Aug","Aug"))

names <- list(LastName = c("Potter","Riddle","Dumbledore"),
              FirstName = c("Harry", "Tom", "Abus"),
              Age = c(18,50,120),
              Profession = c("Student","Magician", "Headmaster"))

names[1]
names[[3]][3]
library("ggplot2")
data("msleep")
?msleep
colnames("msleep")
colnames(msleep)[3] <- "type"
msleep$type[1:10] # head(msleep$type, 10)
msleep$type <- as.character(msleep$type)
data <- msleep[,c(1,2,3,6)]

#head(msleep)

########## IMPORT DATA INTO R ##########
# How to get and set current working directory
getwd()
setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 2")

# The function read.csv() reads csv files into data frame
cust <- read.csv("Sample.csv")
View(cust)
str(cust)

customers <- read.csv(file.choose())

cust <- read.csv("customers.csv", stringsAsFactors = F)
str(customers)
customer$state <- as.factor(customer$state)
str(customers)

cust_with_miss <- read.csv("Sample_with_missing_values.csv", stringsAsFactors = F)
View(cust_with_miss)
str(cust_with_miss)

# Numeric misssing values converted to NA; Strings missing values as blanks
cust <- read.csv("Sample_with_missing_values.csv",
                 na.strings = c("","missing","<NA>"))
str(cust)
summary(cust)
head(cust[,c(1,2,3,4,5)],12)

view(cust)
# How to write to a file?
iris
View(iris)

?read.csv
write.csv(iris,"iris.csv")
write.csv(iris,"iris.csv", row.names = F)


varTypes = c(first_name = "character",
             last_name = "character",
             city = "character", country = "character",
             state = "character", zip_code = "numberic")
varTypes
?read.table

customers <- read.table("customers_noheaders.csv", sep = ",",
                        header = FALSE, col.names = names(varTypes),
                        colClasses = varTypes)
View(customers)

# Reading text Files
custxt <- read.table("customers.txt", sep = "\t", header = T)
View(custxt)

# How do you import Excel files?

# plently of libraries to import excel files but they have s/w dependencies

install.packages("readxl")
library(readxl)
?readxl
?read_excel()

samplereadxl <- read_excel("Sample.xlsx", sheet = "Sample")

View(samplereadxl)
?readxl
?read_excel()

samplereadxl5 <- read_excel("Sample.xlsx", sheet= "Sample", n_max = 5)

samplereadxl5 <- read_excel("Sample.xlsx", sheet= "Sample", range = "A1:E5")

samplereadxl5

readxl_example() # contains example spreadsheets

xls <- readxl_example("deaths.xlsx")
death <- read_excel(xls)
death
excel_sheets(xls)

install.packages("XML")
install.packages("readHTMLTable")
library(XML)
x <- readHTMLTable("https://apps.saferoutesinfo.org/legislation_funding/state_apportionment.cfm")
class(x)
x
str(x)
x[[1]]

class(x[[1]])
state <- x[[1]]
class(state)

install.packages("sqldf")
library(sqldf)
?read.csv.sql
custabove40 <- read.csv.sql("Sample.csv", sql = "select * from 
                            file where age > 40")
View(custabove40)

### Q1 and 2

data1 <- read.csv("S1_A1.csv",na.strings = c("999","missing","NA"))
data2 <- read.csv("S1_A2.csv", header = F)
names(data2) <- c("Age","Income")
data3 <- read.csv("S1_A3.csv",skip = 1,na.strings = c("999","Missing","NA"))


### Q3
library("ggplot2")
msleep

data <- msleep[,c(1,2,3,6)]
write.csv(data,"Msleep.csv")

### Q4
library(readxl)

getwd()
sheet1 <- read_excel("retail.xlsx", sheet = "data1")
sheet2 <- read_excel("retail.xlsx", sheet = "data2")

### Day 3
aggregate(oj$income,list(oj$brand), mean)

tapply(oj$income, oj$brand,mean)

# Contigency Table
table(oj$brand, oj$feat)

# Category-wise counts
?xtab

# dplyr package
# filter, select, mutate, group-by, summarize
# filter: row subsetting
library(dplyr)
head(filter(oj, brand == "tropicana" | brand == "dominicks"))

# select: column subsettting
head(select(oj,brand,INCOME,feat))

# mutate: creating new columns
head(mutate(oj,logIncome=log(INCOME))) #Change not made in oj but its copy

# arrange(): sorting
head(arrange(oj, -INCOME))

rm(list = ls())

setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 3")

#1
data <- read.csv("expenses.csv")

#2 & #3
str(data)

#4

#5
summary(data)

#6
# smoker var

#7

#8
summary(data)   # Y:274, N:1064

#9

#10
table(data$sex,df$smoker,data$region)

#11
colsums(is.na(data))
#12 #13
boxplot(data$age)
boxplot(data$bmi)

#14
hist(data$bmi, xlab = "BMI", col = "yellow",border = "blue")

#15
plot(x=data$age,y=data$charges,
     xlab = "Age",
     ylab = "Charges",
     main = "Age vs Charges"
)

#16
ndf <- group_by(df,sex)
summarise(ndf, mean(charges))
#or
ndf %>% group_by(sex) %>% summarise(mean(charges))

#17
ndf <- group_by(df, region)
summarise(ndf, mean*charges)

#18


#19
plot(x=data$smoker,y=data$charges,
     xlab = "Smoker",
     ylab = "Charges",
     main = "Smoker vs Charges"
)

#20
cor(df$bmi,df$charges) # df = data here

#21
quantile(data$age,seq(0,1,0.01))

#22


#23


#24
ind <- sort(sample(nrow(data), nrow(data) * 0.7)) # sample picks random data
data_train <- data[ind,]
data_val <- data[-ind,]
dim(data_train)

?cut

# Date in R
data$date <- as.Date(data$date,"%d-%b-%y")


