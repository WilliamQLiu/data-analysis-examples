install.packages("ggplot2")
install.packages("ggthemes")
install.packages("reshape")
install.packages("plyr")

library(reshape)
library(ggplot2)  # for plotting
library(scales)  # for formatting x and y labels
library(ggthemes)  # for plotting themes
library(plyr)  # for renaming


### Load data locally from CSV
#myfile <- read.csv(file="C:\\Users\\wliu\\Desktop\\LifelineSurvey\\survey_data.csv", sep=",", header=TRUE, stringsAsFactors=TRUE)
myfile <- read.csv(file="/Users/williamliu/Dropbox/Lifeline/network_survey/survey_data.csv", header=TRUE)
View(myfile)  # peak at file, make sure everything is okay
typeof(myfile)  # See what file type this field is

### Load columns we want, melt data into shape we want
# Plot Question 13 - "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined..."
data <- myfile[, c("CrisisCenterKey", "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined...")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
typeof(clean_data)

### Reorder to correct order
print(levels(clean_data$value))  # Before ordering  "0 - 100"        "1,001 - 5,000"  "100 - 500"      "10001"          "5,001 - 10,000" "501 - 1,000" 
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,3,6,2,5,4)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 100"        "1,001 - 5,000"  "100 - 500"      "10001"          "5,001 - 10,000" "501 - 1,000"  # After ordering
#qplot(ordered_value)  # Do a quick plot to double check order is correct

### Calculate 1.) frequencies and 2.) percentages
my_freq <- table(ordered_value)  # Create table of frequencies for each categorical
my_freq
my_percent <- as.data.frame(prop.table(table(ordered_value)))  # Create table of percentages for each categorical
my_percent
#write.table(my_freq, file='peek_freq.csv', sep=",", quote=TRUE)  # Write to file
#write.table(my_percent, file='peek_percent.csv', sep=",", quote=TRUE)  # Write to file

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value))
my_graph <- my_graph + xlab("Average Number of Calls per Month") + ylab("Number of Crisis Centers") +
  ggtitle("Question 13") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph  # display graph

# Formatting for legend
my_graph <- my_graph + theme(plot.title = element_text(size=18, face="bold")) + # title
  theme(axis.text.x=element_text(angle=50, size=14, vjust=0.5)) +  # x-axis
  theme(legend.title=element_text(size=14, face="bold")) + #scale_color_discrete(name=clean_data$value) +
  guides(colour = guide_legend(override.aes = list(size=7))) # legend appear larger
#facet_wrap(~Year, nrow=1)  # split graphs by say Year

# Try different themes
my_graph <- my_graph + theme_fivethirtyeight()
#my_graph <- my_graph + theme_hc()

my_graph  # Plot

