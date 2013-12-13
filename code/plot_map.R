library(gpclib)
library(RColorBrewer)
library(mapproj)
library(maptools)
library(rgdal)
map <- suppressWarnings(readOGR(dsn="/home/aurelius/workspace/lits/shape/countries_shp", 
               layer="lits_all"))
library(car)
map$NAME <- recode(map$NAME, "'United Kingdom'='Great Britain'")
map$group_general <- recode(map$NAME,
                       "c('France','Germany','Great Britain',
                             'Italy','Sweden')='Western Europe';
                             c('Czech Republic','Estonia','Hungary','Bulgaria',
                             'Latvia','Lithuania','Poland',
                             'Slovakia','Slovenia','Romania')='CEE';
                             c('Armenia','Azerbaijan','Belarus','Georgia','Kazakhstan',
                             'Kyrgyzstan','Moldova','Tajikistan',
                             'Ukraine','Uzbekistan','Russia')='CIS';else=NA")

map$group_fine <- recode(map$NAME,
                    "c('Armenia','Azerbaijan','Georgia') = 'Caucasus';
                         c('Russia','Ukraine','Moldova','Belarus')= 'CIS North';
                         c('Kyrgyzstan','Kazakhstan','Tajikistan','Uzbekistan')='Central Asia';
                         c('Estonia','Latvia','Lithuania')='Baltic States';
                         c('Poland','Czech Republic','Slovakia','Hungary','Slovenia',
                         'Romania','Bulgaria')='CEE EU';
                         c('Italy','Germany','Great Britain','Sweden','France')='West Europe';
                         else='other'")
map$group_fine <- factor(map$group_fine, levels=c('West Europe','CEE EU',
                                                  'Baltic States','CIS North',
                                                  'Caucasus','Central Asia',
                                                  'other'))

# shapefile into data.frame
gpclibPermit() 
map@data$id <- rownames(map@data)
library(ggplot2)
map.points <- fortify(map, region="id")
map.df <- merge(map.points, map@data, by="id")
# only east of longitude -25
map.df <- subset(map.df, long >= -15 & long <= 80)
# names for countries in analysis (excluding others)
namedata <- map.df[!is.na(map.df$group_general),]
cnames <- stats:::aggregate.formula(cbind(long, lat) ~ NAME, data=namedata, mean)
cbPalette <- c("#999999", "#E69F00",
               "#56B4E9", "#009E73",
               "#F0E442", "#0072B2",
               "gray90", "#CC79A7")

mapplot <- ggplot(map.df, aes(long,lat,group=group)) +
  geom_polygon(data = map.df, aes(long,lat), fill="gray90", color = "white") +
  geom_polygon(aes(fill = group_general)) + # or group_fine !!
  scale_fill_manual(values=cbPalette) +
  geom_polygon(data = map.df, aes(long,lat), fill=NA, color = "white") +
  geom_text(data=cnames, aes(long, lat, label = NAME, group=NAME), size=2, color="black") +
  coord_map(project="orthographic") +
  theme_minimal() +
  theme(legend.position="top") +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(axis.text.x = element_blank()) +
  theme(axis.ticks = element_blank()) +
  theme(strip.text = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(5, "mm"))

ppi <- 300
png("../figure/mapplot.png", width=12/2.54*ppi, height=10/2.54*ppi, res=ppi)
mapplot
dev.off()

### Faceted showing population shares of explanations
load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
library(survey)
d.df <- svydesign(id = ~SerialID, 
                  weights = ~weight, 
                  data = df)
t <- data.frame(prop.table(svytable(~group_general+cntry+q309_rec, d.df), 2)*100)
t$Freq <- round(t$Freq, 1)
t <- subset(t, Freq > 0)
t#names(t2) <-  c("group1","country","social.blame","individual.blame","individual.fate","dont.know","social.fate","not.stated")
summary(map.df$NAME)
summary(t$cntry)
map.df.facet <- merge(map.df,t,by.x="NAME",by.y="cntry",all.y=TRUE)
map.df.facet <- map.df.facet[order(map.df.facet$order),]
# for blame explanations only
map.df.facet <- subset(map.df.facet, q309_rec %in% c("Social Blame",
                                                     "Individual Blame"))
summary(map.df.facet$NAME)
mapplotfacet <- ggplot(map.df.facet, aes(long,lat,group=group)) +
  geom_polygon(data = map.df, aes(long,lat), fill="gray90", color = "white") +
  geom_polygon(aes(fill = Freq)) +
  geom_polygon(data = map.df.facet, aes(long,lat), 
               fill=NA, color = "white", size=0.1) +
  #geom_text(data=cnames, aes(long, lat, label = NAME, group=NAME), size=4, color="black") +
  coord_map(project="orthographic") +
  theme_minimal() +
  facet_wrap(~q309_rec)+ 
  theme_minimal() +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=6)) +
  theme(legend.position="top") +
  theme(axis.title.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(axis.text.x = element_blank()) +
  theme(axis.ticks = element_blank()) +
  theme(strip.text = element_text(size=6)) +
  #guides(color = guide_legend(nrow = 2)) +
  theme(legend.key.size = unit(5, "mm"))

ppi <- 300
png("../figure/mapplotfacet.png", width=14/2.54*ppi, height=8/2.54*ppi, res=ppi)
mapplotfacet
dev.off()