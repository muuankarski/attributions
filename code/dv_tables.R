load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
library(survey)
d.df <- svydesign(id = ~SerialID, 
                  weights = ~weight, 
                  data = df)



t <- data.frame(prop.table(svytable(~group_general+cntry+q309, d.df), 2)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)

### testailua
maa <- subset(t, q309 == "Not stated")
maa <- maa[order(maa$group_general),]
t$cntry <- factor(t$cntry, levels=maa$cntry)
library(ggplot2)
ggplot(t, aes(x=cntry,y=Freq,group=cntry)) +
  geom_bar(stat="identity", position="dodge") +
  facet_wrap(~q309) + coord_flip()
####
library(reshape2)
t2 <-  dcast(t, group_general+cntry ~ q309, value.var="Freq")
names(t2) <-  c("group_general","country","social.blame","individual.blame","individual.fate","dont.know","social.fate","not.stated")
tbl2 <- t2[order(-t2$social.blame),]
########
tbl2$group_general <- NULL

#---------------------------------------------------#
#---------------------------------------------------#
#---------------------------------------------------#
#---------------------------------------------------#

t <- data.frame(prop.table(svytable(~group_general+cntry+poverty, d.df), 2)*100)
t$Freq <- round(t$Freq, 2)
t <- subset(t, Freq > 0)
t2 <-  dcast(t, group_general+cntry ~ poverty, value.var="Freq")
names(t2) <-  c("group_general","country","socialBlame","individualBlame","individualFate","socialFate")
t2 <- t2[order(t2$group,-t2$socialBlame),]
########
y <- data.frame(prop.table(svytable(~group_general+poverty, d.df), 1)*100)
y$Freq <- round(y$Freq, 2)
y$country <- c("CEE Total","CIS Total","Western Europe Total")
y2 <-  dcast(y, group_general+country ~ poverty, value.var="Freq")
names(y2) <-  c("group_general","country","socialBlame","individualBlame","individualFate","socialFate")
#
#
library(plyr)
co.var<-function(x)(100*sd(x)/mean(x)) 
#
func.CV <- function(t2)
{
  return(data.frame(CV.sb = co.var(t2$socialBlame)))
}
df.CV.sb <- ddply(t2, .(group_general), func.CV)
#
func.CV <- function(t2)
{
  return(data.frame(CV.ib = co.var(t2$individualBlame)))
}
df.CV.ib <- ddply(t2, .(group_general), func.CV)
#
func.CV <- function(t2)
{
  return(data.frame(CV.sf = co.var(t2$socialFate)))
}
df.CV.sf <- ddply(t2, .(group_general), func.CV)
#
func.CV <- function(t2)
{
  return(data.frame(CV.if = co.var(t2$individualFate)))
}
df.CV.if <- ddply(t2, .(group_general), func.CV)
##
df.CV <- join(df.CV.sb,df.CV.ib,by="group_general")
df.CV <- join(df.CV,df.CV.sf,by="group_general")
df.CV <- join(df.CV,df.CV.if,by="group_general")
##
df.CV$group_general <- as.character(df.CV$group_general)
library(car)
df.CV$group_general <- recode(df.CV$group_general, "'CEE'='CV CEE';
                        'CIS'='CV CIS';
                        'Western Europe'='CV Western Europe'")
##
names(df.CV) <- c("country","socialBlame","individualBlame","socialFate","individualFate")
df.CV$group_general <- c("CV","CV","CV")

tbl5 <- rbind(t2,y2,df.CV)
#t5 <- arrange(t5, group_general,country)
tbl5$group_general <- NULL
tbl5[,2:5] <- round(tbl5[,2:5],1)
