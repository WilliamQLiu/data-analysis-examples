1 + 1
(4*6)+5

x <- 2
5 -> y
y
y <- z <- 6
y
z

z <- as.Date("2013-10-04")
z <- as.POSIXct("2013-10-04 10:09")
z

x <- c(3, 5, 1, 5, 4)
x
y <- 1:5
z <- 1:2
x*z

ls()

rm(list=ls())

A <- matrix(1:10, nrow=5)
A
B <- matrix(21:30, nrow=5)
B
D <- matrix(11:20, nrow=5)
D <- matrix(11:20, nrow=2)
D
A+B
A
A %*% D

x <- 1:10
y <- 10:1
q <- c("Hockey", "Lacrosse", "Curling", "Football", "Baseball", "Soccer", "Tennis", "Badminton", "Rugby", "Hockey")
theDF <- data.frame
ls()
this_is_underscore_style = 7
theDF <- data.frame(x,y,q)
theDF
theDF <- data.frame(A=x, B=y, Sport=q)
theDF
names(theDF)

x
x[3]
x[2:3]


x[-c(2,4)]
theDF$B
theDF[,2,drop=FALSE]
theDF[2,3]
theDF
beer <- c("Yuengling", "Heinekin", "Natty Ice", "Yeungling", "Corona", "Super Bock", "PBR", "Corona", "Sapporo")
length(beer)
beerDF <- data.frame(A=1:9, Beer=beer)
beerDF2 <- data.frame(A=1:9, Beer=beer, stringsASFactors=FALSE)
beerDF
beerDF2$Beer
beer <- as.factor(beer)
levels(beer)

as.numeric(beer)
model.matrix(~Beer, data=beerDF)
