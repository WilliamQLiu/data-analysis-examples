# Data competition: http://www.kaggle.com/c/avazu-ctr-prediction
# Dataset is 11 days of Avazu click-through-rate metrics
# Our goal is create an algorithm that predicts whether an ad will be clicked

install.packages("ggplot2")
install.packages("ggthemes")
install.packages("reshape")
install.packages("plyr")
install.packages("pastecs")

library(reshape)  # for reshaping data
library(ggplot2)  # for plotting
library(scales)  # for formatting x and y labels
library(ggthemes)  # for plotting themes
library(plyr)  # for renaming
library(pastecs)  # for data analysis (e.g. describe summary statistics)

set.seed(123)  # Save random state

### Load data locally from CSV
# Instead of loading entire 6GB file, load just a small sample: 
# $head -n10000 train.csv > small_train.csv
my_large_file <- read.csv(file="/Users/williamliu/Desktop/Kaggle_Avazu/train.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)
my_small_file <- read.csv(file="/Users/williamliu/Desktop/Kaggle_Avazu/small_train.csv", sep=",", header=TRUE, stringsAsFactors=TRUE)
View(my_small_file)  # peak at file, make sure everything is okay

stat.desc(my_small_file)

#format_data = factor(my_small_file, )