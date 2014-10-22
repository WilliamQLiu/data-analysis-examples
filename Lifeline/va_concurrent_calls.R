rm(list=ls()) # Removes all variables from R
require(ggplot2) # Get ggplot2
library(ggplot2)
#library("plyr")
#options(stringsAsFactors = True)

mydata <- read.csv("va_day_hour.csv",skip=0,sep=",",header=FALSE) # Read in CSV
colnames(mydata)<-c("day", "hour", "calls")  # Rename columns

p <- ggplot(data=mydata, aes(x=hour, y=calls))
p <- p + geom_point(size=2, alpha=1)
p <- p + stat_smooth(colour='blue')
p <- p + xlab("Hour") + ylab("Concurrent Calls")
p <- p + ggtitle('Concurrent Calls by Day and Hour')

myorder <- c("Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat")
mydata$day <- factor(mydata$day, levels=myorder)
p <- p + facet_wrap("day")  # Facet by Day

p  # Print Plot

