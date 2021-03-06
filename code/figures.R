library(ggplot2)
library(gridExtra)
library(plyr)
library(grid)
#########################################
#########################################
setwd("~/workspace/lits/attrib/attrib_year2013/code")
#########################################
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
#########################################
load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
#########################################
#########################################
#########################################
# valitaan vaan kohdemaat

t3 <- subset(macro, group_fine != 'West Europe')
west <- subset(macro, group_fine == 'West Europe')
#t3 <- macro
#########################################
t3$group1 <- "group1"
func <- function(t3)
{
  return(data.frame(COR = cor(t3$social.blame, t3$gdpchange07.10)))
}
df.cor <- ddply(t3, .(group1), func)
t4 <- join(t3,df.cor,by="group1")
cnames <- round(stats:::aggregate.formula(cbind(social.blame, gdpchange07.10) ~ COR, data=t4, mean),2)
plot1 <- ggplot(t4, aes(x=gdpchange07.10, y=social.blame, 
                        label=cntry)) +
  geom_smooth(method=lm, se=FALSE, color="Dim Grey", linetype="dashed", size=0.5) +  
  geom_text(data=cnames, aes(gdpchange07.10,social.blame, label = COR, group=COR), 
            size=2.5, color="black") +
  geom_text(size=2, vjust=-0.8, hjust=0.5) +
  geom_point(size=1.5) +
  geom_point(data=t4, aes(x=gdpchange07.10, 
                          y=social.blame, color=group_general)) +
  # west reference
  geom_point(data=west, aes(x=gdpchange07.10, 
                          y=social.blame, color=group_general)) +
  geom_text(data=west, aes(x=gdpchange07.10, 
                           y=social.blame, label=cntry),
            color="Dim Grey", size=2, vjust=-0.8, hjust=0.5) +
  # west reference
  labs(x = "Change in GDP between 2007 and 2010 (%)", 
       y = "Support for social blame type of explanation (%)") + 
  scale_colour_manual(values=cbPalette) +
  coord_cartesian(xlim=c(-25,100)) +
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_text(size=6)) +
  theme(axis.title.x = element_text(size=6)) +
  theme(axis.text.y = element_text(size=6)) +
  theme(axis.text.x = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(3, "mm"))


func <- function(t3)
{
  return(data.frame(COR = cor(t3$individual.blame, t3$gdpchange07.10)))
}
df.cor <- ddply(t3, .(group1), func)
t4 <- join(t3,df.cor,by="group1")
cnames <- round(stats:::aggregate.formula(cbind(individual.blame, gdpchange07.10) ~ COR, data=t4, mean),2)
plot2 <- ggplot(t4, aes(x=gdpchange07.10, 
                        y=individual.blame, label=cntry)) +
  geom_smooth(method=lm, se=FALSE, color="Dim Grey", linetype="dashed", size=0.5) +  
  geom_text(size=2, vjust=-0.8, hjust=0.5, color="black") +
  geom_text(data=cnames, aes(gdpchange07.10,individual.blame, label = COR, group=COR), 
            size=2.5, color="black") +
  geom_point(size=1.5) +
  geom_point(data=t4, aes(x=gdpchange07.10, 
             y=individual.blame, color=group_general)) +
  # west reference
  geom_point(data=west, aes(x=gdpchange07.10, 
                            y=individual.blame, color=group_general)) +
  geom_text(data=west, aes(x=gdpchange07.10, 
                           y=individual.blame, label=cntry),
            color="Dim Grey", size=2, vjust=-0.8, hjust=0.5) +
  # west reference
  labs(x = "Change in GDP between 2007 and 2010 (%)", 
       y = "Support for individual blame type of explanation (%)") +
  scale_colour_manual(values=cbPalette) +
  coord_cartesian(xlim=c(-25,100)) +
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_text(size=6)) +
  theme(axis.title.x = element_text(size=6)) +
  theme(axis.text.y = element_text(size=6)) +
  theme(axis.text.x = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(3, "mm"))

