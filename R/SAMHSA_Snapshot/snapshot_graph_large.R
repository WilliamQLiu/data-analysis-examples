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
#myfile <- read.csv(file="C:\\Users\\wliu\\Documents\\GitHub\\data-analysis-examples\\R\\SAMHSA_Snapshot\\summary.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)
myfile <- read.csv(file="/Users/williamliu/GitHub/data-analysis-examples/R/SAMHSA_Snapshot/summary.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)
#View(myfile)  # peak at file, make sure everything is okay

### Reshape the data, first by filtering data we want, renaming, then by melt
mydata <- myfile[, c(1,2,3,4,6)]  # get the columns we want
#View(mydata)

# Rename columns
mydata <- rename(mydata, c("Lifeline.Calls.Answered..Total."="Lifeline Total Calls",
                           "Lifeline.Calls.Answered..Non.Veteran."="Lifeline Non-Veteran Calls",
                           "Lifeline.Calls.Answered..Veteran."="Veterans Crisis Line Calls",
                           "Lifeline.Calls.Answered..Spanish."="Spanish Line Calls",
                           "Lifeline.Crisis.Chats.Accepted..Total."="Lifeline Crisis Chats",
                           "Veterans.Chats.Accepted"="Veterans Chats",
                           "White.House.Letters.Received"="White House Letters",
                           "Disaster.Distress.Hotline.Calls.Answered"="Disaster Distress Helpline Calls",
                           "Disaster.Distress.Texts.Answered"="Disaster Distress Helpline Texts"))
#View(mydata)
my_clean_data = melt(mydata, id=c("Year", "Quarter", "Date"))  # Melt data so we can 'cast' it into any shape
my_clean_data$Date <- as.Date(my_clean_data$Date, "%m/%d/%Y")  # Change str to date
#View(my_clean_data)  # peak at file, make sure everything is okay

# Plot with these colors
mygraph <- ggplot(my_clean_data) + geom_line(aes(x=Date, y=value, colour=variable), size=1.5) +
  scale_colour_manual(values=c("#1f77b4", "#aec7e8", "#ff7f0e"))

end_date <- max(my_clean_data$Date)  # get the latest end date to limit what gets plotted

# Formatting for plot
mygraph <- mygraph +  xlab("Date") + ylab("Calls Answered") +
  ggtitle("Summary by Month (NSPL & VCL) - CY 2014") +
  expand_limits(y=0) +  # Force chart to go down to 0
  scale_y_continuous(labels = comma, limits=c(0, 140000), expand=c(0,0),  # expand removes negative area
                     breaks = c(0, 10000, 20000, 30000, 40000, 50000, 60000,
                                70000, 80000, 90000, 100000, 110000, 120000,
                                130000, 140000)) +
  scale_x_date(labels = date_format("%m/%Y"),
               breaks = "1 month", minor_breaks = "1 month",
               limits = c(as.Date("2014-1-1"), end_date))

# Formatting for legend
mygraph <- mygraph + theme(plot.title = element_text(size=18, face="bold")) + # title
  theme(axis.text.x=element_text(angle=50, size=14, vjust=0.5)) +  # x-axis
  theme(legend.title=element_text(size=14, face="bold")) + scale_color_discrete(name="Program") +
  guides(colour = guide_legend(override.aes = list(size=7))) # legend appear larger
#facet_wrap(~Year, nrow=1)  # split graphs by say Year

# Try different themes
#mygraph <- mygraph + theme_fivethirtyeight()
#mygraph <- mygraph + theme_hc()

mygraph  # Plot


### Below is the incorrect way (i.e. Without melting the data)

#mycolors = c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b",
#             "#e377c2", "#7f7f7f", "#bcbd22", "#17becf")

#mygraph <- ggplot(data=myfile, aes(x=Date, y=Lifeline.Calls.Answered..Total.)) +
#    geom_line(color=mycolors[1], size=1, alpha=.5)

#mygraph <- mygraph + geom_line(data=myfile, aes(x=Date, y=Lifeline.Calls.Answered..Non.Veteran.),
#                               color=mycolors[2], size=1, alpha=.5)

#mygraph <- mygraph + geom_line(data=myfile, aes(x=Date, y=Lifeline.Calls.Answered..Veteran.),
#                               color=mycolors[3], size=1, alpha=.5)

#mygraph <- mygraph + geom_line(data=myfile, aes(x=Date, y=Lifeline.Crisis.Chats.Accepted..Total.),
#                               color=mycolors[4], size=1, alpha=.5)

#end_date <- max(myfile$Date)  # get the latest end date to limit what gets plotted

#mygraph <- mygraph +  xlab("Date") + ylab("Calls/Chats Answered") + ggtitle("Summary by Month") +
#    scale_y_continuous(labels = comma, breaks = c(20000, 40000, 60000, 80000, 100000, 120000, 140000)) +
#    scale_x_date(labels = date_format("%m/%Y"), breaks = "1 month", minor_breaks = "1 month",
#                 limits = c(as.Date("2014-1-1"), end_date))

#mygraph <- mygraph + theme_fivethirtyeight()

#mygraph + geom_smooth(aes(group=1))  # Shows quartiles

#mygraph + geom_bar(stat="identity", fill="green")  # Plot a bar chart
