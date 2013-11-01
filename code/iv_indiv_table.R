
# numeric table

load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
library(survey)
d.df <- svydesign(id = ~SerialID, 
                  weights = ~weight, 
                  data = df)
# Country group
t <- data.frame(prop.table(svytable(~group_general+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, group_general ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
cgroup <- t2
# PAst difference
t <- data.frame(prop.table(svytable(~past.diff+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, past.diff ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
past.diff <- t2
# Future difference
t <- data.frame(prop.table(svytable(~future.diff+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, future.diff ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
future.diff <- t2
# Low education
t <- data.frame(prop.table(svytable(~edu2+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, edu2 ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
edu2 <- t2
# Crisis
t <- data.frame(prop.table(svytable(~crise+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, crise ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
crise <- t2
# Transfer dependency
t <- data.frame(prop.table(svytable(~incsour3+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, incsour3 ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
incsour3 <- t2
# Low income
t <- data.frame(prop.table(svytable(~income2+poverty, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, income2 ~ poverty, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
income2 <- t2
#cnamesNewrow <- c("incsour3","Social Blame","Individual Blame","Individual Fate","Social Fate")
#newrowData <- c("Income Source","","","","")
#h <- data.frame(cnamesNewrow,newrowData)
combine <- rbind(cgroup,incsour3,edu2,income2,past.diff,future.diff,crise)
variable <- c("Country group","","",
        "Transfer Dependency","",
        "Education","",
        "Perceived income","",
        "Perceived change in income compared 4 years ago","",
        "Expected change in income in 4 years time","",
        "Perceived effect of financial crises","")
tbl <- cbind(variable,combine)