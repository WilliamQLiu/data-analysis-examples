install.packages("reshape")
library(reshape)


### Load Data
data <- read.csv("C:\\Users\\wliu\\Documents\\GitHub\\data-analysis-examples\\R\\reshape\\sales.csv", header=TRUE)
head(data)


### Convert Formats
data$Order.Date <- as.Date(data$Order.Date, "%m/%d/%Y")
data$Order.Amount <- sub(",","", data$Order.Amount)  # Replace commas
data$Order.Amount <- as.numeric(sub("$","", data$Order.Amount, fixed=TRUE))  # Replace $ without using regular expressions
#data$Order.Amount <-gsub("([/$,])", "", data$Order.Amount)  # Replace , $ with regex
head(data)


### AGGREGATE
### aggregate(formula, data, FUN, ..., subset, na.action=na.omit)
# simple aggregate (i.e. pivot on Salesperson for x, and Amount for y)
data.a <- aggregate(Order.Amount ~ Salesperson, data=data, FUN=sum)
head(data.a)

# aggregate and filtering data using subset
data.b <- aggregate(Order.Amount ~ Salesperson, data=data, FUN=sum, subset=(Country=="USA"))
head(data.b)

# aggregate with more criteria (i.e. pivot on every combination of date and country)
data.c <- aggregate(Order.Amount ~ Order.Date + Country, data=data, FUN=sum)
head(data.c)
### end aggregate

# data before melt
#   Country Salesperson Order.Date OrderID Order.Amount
# 1      UK      Suyama 2003-07-10   10249      1863.40

### MELT
### melt reshapes data, nothing is lost or modified
# assuming col headers: County, Salesperson, Order.Date, OrderID, Order.Amount
data.m <- melt(data, id=c(1:4), measure=c(5))  # measure is Order.Amount

head(data.m)  # 'melts' the column (Order.Amount) into variable and value cols
#   Country Salesperson Order.Date OrderID     variable   value
# 1      UK      Suyama 2003-07-10   10249 Order.Amount 1863.40


### CAST
# cast(data, formula=... ~ variable, fun.aggregate=NULL, ..., margins=FALSE, subset=TRUE)
# think of formula as: what_do_you_want_as_rows ~ what_do_you_want_as_cols

# simple cast
data.d <- cast(data.m, Salesperson ~ variable, sum)
head(data.d)
#  Salesperson Order.Amount
# 1    Buchanan     68792.25

# cast and show grand totals
data.e <- cast(data.m, Salesperson ~ variable, sum, margins=c("grand_row"))
data.e  # shows final column '(all)'
#  Salesperson Order.Amount
# 1    Buchanan     68792.25
#10       (all)   1228327.40

# cast and show grand totals, filter too
data.f <- cast(data.m, Salesperson ~ variable, sum, margins=c("grand_row", subset=(Country=="USA")))
#    Salesperson Order.Amount
# 1     Buchanan     68792.25
#10       (all)   1228327.40
