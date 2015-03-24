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
myfile <- read.csv(file="C:\\Users\\wliu\\Desktop\\LifelineSurvey\\survey_data.csv", sep=",", header=TRUE, stringsAsFactors=TRUE)
View(myfile)  # peak at file, make sure everything is okay
typeof(myfile)  # See what file type this field is


# Plot Question 13 - "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined..."
data <- myfile[, c("On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined...")]  # Load Data
print(levels(data))  # "0 - 100"        "1,001 - 5,000"  "100 - 500"      "10001"          "5,001 - 10,000" "501 - 1,000"
x = factor(data, levels(data)[c(1,3,6,2,5,4)])  # Reorder the categorical order
print(levels(x))  # "0 - 100"        "100 - 500"      "1,001 - 5,000"  "5,001 - 10,000" "10001"
#question <- table(x)  # Create table of frequencies for each categorical
question <- prop.table(table(x))  # Create table of percentages for each categorical
write.table(question, file='quickquestion.csv', sep=",", quote=TRUE)  # Write to file
qplot(x)  # plot

