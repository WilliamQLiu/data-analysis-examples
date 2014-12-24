# Help: To get help on a function (e.g. factor), type in console: ?factor

# System Settings
set.seed(123)  # Sets the random number generator state (so we can reproduce)
options(echo=TRUE, max.print=99999, verbose=TRUE)

# Load file
dir()  # See your current directory
myfile <- read.csv(file="C:\\Users\\wliu\\Desktop\\myfile.csv",
                   sep=",", header=TRUE, stringsAsFactors=FALSE, skip=2)


# Viewing the data
ls()  # Like Linux, just lists all your variables (e.g. myfile)
View(myfile)  # Get actual values (like a giant Excel sheet)
names(myfile)  # Get column names
mycolnames <- colnames(myfile)  # Get column names
myrownames <- rownames(myfile)  # Get row names
attributes(myfile)  # Get list of rows  # e.g. Row 1, 2, 3, 4
dim(myfile)  # Get dimensions of the dataframe (e.g. 256328 rows, 347 columns)
head(myfile)  # Get first 6 rows
tail(myfile)  # Get last 6 rows


# Filtering for Specific Data
str(myfile)  # Tells you structure of the data (e.g. Col name, options)
test <- dput(myfile$CallReportNum)  # Dump an object in the form of R code  (e.g. how to make this in R)
ls(myfile[1])  # Get first column name of file (e.g. CallReportNum)
typeof(get(ls()))  # ls() gets list of character names of object (e.g. first_col, second_col)
                   # get() obtains value of object (e.g. value of first_col, second_col)
                   # typeof() shows type of each value of object (e.g. type of first_col)
test <- myfile$CallReportNum  # Get column 'CallReportNum'
test <- myfile[1:5,]  # Get the first five rows, all columns
test <- myfile[, c("CallReportNum", "")]
typeof(mycolnames)
mycolnames[150]