pdf("../figure/scatter_gdp.pdf", width=14/2.54, height=10/2.54)
grid.arrange(plot1,plot2, ncol=2)
dev.off()

ppi <- 300
png("../figure/scatter_gdp.png", width=14/2.54*ppi, height=10/2.54*ppi, res=ppi)
grid.arrange(plot1,plot2, ncol=2)
dev.off()


#########################################
#########################################
#########################################
# UNU-Wider Gini

func <- function(t3)
{
  return(data.frame(COR = cor(t3$social.blame, t3$uw_gini)))
}
df.cor <- ddply(t3, .(group1), func)
t4 <- join(t3,df.cor,by="group1")
cnames <- round(stats:::aggregate.formula(cbind(social.blame, uw_gini) ~ COR, data=t4, mean),2)
plot1 <- ggplot(t4, aes(x=uw_gini, y=social.blame, label=cntry)) +
  geom_smooth(method=lm, se=FALSE, color="Dim Grey", linetype="dashed", size=0.5) +  
  geom_text(size=2, vjust=-0.8, hjust=0.5) +
  geom_text(data=cnames, aes(uw_gini,social.blame, label = COR, group=COR), 
            size=2.5, color="black") +
  labs(x = "Gini coefficient", 
       y = "Support for social blame type of explanation (%)") +
  geom_point(size=1.5) +
  geom_point(data=t4, aes(x=uw_gini, 
                          y=social.blame, color=group_general)) +
  # west reference
  geom_point(data=west, aes(x=uw_gini, 
                            y=social.blame, color=group_general)) +
  geom_text(data=west, aes(x=uw_gini, 
                           y=social.blame, label=cntry),
            color="Dim Grey", size=2, vjust=-0.8, hjust=0.5) +
  # west reference
  scale_colour_manual(values=cbPalette) +
  coord_cartesian(xlim=c(20,60)) +
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_text(size=6)) +
  theme(axis.title.x = element_text(size=6)) +
  theme(axis.text.y = element_text(size=6)) +
  theme(axis.text.x = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(3, "mm"))

func <- function(t3)
{
  return(data.frame(COR = cor(t3$individual.blame, t3$uw_gini)))
}
df.cor <- ddply(t3, .(group1), func)
t4 <- join(t3,df.cor,by="group1")
cnames <- round(stats:::aggregate.formula(cbind(individual.blame, uw_gini) ~ COR, data=t4, mean),2)
plot2 <- ggplot(t4, aes(x=uw_gini, y=individual.blame, label=cntry)) +
  geom_smooth(method=lm, se=FALSE, color="Dim Grey", linetype="dashed", size=0.5) +  
  geom_text(size=2, vjust=-0.8, hjust=0.5) +
  geom_text(data=cnames, aes(uw_gini,individual.blame, label = COR, group=COR), 
            size=2.5, color="black") +
  labs(x = "Gini coefficient", 
       y = "Support for individual blame type of explanation (%)") +
  geom_point(size=1.5) +  
  geom_point(data=t4, aes(x=uw_gini, 
                          y=individual.blame, color=group_general)) +
  # west reference
  geom_point(data=west, aes(x=uw_gini, 
                            y=individual.blame, color=group_general)) +
  geom_text(data=west, aes(x=uw_gini, 
                           y=individual.blame, label=cntry),
            color="Dim Grey", size=2, vjust=-0.8, hjust=0.5) +
  # west reference
  scale_colour_manual(values=cbPalette) +
  coord_cartesian(xlim=c(20,60)) +
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_text(size=6)) +
  theme(axis.title.x = element_text(size=6)) +
  theme(axis.text.y = element_text(size=6)) +
  theme(axis.text.x = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(3, "mm"))

pdf("../figure/scatter_gini.pdf", width=14/2.54, height=10/2.54)
grid.arrange(plot1,plot2, ncol=2)
dev.off()

