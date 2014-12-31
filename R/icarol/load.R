# Help: To get help on a function (e.g. factor), type in console: ?factor

install.packages("ggplot2")

library(dplyr)  # How to load libraries

# System Settings
set.seed(123)  # Sets the random number generator state (so we can reproduce)
#options(echo=TRUE, max.print=99999, verbose=TRUE)
getwd()  # Can also setwd(<path>), returns working directory


# Load file
dir()  # See your current directory
myfile <- read.csv(file="C:\\Users\\wliu\\Desktop\\myfile.csv",
                   sep=",", header=TRUE, stringsAsFactors=FALSE, skip=2)


# Viewing the data
ls()  # Like Linux, just lists all your variables (e.g. myfile)
View(myfile)  # Get actual values (like a giant Excel sheet)
names(myfile)  # Get column names
mycolnames <- colnames(myfile)  # Get column names; same as names(myfile)
myrownames <- rownames(myfile)  # Get row names
attributes(myfile)  # Get list of rows  # e.g. Row 1, 2, 3, 4
dim(myfile)  # Get dimensions of the dataframe (e.g. 256328 rows, 347 columns)
head(myfile)  # Get first 6 rows
tail(myfile)  # Get last 6 rows
typeof(mycolnames)  # Get type of column
mycolnames[150]  # Get name of the 150th column


### Editing the data
edit(myfile)  # Lets you edit the file


### Basic Filtering for specific sata
str(myfile)  # Tells you structure of the data (e.g. Col name, options)
test <- dput(myfile$CallReportNum)  # Dump an object in the form of R code  (e.g. how to make this in R)
ls(myfile[1])  # Get first column name of file (e.g. CallReportNum)
typeof(get(ls()))  # ls() gets list of character names of object (e.g. first_col, second_col)
                   # get() obtains value of object (e.g. value of first_col, second_col)
                   # typeof() shows type of each value of object (e.g. type of first_col)
test <- myfile$CallReportNum  # Get column 'CallReportNum'
test <- myfile[1:5,]  # Get these rows, (and all columns)
test <- myfile[, c("CallReportNum", "Safe.Plan...3..Name")]  # Get these columns (and all rows)
test <- myfile[myfile$Call.Information...Caller.is.=='Other (Third Party)', ]  # Filter by col values


### Advanced Filtering for Specific Data
myoutput <- subset(myfile, Call.Information...Caller.is.=='Other (Third Party)' & !is.null(MCT...MCT.Referral.Made) & !is.na(MCT...MCT.Referral.Made) & !is.nan(MCT...MCT.Referral.Made) & MCT...MCT.Referral.Made!="" & (Third.Party.Information...Relationship=='Service Provider' | Third.Party.Information...Relationship=='Client Representative') & CallDateAndTimeStart>="2014-01-01")

### Write data to csv
write.table(myoutput, file='mct.csv', sep=",", qmethod="double", row.names=TRUE, col.names=NA)
