install.packages("ggplot2")

library(ggplot2)  # for plotting

# Load data locally from CSV
myfile <- read.csv(file="C:\\Users\\wliu\\Documents\\GitHub\\data-analysis-examples\\R\\SAMHSA_Snapshot\\summary.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)

mygraph <- ggplot(myfile, aes(x=Date, y=Lifeline.Calls.Answered..Total.))

mygraph + geom_bar(stat="identity", fill="green")  # Plot a bar chart

#mygraph <- mygraph + geom_point()  # Plot each point

# Shows quartiles
#mygraph + geom_smooth(aes(group=1))