ppi <- 300
png("../figure/scatter_gini.png", width=14/2.54*ppi, height=10/2.54*ppi, res=ppi)
grid.arrange(plot1,plot2, ncol=2)
dev.off()

#########################################
#########################################
#########################################
# World Bank - Voice and Accountability

func <- function(t3)
{
  return(data.frame(COR = cor(t3$social.blame, t3$wbgi_vae)))
}
df.cor <- ddply(t3, .(group1), func)
t4 <- join(t3,df.cor,by="group1")
cnames <- round(stats:::aggregate.formula(cbind(social.blame, wbgi_vae) ~ COR, data=t4, mean),2)
plot1 <- ggplot(t4, aes(x=wbgi_vae, y=social.blame, 
                        label=cntry)) +
  geom_smooth(method=lm, se=FALSE, color="Dim Grey", linetype="dashed", size=0.5) +
  geom_text(size=2, vjust=-0.8, hjust=0.5) +
  geom_text(data=cnames, aes(wbgi_vae,social.blame, label = COR, group=COR), 
            size=2.5, color="black") +
  labs(x = "Voice and Accountability Index 2011", 
       y = "Support for social blame type of explanation (%)") +
  geom_point(size=1.5) +
  geom_point(data=t4, aes(x=wbgi_vae, 
                          y=social.blame, color=group_general)) +
  # west reference
  geom_point(data=west, aes(x=wbgi_vae, 
                            y=social.blame, color=group_general)) +
  geom_text(data=west, aes(x=wbgi_vae, 
                           y=social.blame, label=cntry),
            color="Dim Grey", size=2, vjust=-0.8, hjust=0.5) +
  # west reference
  scale_colour_manual(values=cbPalette) +
  coord_cartesian(xlim=c(-2,2)) +
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_text(size=6)) +
  theme(axis.title.x = element_text(size=6)) +
  theme(axis.text.y = element_text(size=6)) +
  theme(axis.text.x = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(3, "mm"))

func <- function(t3)
{
  return(data.frame(COR = cor(t3$individual.blame, t3$wbgi_vae)))
}
df.cor <- ddply(t3, .(group1), func)
t4 <- join(t3,df.cor,by="group1")
cnames <- round(stats:::aggregate.formula(cbind(individual.blame, wbgi_vae) ~ COR, data=t4, mean),2)
plot2 <- ggplot(t4, aes(x=wbgi_vae, 
                        y=individual.blame, label=cntry)) +
geom_smooth(method=lm, se=FALSE, color="Dim Grey", linetype="dashed", size=0.5) +
  geom_text(size=2, vjust=-0.8, hjust=0.5) +
  geom_text(data=cnames, aes(wbgi_vae,individual.blame, label = COR, group=COR), 
            size=2.5, color="black") +
  labs(x ="Voice and Accountability Index 2011", 
       y = "Support for individual blame type of explanation (%)") +
  geom_point(size=1.5) +
  geom_point(data=t4, aes(x=wbgi_vae, 
                          y=individual.blame, color=group_general)) +
  # west reference
  geom_point(data=west, aes(x=wbgi_vae, 
                            y=individual.blame, color=group_general)) +
  geom_text(data=west, aes(x=wbgi_vae, 
                           y=individual.blame, label=cntry),
            color="Dim Grey", size=2, vjust=-0.8, hjust=0.5) +
  # west reference
  scale_colour_manual(values=cbPalette) +
  coord_cartesian(xlim=c(-2,2)) +
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_text(size=6)) +
  theme(axis.title.x = element_text(size=6)) +
  theme(axis.text.y = element_text(size=6)) +
  theme(axis.text.x = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(3, "mm"))

pdf("../figure/scatter_wbgi.pdf", width=14/2.54, height=10/2.54)
grid.arrange(plot1,plot2, ncol=2)
dev.off()

ppi <- 300
png("../figure/scatter_wbgi.png", width=14/2.54*ppi, height=10/2.54*ppi, res=ppi)
grid.arrange(plot1,plot2, ncol=2)
dev.off()


