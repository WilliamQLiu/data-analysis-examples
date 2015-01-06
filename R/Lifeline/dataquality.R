install.packages("RODBC")
install.packages("plyr")

library(RODBC)  # for odbc connection
library(plyr)  # for count()

# Load data from database
#dbhandle <- odbcDriverConnect('driver={SQL Server};server=mysqlhost;database=mydbname;Uid=myusername;Pwd=mypassword)
dbhandle <- odbcDriverConnect('driver={SQL Server};server=ll-sql-pi01;database=LifelineV2;Uid=test;Pwd=test')

myquery <- sqlQuery(dbhandle, 'SELECT TOP 10000 * FROM LifelineV2.dbo.CallTraceAttempts')
View(myquery)

mycount <- count(myquery, vars="CallGuid")  # returns frequency of each var

mydbgraph <- ggplot(myquery, aes(x=EasternTime, y=CallGuid)) + labels(x="Date", y="Number of Calls")

#mydbgraph + geom_point(stat="identity")

