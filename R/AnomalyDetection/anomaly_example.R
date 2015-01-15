# Get ready to install the right packages
#setRepositories()
#install.packages("installr")
#library(installr)
#updateR()

# Install and load Package
install.packages("devtools")
devtools::install_github("twitter/AnomalyDetection")
install.packages("reshape")

library(AnomalyDetection)
library(reshape)  # for pivot data

# AnomalyDetectionTs detects one or more statistically significant
# anomalies in the input time series
help(AnomalyDetectionTs)

# AnomalyDetectionVec detects one or more statistically significant
# anomalies in a vector of observations
help(AnomalyDetectionVec)


### Load data locally from CSV
myfile <- read.csv(file="C:\\Users\\wliu\\Documents\\GitHub\\data-analysis-examples\\R\\AnomalyDetection\\test_data.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)


### Format data types
#myfile$GreenwichTime <- as.POSIXct(myfile$DateCreated, format="%Y-%m-%d %H:%M")  # Change str to date  # Minute
myfile$GreenwichTime <- as.POSIXct(myfile$GreenwichTime, format="%Y-%m-%d %H")  # Change str to date  # Hourly

# Remove duplicate CallGuid
myfile <- myfile[,c("GreenwichTime", "CallGuid")]  # Filter only for CallGuids
myfile <- myfile[!duplicated(myfile),]  # Remove duplicate CallGuids
#head(myfile)

# Filter date range
myfile <- myfile[myfile$GreenwichTime >= as.POSIXct("2014-12-01") & myfile$GreenwichTime <= as.POSIXct("2014-12-15"),]

myfile$counter <- 1  # use column as count
myfile <- myfile[,c("GreenwichTime", "counter")]
head(myfile)


### Melt data
myfile.m <- melt(myfile, id=c("GreenwichTime"), measure=c("counter"))


### Cast data
cast_data <- cast(myfile.m, GreenwichTime ~ variable, fun.aggregate=sum)
#View(cast_data)
head(cast_data)

#res = AnomalyDetectionVec(cast_data, max_anoms=.02, direction='both', only_last=FALSE, plot=TRUE)
res = AnomalyDetectionTs(cast_data, max_anoms=.02, direction='both', plot=TRUE)
res$plot  # Plot this
head(res)  # These are the anomalies
# Example:    timestamp anoms
# 1 2014-12-25 18:00:00   127
# 2 2014-12-29 07:00:00    50
# 3 2014-12-31 00:00:00     1