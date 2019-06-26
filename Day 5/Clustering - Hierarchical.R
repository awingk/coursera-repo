# Hierarchical Clustering
setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 5")
teeth <- read.csv("teeth.csv", header = T, stringsAsFactors = F)
dim(teeth)
str(teeth)
summary(teeth)

?hclust
head(teeth)

?dist()
tdist<-dist(teeth)
tdist
class(tdist)

?hclust

hc <- hclust(tdist, method = "average")
hc
class(hc)
str(hc)

hc$order

# order gives the order in which the original obervations 
# would be plotted

# Plotting the dendrogram

plot(hc, labels = teeth$mammal)

# Finding organisms closer to rabbit
teeth[(teeth$mammal %in% c("Pika", "Rabbit", "Mole")),]
