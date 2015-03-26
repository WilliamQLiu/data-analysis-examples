install.packages("ggplot2")
install.packages("ggthemes")
install.packages("reshape")
install.packages("plyr")
install.packages("Rcmdr", dependencies=TRUE)

library(Rcmdr)  # R Commander, graphical analysis
library(reshape)
library(ggplot2)  # for plotting
library(scales)  # for formatting x and y labels
library(ggthemes)  # for plotting themes
library(plyr)  # for renaming
library(stringr)  # for string wrap on text



### Load data locally from CSV
#myfile <- read.csv(file="C:\\Users\\wliu\\Desktop\\LifelineSurvey\\survey_data.csv", sep=",", header=TRUE, stringsAsFactors=TRUE)
myfile <- read.csv(file="/Users/williamliu/Dropbox/Lifeline/network_survey/survey_data.csv", header=TRUE)
View(myfile)  # peak at file, make sure everything is okay
#View(myfile[,100:200])  # peak at file, make sure everything is okay

typeof(myfile)  # See what file type this field is

### Question 13

### Load columns we want, melt data into shape we want
# Plot Question 13 - "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined..."
data <- myfile[, c("CrisisCenterKey", 
                   "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined...")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
typeof(clean_data)

### Reorder to correct order
print(levels(clean_data$value))  # Before ordering  "0 - 100"        "1,001 - 5,000"  "100 - 500"      "10001"          "5,001 - 10,000" "501 - 1,000" 
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,3,6,2,5,4)])  # Reorder the categorical order
ordered_value = revalue(ordered_value, c("0 - 100"="0 - 99", "10001"="10,001+"))  # Rename categories
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
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Average Number of Calls per Month") + ylab("Percent of Crisis Centers") +
  ggtitle("Q13 - On average, how many calls per month do you receive on all your crisis center hotline(s) combined?") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph  # display graph

# Try different themes
#my_graph <- my_graph + theme_fivethirtyeight() + scale_color_fivethirtyeight()  # Fivethirtyeight
#my_graph <- my_graph + theme_tufte() # Edward Tufte
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20))

#my_graph <- my_graph + theme_hc(bgcolor="darkunica") + scale_fill_hc("darkunica")  # Highcharts - Darkunica
#my_graph <- my_graph + theme_few() + scale_colour_few()  # Stephen Few
#my_graph <- my_graph + theme_economist() + scale_colour_economist()  # Economist
my_graph

# Formatting for legend
#my_graph <- my_graph + theme(plot.title = element_text(size=18, face="bold")) + # title
#  theme(axis.text.x=element_text(angle=50, size=14, vjust=0.5)) +  # x-axis
#  theme(legend.title=element_text(size=14, face="bold")) 
#+ #scale_color_discrete(name=clean_data$value) +
#  guides(colour = guide_legend(override.aes = list(size=7))) # legend appear larger
#facet_wrap(~Year, nrow=1)  # split graphs by say Year

#my_graph  # Plot

### End Test Question

### Question 6
data <- myfile[, c("CrisisCenterKey", 
                   "What.is.the.approximate.total.funding.devoted.specifically.to.support.your.crisis.center.hotline.operations.")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Reorder to correct order
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,2,3,4,5,6,7)])  # Reorder the categorical order
ordered_value = revalue(ordered_value, c("1000000"="1,000,000+"))  # Rename categories

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Approximate Total Funding (for Crisis Center Hotline Operations)") + ylab("Percent of Crisis Centers") +
  ggtitle("Q6 - What is the approximate total funding devoted specifically to support \nyour crisis center hotline operations?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 7 - Needs Data Cleaning

### Question 8
data <- myfile[, c("CrisisCenterKey", 
                   "In.the.last.fiscal.year..July.1..2013.to.June.30..2014...have.you.experienced.changes.in.funding.")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
### Reorder to correct order
print(levels(clean_data$value))  # "Decrease"  "Increase"  "No Change"
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,3,2)])  # Reorder the categorical order

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Change in Funding Levels") + ylab("Percent of Crisis Centers") +
  ggtitle("Q8 - Have you experienced changes in funding level during the past 12 months?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph

### Question 9 - Check all that apply
### Question 10 - Check all that apply

### Question 14
data <- myfile[, c("CrisisCenterKey", 
                   "In.the.last.fiscal.year..July.1..2013.to.June.30..2014...please.check.which.best.describes.your.center.s.call.volume.trends.")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
### Reorder to correct order
print(levels(clean_data$value))  # "Decrease"  "Increase"  "No Change"
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,7,3,4,5,6,2)])  # Reorder the categorical order

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Call Volume Trends") + ylab("Percent of Crisis Centers") +
  ggtitle("Q14 - In the last Fiscal Year (7/2013 - 6/2014), \n what best describes your center's call volume trends?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 15 - Numerical
data <- myfile[, c("CrisisCenterKey", 
                   "Approximately.what.percentage.of.your.center.s.calls.are.Lifeline.calls......")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
### Reorder to correct order
#print(levels(clean_data$value))  # "Decrease"  "Increase"  "No Change"
#ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,7,3,4,5,6,2)])  # Reorder the categorical order

### Plot with these colors
#my_graph <- ggplot(clean_data, aes(x=value)) + geom_histogram()  #(aes(x=clean_data, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- ggplot(clean_data, aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + geom_histogram(fill="#C5E8C2", binwidth=1) + scale_y_continuous(labels=percent) #+ geom_density()
my_graph <- my_graph + xlab("Lifeline Specific Calls") + ylab("Percent of Crisis Centers") +
  ggtitle("Q15 - Approximately what percent of your center's calls are Lifeline calls?  (n=133)") + 
  expand_limits(y=0)  # Force chart to go down to 0
#my_graph
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=14)) +  # X text labels
  #theme(axis.text.x=element_text(size=8, angle=45)) +  # X text labels
  #theme(axis.ticks.x=2) + 
  theme(axis.text.y=element_text(size=14)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20))
  #+ scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 16 - Categorical and Numerical, requires data cleaning

