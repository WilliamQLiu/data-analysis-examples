install.packages("ggplot2")
install.packages("ggthemes")
install.packages("reshape")
install.packages("plyr")

library(reshape)
library(ggplot2)  # for plotting
library(scales)  # for formatting x and y labels
library(ggthemes)  # for plotting themes
library(plyr)  # for renaming


### Load data locally from CSV
#myfile <- read.csv(file="C:\\Users\\wliu\\Desktop\\LifelineSurvey\\survey_data.csv", sep=",", header=TRUE, stringsAsFactors=TRUE)
myfile <- read.csv(file="/Users/williamliu/Dropbox/Lifeline/network_survey/survey_data.csv", header=TRUE)
View(myfile)  # peak at file, make sure everything is okay
View(myfile[,100:200])  # peak at file, make sure everything is okay

typeof(myfile)  # See what file type this field is

### Question 13

### Load columns we want, melt data into shape we want
# Plot Question 13 - "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined..."
data <- myfile[, c("CrisisCenterKey", 
                   "On.average..how.many.calls.per.month.do.you.receive.on.all.your.crisis.center.hotline.s..combined...")]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
typeof(clean_data)

### Reorder to correct order
print(levels(clean_data$value))  # Before ordering  "0 - 100"        "1,001 - 5,000"  "100 - 500"      "10001"          "5,001 - 10,000" "501 - 1,000" 
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,3,6,2,5,4)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 100"        "1,001 - 5,000"  "100 - 500"      "10001"          "5,001 - 10,000" "501 - 1,000"  # After ordering
#qplot(ordered_value)  # Do a quick plot to double check order is correct

### Calculate 1.) frequencies and 2.) percentages
my_freq <- table(ordered_value)  # Create table of frequencies for each categorical
my_freq
my_percent <- as.data.frame(prop.table(table(ordered_value)))  # Create table of percentages for each categorical
my_percent
#write.table(my_freq, file='peek_freq.csv', sep=",", quote=TRUE)  # Write to file
#write.table(my_percent, file='peek_percent.csv', sep=",", quote=TRUE)  # Write to file

### Plot with these colors
my_graph <- ggplot(clean_data) + geom_bar(stat="bin", aes(x=ordered_value))
my_graph <- my_graph + xlab("Average Number of Calls per Month") + ylab("Number of Crisis Centers") +
  ggtitle("Question 13") + 
  expand_limits(y=0)  # Force chart to go down to 0
my_graph  # display graph

# Try different themes
my_graph <- my_graph + theme_fivethirtyeight()
#my_graph <- my_graph + theme_hc()

# Formatting for legend
#my_graph <- my_graph + theme(plot.title = element_text(size=18, face="bold")) + # title
#  theme(axis.text.x=element_text(angle=50, size=14, vjust=0.5)) +  # x-axis
#  theme(legend.title=element_text(size=14, face="bold")) 
#+ #scale_color_discrete(name=clean_data$value) +
#  guides(colour = guide_legend(override.aes = list(size=7))) # legend appear larger
#facet_wrap(~Year, nrow=1)  # split graphs by say Year

my_graph  # Plot

