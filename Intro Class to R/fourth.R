# Simple Regression Formula: y=mx+b or y=a+b*x
require(UsingR)
head(father.son) # Heights of Father and Son
require(ggplot2)
ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point() + geom_smooth(method="lm")
heightMod <- lm(sheight ~ fheight, data=father.son)
summary(heightMod)
?father.son
# r^2 is highly dependent on your field; amount of variation that your model explains (e.g. .9 okay for physics, .2 good for social science)

housing <- read.table("http://www.jaredlander.com/data/housing.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)
View(housing)

names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt", "SqFt", "Income", "IncomePerSqFt", "Expense", "ExpensePerSqFt", "NetIncome", "Value", "ValuePerSqFt", "Boro")
ggplot(housing, aes(x=ValuePerSqFt)) + geom_histogram() # Plot ValuePerSqFt 
ggplot(housing, aes(x=ValuePerSqFt)) + geom_histogram(aes(fill=Boro)) # Plot ValuePerSqFt by color on Boro

housing <- housing[housing$Units < 1000, ] # Want to throw out outliers of buildings with 1000+ units
houseMod1 <- lm(ValuePerSqFt ~ Units + SqFt + Boro, data=housing) #Need to come up with coefficients/slopes for each of these variables

summary(houseMod1)
require(coefplot)
coefplot(houseMod1) # Plot
coefplot(houseMod1, lwdOuter=0, lwdInner=1, sort="mag") # Sort by magnitude, relative to the Bronx
head(model.matrix(~Boro, data=housing))
houseMod2 <- lm(ValuePerSqFt ~ Units * SqFt + Boro, data=housing)
houseMod3 <- lm(ValuePerSqFt ~ Units:SqFt + Boro, data=housing)
houseMod4 <- lm(ValuePerSqFt ~ SqFt * Units * Income, data=housing)
houseMod5 <- lm(ValuePerSqFt ~ Class * Boro, data=housing)

#Differences between *, :, and multiple variables
head(model.matrix(ValuePerSqFt ~ Units * SqFt, data=housing)) #With * returns computations and original
head(model.matrix(ValuePerSqFt ~ Units : SqFt, data=housing)) #With : returns specific column of computations
head(model.matrix(ValuePerSqFt ~ SqFt * Units * Income, data=housing)) #Working with three variables
head(model.matrix(ValuePerSqFt ~ I(Units^2) * SqFt, data=housing)) #Squaring all values
house6 <- lm(ValuePerSqFt ~ Units^2 + SqFt, data=housing)
house7 <- lm(ValuePerSqFt ~ Units + SqFt, data=housing)
coef(house6)
coef(house7)
View(model.matrix(ValuePerSqFt ~ Class * Boro, data=housing)) #View data of Class and Boro
unique(housing$Class)
unique(housing$Boro)
multiplot(houseMod1, houseMod2, houseMod3) #Plots location and Mods of three models
AIC(houseMod1, houseMod2, houseMod3, houseMod4, houseMod5) #Lower the number on AIC, the better model


#Making a quick model
houseTest <- housing[1:10,]
houseTrain <- housing[11:nrow(housing),]
house8 <- lm(ValuePerSqFt ~ SqFt * Units * Income + Boro, data=housing)
coefplot(house8)
predict(house8, newdata=houseTest, se.fit=TRUE, interval='prediction')
houseTest[1,]
coef(house8)
mean((houseTest$ValuePerSqFt - predict(house8, newdata=houseTest))^2)
