require(ggplot2)
library(ggplot2)

data(diamonds) #load data about diamonds
head(diamonds) #see first few records about diamonds

mean(diamonds$price) # Get mean of diamonds price

aggregate(price ~ cut, data=diamonds, mean) # Get aggregate of price, break down by cut, then mean

aggregate(price ~ cut + color, data=diamonds, mean) # Get aggregate of price, break down/group by cut, color and then average

diaMean <- aggregate(price ~ cut + color, data=diamonds, mean)
diaMean[order(diaMean$price, decreasing=TRUE),]
order(c(1,3,4,2)) # sorts by cut, color, price
sort(c(1,3,4,2))
aggregate(cbind(price, carat) ~ cut, data=diamonds, mean) 
cbind(1:10, 10:1) #cbind takes two columns and puts them next to each other

aggregate(price ~ cut, data=diamonds, plyr::each(mean,sum)) # can access function without requiring
require(plyr)
ddply # split, apply, combine and returns dataframe
llply # take in a list (container that can hold any arbitrary objects), then split, apply, combine, returns list
list1 <- list(A=1:10, B=matrix(1:9, ncol=3), c=4)

meanSum

ddply(diamonds, "cut", meanSum) #ddply does split, apply function, combine

meanSum2 <- function(data, col1, col2, func1, func2)
{
  return(
    c(First=func1(data[,col1], Second=func2(data[,col2])))
    )
}

ddply(diamonds, c("cut","color"), meanSum2, col1="price", col2="carat", func1=mean, func2=sum)

#llply(.parallel=TRUE) # Allows you to do parallel computing

codes <- read.table("http://www.jaredlander.com/data/countryCodes.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)
countries <- read.table("http://www.jaredlander.com/data/GovType.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

head(countries) # see head of data
View(countries) # see entire table

names(countries)
names(codes)

str(codes) # columns, types, sample data
attributes(codes) # meta data (e.g. columns, types)

# Can Join using 1.) data tables joining, 2.) merge in R (but chokes on larger data sets), or 3.)plyer
# For plyer, we need to rename the column names to be the same name
names(codes)[2] <- "Country" # Can manually rename, but tedious
codes <- rename(codes, c(Country.name="Country"))

countryCode <- join(codes, countries, by="Country")

require(reshape2)
head(airquality) #example of wide data
airMelt <- melt(data=airquality, id.vars=c("Month", "Day"), value.name="Value", variable.name="Metric") #Similar to pivot table, id.vars is pivoting data
head(airMelt)
tail(airMelt)

airCast <- dcast(airMelt, Month + Day ~ Metric, value.var="Value") #bring back to long data
head(airCast)