### Question 22
data <- myfile[, c("CrisisCenterKey", 
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.a.formal.relationship.with.one.or.more.ED...contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.an.informal.relationship.with.one.or.more.ED..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.NO.relationship.with.an.ED",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.a.procedure.for.providing.assessment.information.for.callers.we.refer.to.the.ED",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.provide.follow.up.services.for.patients.discharged.from.an.ED",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.provided.training.for.ED.staff.in.risk.assessment",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....We.have.staff.that.are.co.located.in.an.ED.and.work.with.ED.staff.on.risk.assessments.and.or.referrals",
                   "What.is.your.relationship.with.Local.Hospital.Emergency.Departments...please.check.all.that.apply.....Our.agency.organization.provides.emergency.room.services",
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 23
data <- myfile[, c("CrisisCenterKey", 
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.a.formal.relationship.with.one.or.more.MCT.s...contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.an.informal.relationship.with.one.or.more.MCTs..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.NO.relationship.with.an.MCT",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....There.is.NO.MCT.currently.serving.our.area.s.",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....Our.agency.is.formally.designated.by.a.funding.authority.to.dispatch.mobile.crisis.services",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.provide.follow.up.services.for.one.or.more.MCTs",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.have.provided.training.to.MCT.staff.in.risk.assessment",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....We.conduct.risk.assessments.for.MCT.staff",
                   "What.is.your.relationship.with.Mobile.Crisis.Teams..MCT....please.check.all.that.apply.....Our.agency.organization.provides.mobile.crisis.services"                   
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 24
data <- myfile[, c("CrisisCenterKey",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.have.a.formal.relationship.with.local.law.enforcement..contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.have.an.informal.relationship.with.local.law.enforcement..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.have.NO.relationship.with.local.law.enforcement",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....Our.local.law.enforcement.has.a.Crisis.Intervention.Team..CIT..but.we.have.NO.relationship.with.them",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....Our.local.law.enforcement.does.NOT.have.a.CIT",
                   "What.is.your.relationship.with.Law.Enforcement...please.check.all.that.apply.....We.provide.training.to.law.enforcement.for.working.with.persons.that.are.suicidal.and.or.have.behavioral.health.problems"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 25
data <- myfile[, c("CrisisCenterKey",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.have.a.formal.relationship.with.one.or.more.EMS.programs..contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.have.an.informal.relationship.with.one.or.more.EMS.programs...knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.have.NO.relationship.with.local.EMS",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....We.provide.training.to.EMS.personnel",
                   "What.is.your.relationship.with.Ambulance.EMS...please.check.all.that.apply.....Other"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 26
data <- myfile[, c("CrisisCenterKey",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....We.have.a.formal.relationship.with.our.local.911.call.centers..contract.and.or.Memorandum.of.Understanding.",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....We.have.an.informal.relationship.with.our.local..911.call.centers..knowledge.of.and.ability.to.refer.as.a.known.crisis.service.",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....We.have.NO.relationship.with.our.local.911",
                   "What.is.your.relationship.with.Local.911...please.check.all.that.apply.....When.we.refer.callers.at.imminent.risk.to.911..we.have.a.process.in.place.where.they.can.inform.us.if.the.caller.was.seen.and.or.transported"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 27
data <- myfile[, c("CrisisCenterKey",
                   "What.percentage.of.Lifeline.calls.require.that.rescue.be.dispatched."
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))  # "0 - 2%"   "11 - 15%" "16% +"    "3 - 6%"   "7 - 10%"
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,4,5,2,3)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 2%"   "3 - 6%"   "7 - 10%"  "11 - 15%" "16% +"
my_freq <- table(ordered_value)  # Create table of frequencies for each categorical
my_freq

### Question 28
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.track.if.rescue.is.collaborative.voluntary.or.involuntary."
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 29
data <- myfile[, c("CrisisCenterKey",
                   "What.percentage.of.Lifeline.calls.that.your.center.takes.result.in.rescues.that.are.collaborative.voluntary...if.unknown..please.provide.your.best.estimate."
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
print(levels(clean_data$value))  # "0 - 4%"      "10 - 20%"    "20 - 30%"    "30 - 40%"    "40% or more" "5 - 10%"    
ordered_value = factor(clean_data$value, levels(clean_data$value)[c(1,6,2,3,4,5)])  # Reorder the categorical order
print(levels(ordered_value))  # "0 - 4%"      "5 - 10%"     "10 - 20%"    "20 - 30%"    "30 - 40%"    "40% or more"
my_freq <- table(ordered_value)  # Create table of frequencies for each categorical
my_freq

### Question 30
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Community.mental.health.center.or.outpatient.mental.health.clinic"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 31
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Local.emergency.room"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 32
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Mobile.crisis.team"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 33
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Law.enforcement"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 34
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Fire.and.rescue"
              )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 35
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Local.911"
                   )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question 36
data <- myfile[, c("CrisisCenterKey",
                   "Do.you.routinely.obtain.disposition.status.information.about.at.risk.crisis.hotline.callers.from.any.of.the.following.services.....Other.community.service"
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

### Question
data <- myfile[, c("CrisisCenterKey",
                   "Does.your.crisis.center.provide.follow.up.services.to.callers."
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq

data <- myfile[, c("CrisisCenterKey",
                   "If..Yes...how.do.you.support.them."
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq


### Question
data <- myfile[, c("CrisisCenterKey",
                   "Does.your.crisis.center.use.volunteers.as.telephone.workers.or.supervisors.on.your.crisis.hotlines."
                    )]  # Load Data
clean_data = melt(data, id=c("CrisisCenterKey"))  # Melt data so we can 'cast' it into any shape
my_freq <- table(clean_data$value)  # Create table of frequencies for each categorical
my_freq
