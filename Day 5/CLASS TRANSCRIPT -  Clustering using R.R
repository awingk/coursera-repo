setwd("C:\\Users\\avinash17.singh\\Desktop\\Training - Advanced Machine Learning with R\\Day 5")
song <- read.csv("Song_Football.csv", header = T, stringsAsFactors = F)

# Data Exploration

dim(song)
str(song)
View(song)

summary(song)

# Different variables have different scales

# Data Preparation
# Pick the numeric variables that are to be scaled

songnum <- song[,2:8]
str(songnum)

# Scaling - standardize the data to a common scale


?scale
songscale <- scale(songnum, center = T, scale = T)
songscale
class(songscale)
songscaledf= data.frame(songscale)
class(songscaledf)
summary(songscaledf)
View(songscaledf)


# Alternatively - songnum$scaledtackles = (songnum$Tackles - mean(songnum$Tackles))/sd(songnum$Tackles)

# Weighting

songscaledf$Tackles3 = songscaledf$Tackles * 3 # its a business decision so only tackles is given higher weightage

View(songscaledf)

# Remove Tackles variable

str(songscaledf)
songscaledf <- songscaledf[,-1]
str(songscaledf)

# Set the seed so that every time clustering is done, we get the same output

?set.seed
set.seed(1234)

# K-Means clustering

?kmeans
cluster24 <- kmeans(songscaledf, centers = 24, iter.max = 40)
class(cluster24)
cluster24

cluster24$totss

cluster24$betweenss/cluster24$totss

# between_SS / total_SS is a measure of the total variance 
#in the data set that is explained by the clustering. 
# k-means minimize the within group dispersion and 
#maximize the between-group dispersion. 
#Ideally you want a clustering that has the properties
#of internal cohesion and external separation,
#i.e. the BSS/TSS ratio should approach 1.

str(cluster24)

# Size of the clusters

cluster24$size # this gives size of each cluster 

# Compare strength and sizes of different sets of clusters and find the optimal one



# Adding cluster numbers to original dataset



song$cluster <- cluster24$cluster # creating a new col with cluster num for each data point

View(song)

?plot
library(ggplot2)
plot(song$Tackles,song$passes,col =song$cluster)
qplot(song$Tackles,song$passes, colour = song$cluster)

cluster3 <- kmeans(songscaledf, centers = 3, iter.max = 40)
song$clust3 <- cluster3$cluster
qplot(song$Tackles,song$passes, colour = song$clust3)

#cluster profiling: giving description ie speciality of each cluster
# Finding people in Song's cluster

songclusternumber = song[song$First_Name == "Song", "cluster"]
songclusternumber
song[song$cluster == songclusternumber, c("First_Name", "Last_Name")]

# Profiling follows clustering


# Cluster profiling follows this, where we build an identity of 
# each of the clusters to see what is it that sets the clusters 
# apart from the rest of the population or from the other clusters. 
# The easiest way to approach these questions is to take the mean 
# of each variable within the cluster and compare it to the mean 
# of the same variable in the parent population.  

songprofile <-song[song$cluster == songclusternumber, ]
dim(songprofile)
str(songprofile)
summary(songprofile)
summary(song)


#Song's group specializes in passes, duels and 
#interceptions.

#Elbow Method for finding the optimal number of clusters

set.seed(123)
# Compute and plot wss for k = 2 to k = 15.
k.max <- 15
wss <- sapply(1:k.max, 
              function(k){kmeans(songscaledf, k, iter.max = 40 )$tot.withinss})
wss

?plot
plot(1:k.max, wss,
     type="b", pch = 19,  
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