### Question 22 - Check all

### Question 23 - Check all

### Question 24 - Check all

### Question 25 - Check all

### Question 26 - Check all

### Question 27
data <- myfile[, c("CrisisCenterKey", 
                   "What.percentage.of.Lifeline.calls.require.that.rescue.be.dispatched.")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
### Reorder to correct order
print(levels(clean_data$value))  # "0 - 2%"   "11 - 15%" "16% +"    "3 - 6%"   "7 - 10%"
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,4,5,2,3)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 2%"   "11 - 15%" "16% +"    "3 - 6%"   "7 - 10%"

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Percentage of Lifeline Calls require rescue to be dispatched") + ylab("Percent of Crisis Centers") +
  ggtitle("Q27 - What percentage of Lifeline calls require rescue to be dispatched?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph

### Question 31
data <- myfile[, c("CrisisCenterKey", 
                   "Does.your.crisis.center.provide.follow.up.services.to.callers."
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Provide follow up services to callers?") + ylab("Percent of Crisis Centers") +
  ggtitle("Q31 - Does your crisis center provide follow up services to callers?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 32
data <- myfile[, c("CrisisCenterKey", 
                   "If..Yes...how.do.you.support.them."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

print(levels(clean_data$value))
ordered_value = factor(clean_data$value, exclude=is.na(clean_data$value), levels(clean_data$value)[c(2,3,4)])  # Reorder the categorical order#ordered_value = revalue(ordered_value, c(""="N/A"))  # Rename categories
print(levels(ordered_value))
#qplot(ordered_value)  # Do a quick plot to double check order is correct

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("How are follow up services funded?") + ylab("Percent of Crisis Centers") +
  ggtitle("Q32 - If there are follow up services, how are they funded?  (n=121)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=25))  # Wrap x label text for being too long
my_graph


### Question 34
data <- myfile[, c("CrisisCenterKey", 
                   "Does.your.crisis.center.use.volunteers.as.telephone.workers.or.supervisors.on.your.crisis.hotlines."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Do you have volunteers working on the crisis line?") + ylab("Percent of Crisis Centers") +
  ggtitle("Q34 - Are volunteers working on the crisis line?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 36
data <- myfile[, c("CrisisCenterKey", 
                   "Does.your.center.have.any.paid.staff.who.are.telephone.workers.or.supervisors.on.your.crisis.hotline.s.."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Do you have paid staff working on the crisis line?") + ylab("Percent of Crisis Centers") +
  ggtitle("Q36 - Are paid staff working on the crisis line?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph

### Question 40
data <- myfile[, c("CrisisCenterKey", 
                   "Does.your.center.have.postvention.protocols.in.place.for.internal.staff.volunteers.and.or.the.community."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Do you have postvention protocols in place?") + ylab("Percent of Crisis Centers") +
  ggtitle("Q40 - Does your center have postvention protocols in place for \ninternal staff/volunteers and/or the community?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 41 - Numerical
data <- myfile[, c("CrisisCenterKey", 
                   "Please.specify.the.total.number.of.hotline.clinical.training.hours.required.before.a.hotline.staff.volunteer.can.independently.answer.calls.on.your.crisis.center.hotline.s.....Open.Ended.Response")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Plot with these colors
my_graph <- ggplot(clean_data, aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + geom_histogram(fill="#C5E8C2", binwidth=5) + scale_y_continuous(labels=percent) + geom_density()
my_graph <- my_graph + xlab("Clinical Training Hours before independently answering calls") + ylab("Percent of Crisis Centers") +
  ggtitle("Q41 - Please specify the total number of hotline/clinical training hours required before \na hotline staff/volunteer can independently answer calls on your crisis center hotline(s)  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
#my_graph
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=14)) +  # X text labels
  #theme(axis.text.x=element_text(size=8, angle=45)) +  # X text labels
  #theme(axis.ticks.x=2) + 
  theme(axis.text.y=element_text(size=14)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20))
#+ scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph

### Question 42 - Numerical
data <- myfile[, c("CrisisCenterKey", 
                   "Of.the.total.number.of.training.hours.listed.above..how.many.hours.specifically.address.suicide.prevention....Open.Ended.Response")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

### Plot with these colors
my_graph <- ggplot(clean_data, aes(x=value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + geom_histogram(fill="#C5E8C2", binwidth=1) + scale_y_continuous(labels=percent) + geom_density()
my_graph <- my_graph + xlab("Training Hours (Suicide specific) before independently answering calls") + ylab("Percent of Crisis Centers") +
  ggtitle("Q42 - Please specify the total number of hotline/clinical training hours (suicide specific) required \n before a hotline staff/volunteer can independently answer calls on a hotline(s)  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
#my_graph
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=14)) +  # X text labels
  #theme(axis.text.x=element_text(size=8, angle=45)) +  # X text labels
  #theme(axis.ticks.x=2) + 
  theme(axis.text.y=element_text(size=14)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20))
#+ scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 48 - Categorical
data <- myfile[, c("CrisisCenterKey", 
                   "How.often.are.hotline.staff.volunteers.provided.feedback.based.on.monitoring.results."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape

print(levels(clean_data$value))
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,3,5,6,4,2)])  # Reorder the categorical order#ordered_value = revalue(ordered_value, c(""="N/A"))  # Rename categories
print(levels(ordered_value))

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("How often is monitoring results feedback provided?") + ylab("Percent of Crisis Centers") +
  ggtitle("Q48 - How often are hotline staff/volunteers provided feedback based on monitoring results?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph

### Question 52 - Check all

### Question 54 - Check all

### Question 55
data <- myfile[, c("CrisisCenterKey", 
                   "How.active.is.your.crisis.center.on.Social.Media."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(3,1,2,4)])  # Reorder the categorical order#ordered_value = revalue(ordered_value, c(""="N/A"))  # Rename categories
print(levels(ordered_value))

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("How active on Social Media") + ylab("Percent of Crisis Centers") +
  ggtitle("Q55 - How active is your crisis center on Social Media?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph


### Question 57
data <- myfile[, c("CrisisCenterKey", 
                   "How.strong.is.your.relationship.with.your.local.VA.Suicide.Prevention.Coordinator."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(2,5,1,3,4)])  # Reorder the categorical order#ordered_value = revalue(ordered_value, c(""="N/A"))  # Rename categories
print(levels(ordered_value))

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value, y=(..count..)/sum(..count..)), fill="#C5E8C2") + scale_y_continuous(labels=percent)
my_graph <- my_graph + xlab("Relationship with VA Suicide Prevention Coordinator") + ylab("Percent of Crisis Centers") +
  ggtitle("Q57 - How strong is your relationship with your local VA Suicide Prevention Coordinator?  (n=134)") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph <- my_graph + theme_hc() + scale_colour_hc() + # Highcharts
  theme(axis.text.x=element_text(size=12)) +  # X text labels
  theme(axis.text.y=element_text(size=12)) +  # Y text labels
  theme(axis.title.x=element_text(size=14, face="bold")) +  # X title labels
  theme(axis.title.y=element_text(size=14, face="bold")) +  # Y title labels
  theme(axis.title = element_text(size=20)) +  # Title
  scale_x_discrete(labels = function(x) str_wrap(x, width=14))  # Wrap x label text for being too long
my_graph




### Looking around at frequencies and percentages

### Question 22
data <- myfile[, c("CrisisCenterKey", 
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.a.formal.relationship.with.one.or.more.ED...contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.an.informal.relationship.with.one.or.more.ED..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.NO.relationship.with.an.ED",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.a.procedure.for.providing.assessment.information.for.callers.we.refer.to.the.ED",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.provide.follow.up.services.for.patients.discharged.from.an.ED",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.provided.training.for.ED.staff.in.risk.assessment",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.staff.that.are.co.located.in.an.ED.and.work.with.ED.staff.on.risk.assessments.and.or.referrals",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....Our.agency.organization.provides.emergency.room.services",
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 23
data <- myfile[, c("CrisisCenterKey", 
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.a.formal.relationship.with.one.or.more.MCT.s...contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.an.informal.relationship.with.one.or.more.MCTs..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.NO.relationship.with.an.MCT",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....There.is.NO.MCT.currently.serving.our.area.s.",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....Our.agency.is.formally.designated.by.a.funding.authority.to.dispatch.mobile.crisis.services",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.provide.follow.up.services.for.one.or.more.MCTs",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.provided.training.to.MCT.staff.in.risk.assessment",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.conduct.risk.assessments.for.MCT.staff",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....Our.agency.organization.provides.mobile.crisis.services"                   
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 24
data <- myfile[, c("CrisisCenterKey",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.have.a.formal.relationship.with.local.law.enforcement..contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.have.an.informal.relationship.with.local.law.enforcement..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.have.NO.relationship.with.local.law.enforcement",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....Our.local.law.enforcement.has.a.Crisis.Intervention.Team..CIT..but.we.have.NO.relationship.with.them",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....Our.local.law.enforcement.does.NOT.have.a.CIT",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.provide.training.to.law.enforcement.for.working.with.persons.that.are.suicidal.and.or.have.behavioral.health.problems"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 25
data <- myfile[, c("CrisisCenterKey",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.have.a.formal.relationship.with.one.or.more.EMS.programs..contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.have.an.informal.relationship.with.one.or.more.EMS.programs...knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.have.NO.relationship.with.local.EMS",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.provide.training.to.EMS.personnel",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....Other"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 26
data <- myfile[, c("CrisisCenterKey",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....We.have.a.formal.relationship.with.our.local.911.call.centers..contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....We.have.an.informal.relationship.with.our.local..911.call.centers..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....We.have.NO.relationship.with.our.local.911",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....When.we.refer.callers.at.imminent.risk.to.911..we.have.a.process.in.place.where.they.can.inform.us.if.the.caller.was.seen.and.or.transported"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 27
data <- myfile[, c("CrisisCenterKey",
                   "What.percentage.of.Lifeline.calls.require.that.rescue.be.dispatched."
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))  # "0 - 2%"   "11 - 15%" "16% +"    "3 - 6%"   "7 - 10%"
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,4,5,2,3)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 2%"   "3 - 6%"   "7 - 10%"  "11 - 15%" "16% +"
my_freq <- table(ordered_value)  # Create table of frequencies for each categorical
my_freq

### Question 28
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.track.if.rescue.is.collaborative.voluntary.or.involuntary."
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 29
data <- myfile[, c("CrisisCenterKey",
                   "What.percentage.of.Lifeline.calls.that.your.center.takes.result.in.rescues.that.are.collaborative.voluntary...if.unknown..please.provide.your.best.estimate."
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))  # "0 - 4%"      "10 - 20%"    "20 - 30%"    "30 - 40%"    "40% or more" "5 - 10%"    
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,6,2,3,4,5)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 4%"      "5 - 10%"     "10 - 20%"    "20 - 30%"    "30 - 40%"    "40% or more"
my_freq <- table(ordered_value)  # Create table of frequencies for each categorical
my_freq

### Question 30a
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Community.mental.health.center.or.outpatient.mental.health.clinic"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 30b
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Local.emergency.room"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 30c
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Mobile.crisis.team"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 30d
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Law.enforcement"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 30e
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Fire.and.rescue"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 30f
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Local.911"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 30g
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Other.community.service"
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 31
data <- myfile[, c("CrisisCenterKey",
                   "Does.your.crisis.center.provide.follow.up.services.to.callers."
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 32
data <- myfile[, c("CrisisCenterKey",
                   "If..Yes...how.do.you.support.them."
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 34
data <- myfile[, c("CrisisCenterKey",
                   "Does.your.crisis.center.use.volunteers.as.telephone.workers.or.supervisors.on.your.crisis.hotlines."
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 35a
data <- myfile[, c("CrisisCenterKey",
                   "If..Yes...please.list.the.number.of.full.time.staff.and.the.number.of.part.time.staff....Number.of.full.time.volunteer.staff."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 35b
data <- myfile[, c("CrisisCenterKey",
                   "If..Yes...please.list.the.number.of.full.time.staff.and.the.number.of.part.time.staff....Number.of.part.time.volunteer.staff."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 36
data <- myfile[, c("CrisisCenterKey",
                   "Does.your.center.have.any.paid.staff.who.are.telephone.workers.or.supervisors.on.your.crisis.hotline.s.."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 37a
data <- myfile[, c("CrisisCenterKey",
                   "If..Yes...please.list.the.number.of.full.time.staff.and.the.number.of.part.time.staff....Number.of.full.time.paid.staff."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 37b
data <- myfile[, c("CrisisCenterKey",
                   "If..Yes...please.list.the.number.of.full.time.staff.and.the.number.of.part.time.staff....Number.of.part.time.paid.staff."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 38a
data <- myfile[, c("CrisisCenterKey",
                   "Approximately.what.percentage.of.your.hotline.staff.answers.calls.from.a.location.that.is.remote.to.your.center..e.g...from.their.home..etc......."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 39a
data <- myfile[, c("CrisisCenterKey",
                   "For.hotline.staff.volunteers.who.answer.crisis.calls..please.indicate.the.approximate.percentage.of.each.mental.health.related.degree......Has.a.degree.in.mental.health.or.related.field..e.g...BA..MA..PhD..etc...."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 39b
data <- myfile[, c("CrisisCenterKey",
                   "For.hotline.staff.volunteers.who.answer.crisis.calls..please.indicate.the.approximate.percentage.of.each.mental.health.related.degree......No.degree."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 40
data <- myfile[, c("CrisisCenterKey",
                   "Does.your.center.have.postvention.protocols.in.place.for.internal.staff.volunteers.and.or.the.community."
)]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq


### Doing Analysis

### Q13 and Q19

data_1 <- myfile[, c("CrisisCenterKey", 
                   "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined..."
                   #"In.the.last.fiscal.year..July.1..2013.to.June.30..2014...please.check.which.best.describes.your.center.s.call.volume.trends.",
                   #"Does.your.crisis.center.have.set.call.metrics.in.place.such.as.service.levels..calls.answered...average.speed.to.answer..and.abandonment.rates."
                   #"Does.your.crisis.center.use.a.call.tracking.software.to.log.and.document.calls."
                   )]  # Load Data
data_2 <- myfile[, c("CrisisCenterKey", 
                     "Does.your.crisis.center.have.set.call.metrics.in.place.such.as.service.levels..calls.answered...average.speed.to.answer..and.abandonment.rates."
                     #"Does.your.crisis.center.use.a.call.tracking.software.to.log.and.document.calls."
)]  # Load Data

clean_data = melt(data_1, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
### Correct order of categoricals
#print(levels(clean_data$value))  # Before ordering
#ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,3,6,2,5,4)])  # Reorder the categorical order
#ordered_value = revalue(ordered_value, c("0 - 100"="0 - 99", "10001"="10,001+"))  # Rename categories
#print(levels(ordered_value))  # After ordering
#qplot(ordered_value)  # Do a quick plot to double check order is correct

a <- data_1$On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined...
print(levels(data_1$On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined...))  # Before ordering
ordered_value = factor(a, levels(a)[c(1,3,6,2,5,4)])  # Reorder the categorical order
print(levels(ordered_value))
a <- ordered_value
b <- as.numeric(a)
avg_calls_month <- b

a <- data_2$Does.your.crisis.center.have.set.call.metrics.in.place.such.as.service.levels..calls.answered...average.speed.to.answer..and.abandonment.rates.
b <- as.numeric(a)
call_metrics <- b

#b <- as.numeric(levels(a))[a]
#call_metrics <- as.numeric(factor(data_1$Does.your.crisis.center.have.set.call.metrics.in.place.such.as.service.levels..calls.answered...average.speed.to.answer..and.abandonment.rates., levels=c("No", "Yes")))
#avg_calls_month <- as.numeric(factor(data_2$In.the.last.fiscal.year..July.1..2013.to.June.30..2014...please.check.which.best.describes.your.center.s.call.volume.trends., levels=c("0 - 100", "100 - 500", "501 - 1,000", "1,001 - 5,000", "5,001 - 10,000")))
m <- cbind(call_metrics, avg_calls_month)
cor(m, method='kendall', use="pairwise")  # Kendall's Tau
cor.test(call_metrics, avg_calls_month, method='kendall')

plot(avg_calls_month, call_metrics)  # Plot it
abline(lm(avg_calls_month~call_metrics), col="red") # regression line (y~x) 
lines(lowess(avg_calls_month,call_metrics), col="blue") # lowess line (x,y)

### Q8 and Q19
