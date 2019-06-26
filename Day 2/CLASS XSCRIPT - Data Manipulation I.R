setwd("E:\\Jaishree\\Data Science with R\\Datasets")

oj <- read.csv("oj.csv", header = T)
oj
dim(oj)
str(oj)
unique(oj$brand)

# Subsetting data
# Display 1st row and 3rd column

oj[1,3]

# Displaying Row numbers 1,2,8,456 and Column numbers 1,3,6
oj[c(1,2,8,456),c(1,3,6)]
str(oj)

# Displaying first 5 rows of column "Brand"
oj[1:5,"brand"] 
head(oj$brand,5)

# To display all rows and columns for 'Tropicana' brand:
# Logical subsetting
dat <- oj[oj$brand == 'tropicana',]

#	To display all rows and columns for 'Tropicana' and 'Dominiks' brand:
dat2 <- oj[oj$brand == 'tropicana' | oj$brand == 'dominicks',]

dat3 <- oj[oj$brand %in% c('tropicana','Dominicks'),]

View(dat2)

# To display all rows and columns for Tropicana brand where no feature advertising is done:

dat3 <- oj[oj$brand == 'tropicana' & oj$feat == 0 & oj$week > 40,]
View(dat3)

# logical subsetting outputs missing values too, whereas which function does not result in any missing values:

sales <-c(100,200,NA, 300,400,NA,500,600,700,NA, 1000,1500,NA,NA)

which(sales>300)

sales

sales[sales >600]

sales[which(sales>600)]


index<-which(oj$brand == "dominicks")
head(index)


# Column Subsetting
# To display brand and week columns for all observations.

dat4 <- oj[,c("week","brand")]
View(dat4)

#	Row subsetting and column subsetting can be done  simultaneously too.

dat5 <- oj[oj$brand == 'tropicana' & oj$feat == 0,c("week","brand")]
dat5 <- oj[oj$brand == 'tropicana' & oj$feat!=0,]

View(dat5)

# Adding new columns

oj$loginc <- log(oj$INCOME)
dim(oj)
str(oj)
oj$revenue <- exp(oj$logmove) * oj$price
head(oj)

# Ordering data

students <- c("John", "Tim", "Alice", "Zeus")
order(students)
order(students, decreasing = T)
?order
students[order(students)]
?order
numbers <- c(10,100,5,8)
order(numbers)
numbers[order(numbers)]
numbers[order(-numbers)]
dat6 <- oj[order(oj$week),]
head(dat6)
min(oj$week)
dat7 <- oj[order(-oj$week),]
head(dat7)
max(oj$week)

# Groupwise Operations

?aggregate()
aggregate(oj$price, by = list(oj$brand), mean)
class(aggregate(oj$price, by = list(oj$brand), mean))
tapply(oj$price, oj$brand, mean)
class(tapply(oj$price, oj$brand, mean))
agg<-aggregate(oj$INCOME, by = list(oj$brand), mean)
write.csv(agg,"agg.csv")


tapply(oj$INCOME, oj$brand, mean)

# Contingency Tables

table(oj$brand)
table(oj$brand,oj$feat)
str(oj)
class(table(oj$brand,oj$feat))
?table

# Category-wise Counts

?xtabs()
xtabs(oj$INCOME~oj$brand+oj$feat)



# Using dplyr

#install.packages("dplyr")
library(dplyr)

# Subsetting rows using dplyr

dat8 <- filter(oj, brand == "tropicana")
head(dat8)
dat9 <- filter(oj, brand == "tropicana" | brand == "dominicks")
View(dat9)

# Subsetting columns using dplyr

dat10 <- select(oj, brand, INCOME, feat)
dat11 <- select(oj, -brand, -INCOME, -feat)

# adding new columns using dplyr

dat12 <- mutate(oj,logincome = log(INCOME))

# Ordering data using dplyr

dat13 <- arrange(oj, INCOME)
dat14 <- arrange(oj, desc(INCOME))
dat14 <- arrange(oj, -INCOME)

# Group-wise summary using dplyr

table(oj$brand)
gr_brand <- group_by(oj,brand)
summarise(gr_brand, mean(INCOME), sd(INCOME))

# To find mean price of all people whose income > = 10.5

mean(oj[oj$INCOME>=10.5,"price"])

summarise(filter(oj,INCOME>=10.5),mean(price))

# Using pipe operators

# To find the mean price of all people whose income > = 10.5
oj %>% filter(INCOME>=10.5) %>% summarise(mean(price))

#To create a new column logIncome on the subset of data that price is equal to or greater than 2.5, and to summarize this newly created column logIncome and compute the mean, median, standard deviation of this new column.

oj %>% filter(price >=2.5) %>% mutate(lc = log(INCOME)) %>% summarise(mean(lc),sd(lc),median(lc))

str(oj)
library(dplyr)
head(arrange(oj, -brand))

?desc



# Working with dates


fd <- read.csv("Fd.csv")
str(fd)
fd$FlightDate <- as.Date(fd$FlightDate, "%d-%b-%y")
str(fd)
?months()
months(fd$FlightDate)
head(months(fd$FlightDate))
unique(months(fd$FlightDate))
weekdays(fd$FlightDate)
head(weekdays(fd$FlightDate))
unique(weekdays(fd$FlightDate))

fd$FlightDate[60]
fd$FlightDate[900]

fd$FlightDate[60]-fd$FlightDate[900]
fd$FlightDate[60]
fd$FlightDate[900]
fd$FlightDate[3000]
fd$FlightDate[90]
?difftime
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "weeks")
weekdays(fd$FlightDate[3000])
weekdays(fd$FlightDate[90])

?difftime
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "days")

difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "hours")

library(dplyr)
dim(fd)

fd_s <- fd %>% filter(weekdays(fd$FlightDate) == "Sunday")


dim(fd_s)
head(fd_s)

fd %>% filter(weekdays(fd$FlightDate) == "Sunday" & fd$DestCityName == "Atlanta, GA" ) %>% nrow()

fd %>% filter(weekdays(FlightDate) == "Sunday") 
       group_by(DestCityName) %>%
       summarise(n())

Sys.Date()
class(Sys.Date())
Sys.time()
class(Sys.time())

date1 <- Sys.time()
date1
class(date1)
weekdays(date1)
months(date1)


date2 <- as.POSIXlt(date1)
class(date2)
date()

date2
str(date2)
date2$wday
date2$zone
date2$hour

?Sys.time
format(Sys.time(), "%a %b %d %X %Y")
format(Sys.time(), "%X")



# Using lubridate package
fd <- read.csv("Fd.csv")
str(fd)
#install.packages("lubridate")
library(lubridate)
?dmy

fd$FlightDate <- dmy(fd$FlightDate)
str(fd)

# If tz time zone indicator is NULL (default), 
# then a Date object is returned. 
# Otherwise a POSIXct with time zone attribute set to tz
# is returned

fd <- read.csv("Fd.csv")
str(fd)
fd$FlightDate <- dmy(fd$FlightDate, tz = "GMT")
str(fd)
fd$FlightDate <-as.POSIXct(fd$FlightDate)


?as.POSIXct
str(fd)
fd$FlightDate <-as.POSIXlt(fd$FlightDate)
class(fd$FlightDate)


