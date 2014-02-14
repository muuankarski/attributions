load("~/workspace/lits/attributions/data/lits.RData")
library(survey)
d.df <- svydesign(id = ~SerialID, 
                  weights = ~weight, 
                  data = df)



t <- data.frame(prop.table(svytable(~group_general+cntry+q309, d.df), 2)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)

### testailua
# maa <- subset(t, q309 == "Not stated")
# maa <- maa[order(maa$group_general),]
# t$cntry <- factor(t$cntry, levels=maa$cntry)
# library(ggplot2)
# ggplot(t, aes(x=cntry,y=Freq,group=cntry)) +
#   geom_bar(stat="identity", position="dodge") +
#   facet_wrap(~q309) + coord_flip()
####
library(reshape2)
t2 <-  dcast(t, group_general+cntry ~ q309, value.var="Freq")
names(t2) <-  c("group_general","country","socialBlame","individualBlame",
                "individualFate","socialFate","notStated","dontKnow")
t2 <- t2[,c(1,2,3,4,6,5,7,8)]
t2 <- t2[order(-t2$socialBlame),]
########
#t2$group_general <- NULL

#---------------------------------------------------#
#---------------------------------------------------#
#---------------------------------------------------#
#---------------------------------------------------#

# t <- data.frame(prop.table(svytable(~group_general+cntry+poverty, d.df), 2)*100)
# t$Freq <- round(t$Freq, 2)
# t <- subset(t, Freq > 0)
# t2 <-  dcast(t, group_general+cntry ~ poverty, value.var="Freq")
# names(t2) <-  c("group_general","country","socialBlame","individualBlame","individualFate","socialFate")
# t2 <- t2[order(t2$group,-t2$socialBlame),]
########
y <- data.frame(prop.table(svytable(~group_general+q309, d.df), 1)*100)
y$Freq <- round(y$Freq, 2)
y$country <- c("CEE mean","CIS mean","Western Europe mean")
y2 <-  dcast(y, group_general+country ~ q309, value.var="Freq")
names(y2) <-  c("group_general","country","socialBlame","individualBlame",
                "individualFate","socialFate","notStated","dontKnow")
y2 <- y2[,c(1,2,3,4,6,5,7,8)]
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
#
func.CV <- function(t2)
{
    return(data.frame(CV.nt = co.var(t2$notStated)))
}
df.CV.nt <- ddply(t2, .(group_general), func.CV)
#
func.CV <- function(t2)
{
    return(data.frame(CV.dk = co.var(t2$dontKnow)))
}
df.CV.dk <- ddply(t2, .(group_general), func.CV)
##
df.CV <- merge(df.CV.sb,df.CV.ib,by="group_general")
df.CV <- merge(df.CV,df.CV.sf,by="group_general")
df.CV <- merge(df.CV,df.CV.if,by="group_general")
df.CV <- merge(df.CV,df.CV.nt,by="group_general")
df.CV <- merge(df.CV,df.CV.dk,by="group_general")
##
df.CV$group_general <- as.character(df.CV$group_general)

df.CV$group_general[df.CV$group_general == 'CEE'] <- 'CV CEE' 
df.CV$group_general[df.CV$group_general == 'CIS'] <- 'CV CIS' 
df.CV$group_general[df.CV$group_general == 'Western Europe'] <- 'CV Western Europe' 

##
names(df.CV) <- c("country","socialBlame","individualBlame","socialFate",
                  "individualFate","notStated","dontKnow")
df.CV$group_general <- c("CV","CV","CV")
df.CV <- df.CV[,c(8,1,2,3,4,5,6,7)]

tbl5 <- rbind(t2,y2,df.CV)
#t5 <- arrange(t5, group_general,country)
tbl5$group_general <- NULL
tbl5[,2:7] <- round(tbl5[,2:7],1)
