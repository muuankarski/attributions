# text table

Variable <- c("Transfer dependency","Low education","Perceived low income level","Income compared to past","Income compared to future","Effect of financial crises")
Description <- c("Social or private transfers \n as main source of income","No or only compulsory level education","Perceived income level below the country median","Perceived change in income compared to situation in four years ago","Expected change in income over the next four years","Whether respondents perceives that their household has suffered the financial crisis great or fair amount")
Varname <- c("q226m","q515","q227","q228","q229","q801")
table <- data.frame(Variable,Description,Varname)

# numeric table

load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
library(survey)
d.df <- svydesign(id = ~SerialID, 
                  weights = ~weight, 
                  data = df)
# Country group
t <- data.frame(prop.table(svytable(~group_general+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, group_general ~ q309_rec, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
cgroup <- t2
# PAst difference
t <- data.frame(prop.table(svytable(~past.diff+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, past.diff ~ q309_rec, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
past.diff <- t2
# Future difference
t <- data.frame(prop.table(svytable(~future.diff+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, future.diff ~ q309_rec, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
future.diff <- t2
# Low education
t <- data.frame(prop.table(svytable(~edu2+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, edu2 ~ q309_rec, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
edu2 <- t2
# Crisis
t <- data.frame(prop.table(svytable(~crise+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, crise ~ q309_rec, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
crise <- t2
# Transfer dependency
t <- data.frame(prop.table(svytable(~incsour3+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, incsour3 ~ q309_rec, value.var="Freq")
names(t2) <- c("value","Social Blame","Individual Blame","Individual Fate","Social Fate")
incsour3 <- t2
# Low income
t <- data.frame(prop.table(svytable(~income2+q309_rec, d.df), 1)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
library(reshape2)
t2 <-  dcast(t, income2 ~ q309_rec, value.var="Freq")
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