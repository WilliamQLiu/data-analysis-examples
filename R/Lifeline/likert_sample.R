# Plotting likert scale
# http://jason.bryer.org/likert/

# Load devtools to get github package
install.packages("devtools", dependencies=TRUE)
require(devtools)
install_github('likert', 'jbryer')
require(likert)
ls("package:likert")  # List the types of packages

# Load data (for this example, this is the Programme of International Student Assessment)
data(pisaitems)  
View(pisaitems)

### ITEM 28

# Data cut, format
items28 <- pisaitems[, substr(names(pisaitems), 1, 5) == "ST24Q"]
head(items28)

items28 <- rename(items28, c(ST24Q01 = "I read only if I have to.", 
                             ST24Q02 = "Reading is one of my favorite hobbies.", 
                             ST24Q03 = "I like talking about books with other people.", 
                             ST24Q04 = "I find it hard to finish books.", 
                             ST24Q05 = "I feel happy if I receive a book as a present.", 
                             ST24Q06 = "For me, reading is a waste of time.", 
                             ST24Q07 = "I enjoy going to a bookstore or a library.", 
                             ST24Q08 = "I read only to get information that I need.", 
                             ST24Q09 = "I cannot sit still and read for more than a few minutes.", 
                             ST24Q10 = "I like to express my opinions about books I have read.", 
                             ST24Q11 = "I like to exchange books with my friends"))

l28 <- likert(items28)
summary(l28)

# Simple Plot - Different ways to plot
plot(l28)
plot(l28, centered=FALSE, wrap=30)
plot(l28, type = "density")
plot(l28, type = "heat")

l28g <- likert(items28, grouping = pisaitems$CNT)  # Group Results by Country
print(l28g)
summary(l28g)
plot(l28g)
plot(l28g, include.histogram = TRUE)  # also shows missing and incomplete
plot(l28g, centered = FALSE)
plot(l28g, type = "density")


### ITEM 29

title <- "How often do you read these materials because you want to?"
items29 <- pisaitems[, substr(names(pisaitems), 1, 5) == "ST25Q"]
names(items29) <- c("Magazines", "Comic books", "Fiction", "Non-fiction books", "Newspapers")
View(items29)
l29 <- likert(items29)
summary(l29)

plot(l29) + ggtitle(title)
plot(l29, centered = FALSE) + ggtitle(title)
plot(l29, center = 2.5) + ggtitle(title)

l29g <- likert(items29, grouping = pisaitems$CNT)  # Group Results by Country
summary(l29g)
plot(l29g) + ggtitle(title)
plot(l29g, centered = FALSE, center = 2.5) + ggtitle(title)
plot(l29g, type = "density", legend = "Country") + ggtitle(title)
