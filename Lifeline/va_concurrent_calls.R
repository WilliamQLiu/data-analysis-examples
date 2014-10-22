rm(list=ls()) # Removes all variables from R
require(ggplot2) # Get ggplot2
library(ggplot2)
#library("plyr")
#options(stringsAsFactors = True)

mydata <- read.csv("va_day_hour.csv",skip=0,sep=",",header=FALSE) # Read in CSV
colnames(mydata)<-c("day", "hour", "calls")  # Rename columns

#myorder <- c("Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat")
mydata$day <- factor(mydata$day, levels=c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"))
p <- ggplot(data=mydata, aes(x=hour, y=calls))
p <- p + facet_wrap("day", ncol=7)  # Facet by Day
p <- p + geom_point(size=2, alpha=1/2)
p <- p + stat_smooth(colour='blue')
p <- p + xlab("Hour") + ylab("Concurrent Calls")
p <- p + ggtitle('Concurrent Calls by Day and Hour')
p <- p + theme_bw()

p  # Print Plot
ggsave('va_concurrent_calls.png', plot=p)
