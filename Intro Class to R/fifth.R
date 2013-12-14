# Creating a decision tree
require(rpart)
load(url("http://www.jaredlander.com/data/credit.rdata"))
View(credit)

#Loading and saving data as an .rdata
x <- 2
y <- 7
save(x, y, file="myStuff.rdata")
rm(x,y)
x # Can't find object
load("mystuff.rdata")
x

creditTree <- rpart(Credit ~ CreditAmount + Age + CreditHistory + Employment, data=credit) #Load data
class(creditTree) #shows that creditTree is class 'rpart'
typeof(creditTree) #shows that creditTree is part of "list"
require(rpart.plot)
rpart.plot(creditTree, extra=4) #plots a decision tree, extra is how you want the info to be presented
#Also random forest package in R