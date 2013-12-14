# Clustering
# K-means clustering means dividing the code into clusters

wine <- read.table("http://www.jaredlander.com/data/wine.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)
View(wine)
set.seed(2746251) # Sets the seed so you can use the same random variables
Sys.time # Get system time
winek3 <- kmeans(x=wine, centers=3)
winek3$cluster
require(useful)
plot(winek3, data=wine) #This plots all of the variables from different wineries into 3 clusters
#Cluster which say group of dresses are near another
#Cluster similar baseball players (based on similar attributes)

# Can determine quality of your model by "gap-statistic" and "hardigan's rule"
# Hardigan's Rule - each row of data calculates next closest point
# Closest between two points is a straight line; a^2+b^2=c^2
wineH <- hclust(d = dist(wine)) 
plot(wineH) #Shows a Cluster Dendrogram

rect.hclust(wineH, k=3, border = "red") #Add in red layer splitting into 3 Clusters
rect.hclust(wineH, k=13, border = "blue") #Add in blue layer splitting into 13 Clusters
