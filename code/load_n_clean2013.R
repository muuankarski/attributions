##################################################################
##################################################################
##################################################################
# Life in transition survey 2
# load and clean data

# libraries
library(car)
library(stringr)
library(foreign)

# LITS 2
# from web
#temp <- tempfile()
#download.file("http://www.ebrd.com/downloads/research/surveys/lits2.dta", temp)
#lits2 <- read.dta(temp)
# tai 
#lits2 <- read.dta("~/workspace/lits/lits2.dta")
#save.image("~/workspace/lits/lits2.RData")
load("~/workspace/lits/lits2.RData")
##################################################################
##################################################################
## Clean data ##
##################################################################
# different country groupings

# remove whitespaces from country
lits2$cntry <- str_trim(lits2$country_, side="right")
lits2$cntry <- factor(lits2$cntry)

lits2$socialism <- recode(lits2$cntry,
                            "c('France','Germany','Great Britain',
                            'Italy','Sweden')='Market economy';
                            c('Czech Republic','Estonia','Hungary',
                          'Bulgaria','Latvia','Lithuania','Poland',
                          'Slovakia','Slovenia','Romania','Albania',
                          'Bosnia','Bulgaria','Croatia','Macedonia',
                          'Montenegro','Kosovo','Serbia','Armenia',
                          'Azerbaijan','Belarus','Georgia','Kazakhstan',
                          'Kyrgyzstan','Moldova','Mongolia','Russia',
                          'Tajikistan','Ukraine','Uzbekistan')='Post-socialist';
                          else=NA")
lits2$group_analysis <- recode(lits2$cntry,
                             "c('France','Germany','Great Britain',
                             'Italy','Sweden')='Western Europe';
                             c('Czech Republic','Estonia','Hungary','Bulgaria',
                             'Latvia','Lithuania','Poland',
                             'Slovakia','Slovenia','Romania')='CEE';
                             c('Armenia','Azerbaijan','Belarus','Georgia','Kazakhstan',
                             'Kyrgyzstan','Moldova','Tajikistan',
                             'Ukraine','Uzbekistan','Russia')='CIS';else=NA")
# lits2$group_general <- recode(lits2$cntry,
#                              "c('France','Germany','Great Britain',
#                              'Italy','Sweden')='Western Europe';
#                              c('Czech Republic','Estonia','Hungary','Bulgaria',
#                              'Latvia','Lithuania','Poland',
#                              'Slovakia','Slovenia','Romania')='CEE';
#                              c('Armenia','Azerbaijan','Belarus','Georgia','Kazakhstan',
#                              'Kyrgyzstan','Moldova','Tajikistan',
#                              'Ukraine','Uzbekistan','Russia')='CIS';else=NA")
# 
# lits2$group_fine <- recode(lits2$cntry, "c('Armenia','Azerbaijan','Georgia') = 'Caucasus';
#                          c('Russia','Ukraine','Moldova','Belarus')= 'CIS North';
#                          c('Kyrgyzstan','Kazakhstan','Tajikistan','Uzbekistan')='Central Asia';
#                          c('Estonia','Latvia','Lithuania')='Baltic States';
#                          c('Poland','Czech Republic','Slovakia','Hungary','Slovenia',
#                          'Romania','Bulgaria')='CEE EU';
#                          c('Italy','Germany','Great Britain','Sweden','France')='West Europe';
#                          else='other'")

################################
# reason for poverty
################################

################################
lits2$q309 <- as.factor(str_replace(lits2$q309, "Don't know", "Dont know"))

# All options

lits2$q309 <- recode(lits2$q309, "'Because of injustice in our society'='Social Blame';
                         'Because of laziness and lack of willpower'='Individual Blame';
                         'Because they have been unlucky'='Individual Fate';
                         'It is an inevitable part of modern life'='Social Fate';
                         'Not stated'='Not stated';
                         'Dont know'='Dont know'")

lits2$q309 <- factor(lits2$q309, levels=c("Social Blame","Individual Blame",
                                                  "Individual Fate","Social Fate",
                                          "Not stated","Dont know"))

# not stated and dont know coded NA

lits2$q309_rec <- recode(lits2$q309, "'Because of injustice in our society'='Social Blame';
                         'Because of laziness and lack of willpower'='Individual Blame';
                         'Because they have been unlucky'='Individual Fate';
                         'It is an inevitable part of modern life'='Social Fate';
                         c('Not stated','Dont know')=NA")

lits2$q309_rec <- factor(lits2$q309_rec, levels=c("Social Blame","Individual Blame",
                                                  "Individual Fate","Social Fate"))



################################
# $poverty - muuttuja
################################
#lits2$poverty <- recode(lits2$q309_rec, "'It is an inevitable part of modern life'=NA")
lits2$poverty <- lits2$q309_rec

################################
# $pov.log.social
################################
lits2$pov.log.social <- recode(lits2$q309_rec, "'Social Blame'=1;
                               else=0")
################################
# $pov_log_individual
################################
lits2$pov.log.individual <- recode(lits2$q309_rec, "'Individual Blame'=1;
                               else=0")
################################
# $sex - muuttuja
################################
lits2$sex <- lits2$q102_1

################################
# $income
################################

lits2$income <- factor(recode(lits2$q227, 
                           "1:3='Low income'; 
                          4:7='Middle income'; 
                           8:10='High income'; 
                           else=NA"))

lits2$income <- factor(lits2$income, levels=c("Low income","Middle income","High income"))

lits2$income2 <- factor(recode(lits2$q227, 
                              "1:5='Low'; 
                              6:10='High'; 
                              else=NA"))

lits2$income <- factor(lits2$income2, levels=c("Low","High"))


# median(lits2)
#svyquantile(~q227, d.df, quantile = c(0.25, 0.5, 0.75), ci = TRUE)

lits2$q227_rec <- recode(lits2$q227, "-111:0=NA")
################################
# $future
################################
lits2$future <- factor(recode(lits2$q229, 
                              "1:3='a) low income'; 
                          4:7='b) middle income'; 
                              8:10='c) high income'; 
                              else=NA"))

lits2$q229_rec <- recode(lits2$q229, "-100:0=NA")

lits2$future.diff[lits2$q227_rec > lits2$q229_rec] <- 'worse'
lits2$future.diff[lits2$q227_rec <= lits2$q229_rec] <- 'same or better'
lits2$future.diff <- factor(lits2$future.diff)

################################
# $past
################################
lits2$past <- factor(recode(lits2$q228, 
                              "1:3='a) low income'; 
                          4:7='b) middle income'; 
                              8:10='c) high income'; 
                              else=NA"))

lits2$q228_rec <- recode(lits2$q228, "-111:0=NA")

lits2$past.diff[lits2$q227_rec < lits2$q228_rec] <- 'worse'
lits2$past.diff[lits2$q227_rec >= lits2$q228_rec] <- 'same or better'
lits2$past.diff <- factor(lits2$past.diff)

################################
# $age
################################

lits2$ageclass <- factor(recode(lits2$q104a_1, 
                              "1:29='29 or younger'; 
                          30:44='30 to 44'; 
                              45:59='45 to 59';
                              60:120='60 and older';
                                else=NA"))

lits2$ageclass <- factor(lits2$ageclass, levels=c("29 or younger","30 to 44","45 to 59","60 and older"))

lits2$age <- lits2$q104a_1

################################
# $incsour tulonlähde
################################
lits2$q226m_txt <- recode(lits2$q226m, 
                          "1='Salary or wages in cash or in kind';
                                2='Income from self-employment';
                          3='Sales or bartering of farm products';
                          4='Pensions';5='Benefits from the state';
                          6='Help from relatives or friends';7='Other'")

lits2$incsour3 <- factor(recode(lits2$q226m_txt, 
                                "c('Benefits from the state',
                                'Help from relatives or friends')='Dependent'
                                ;else='Not.dependent'"))

################################
# $edu
################################

lits2$edu2 <- factor(recode(lits2$q515, "c(1,2)='no or compulsory';
                           else='higher'"))

#################
# $crise - kriisikokemus
#################
lits2$q801 <- as.factor(str_replace(lits2$q801, "Don't know", "DONT KNOW"))
summary(lits2$q801)
lits2$q801 <- factor(lits2$q801, levels=c("A GREAT DEAL","A FAIR AMOUNT","JUST A LITTLE","NOT AT ALL","DONT KNOW","Refused"))

library(car)
lits2$crise <- recode(lits2$q801, "c('A GREAT DEAL','A FAIR AMOUNT')='Great or fair amount';
                       c('NOT AT ALL','JUST A LITTLE')='Little or not at all';
                       else=NA")

lits2$crise <- factor(lits2$crise, levels=c("Little or not at all",
                                            "Great or fair amount"))
summary(lits2$crise)
################################################################
################################################################
## Data for the analysis
df <- subset(lits2, select=c("SerialID","weight","cntry","country0","q309",
                             "q309_rec","sex",
                             "ageclass","age",
                             "future.diff","past.diff",
                             "pov.log.social",
                             "pov.log.individual",
                             "socialism","incsour3",
                             "edu2",
                             "group_analysis",
                             #"group_general","group_fine",
                             "income2",
                             "crise",
                             "q227", # income
                             "q228", # menneisyys
                             "q229", # tulevaisuus
                             "q226m_txt", # tulonlähde
                             "q515", # edu
                             "q801" # crise,
                             ))
# filter out not wanted countries
df <- df[!is.na(df$group_analysis),] # valitaan vaan group1 -muuttujan maat
df$cntry <- factor(df$cntry)
# print data in csv-format


################################################
################################################
################################################

library(reshape2)
library(survey)
d.df <- svydesign(id = ~SerialID, 
                  weights = ~weight, 
                  data = df)

summary309 <- data.frame(prop.table(svytable(~q309 + cntry, d.df), 2) * 100)
summary309 <- summary309[!is.na(summary309$Freq), ]

summary309w <- dcast(summary309, cntry ~ q309, value.var="Freq")
names(summary309w) <- c("cntry","social.blame","individual.blame","individual.fate","social.fate","not.stated","dont.know")

summary309_rec <- data.frame(prop.table(svytable(~q309_rec + cntry, d.df), 2) * 100)
summary309_rec <- summary309_rec[!is.na(summary309_rec$Freq), ]

summary309_recw <- dcast(summary309_rec, cntry ~ q309_rec, value.var="Freq")
names(summary309_recw) <- c("cntry","social.blame","individual.blame","individual.fate","social.fate")

#######
# Quality of governance
library(rustfare)
datQog <- GetQog(country = c('Armenia','Azerbaijan','Georgia','Russia',
                   'Ukraine','Moldova','Belarus','Kyrgyzstan',
                   'Kazakhstan','Tajikistan',
                   'Uzbekistan','Estonia','Latvia','Lithuania',
                   'Poland','Czech Republic','Slovakia','Hungary',
                   'Slovenia','Romania','Bulgaria',
                   'Italy','Germany','United Kingdom',
                   'Sweden','France'), 
       indicator = c("ffp_fsi", # Failed States Index
                     "wbgi_vae", # World Bank - Voice and Accountability
                     "undp_hdi", # UNDP Human Development Index
                     "fh_polity2", # Democracy (Freedom House/Polity)
                     "uw_gini"))
# subset the latest value per cntry per indicator
library(plyr)
datQogSum <- ddply(datQog, c("cname","indicator"), subset, year == max(year))

library(ggplot2)
ggplot(datQogSum, aes(x=year,y=value,color=cname)) + 
  geom_point() +
  geom_text(data = datQogSum,
            aes(x=year,y=value,color=cname,label=cname)) +
  facet_wrap(~indicator, scales="free") +
  theme(legend.position="none")

datQogSum.w <- dcast(datQogSum, cname ~ indicator, value.var="value")
datQogSum.w$cname <- recode(datQogSum.w$cname, "'United Kingdom'='Great Britain'")

datQogSum.w$group_fine <- recode(datQogSum.w$cname, "c('Armenia','Azerbaijan','Georgia') = 'Caucasus';
                         c('Russia','Ukraine','Moldova','Belarus')= 'CIS North';
                         c('Kyrgyzstan','Kazakhstan','Tajikistan','Uzbekistan')='Central Asia';
                         c('Estonia','Latvia','Lithuania')='Baltic States';
                         c('Poland','Czech Republic','Slovakia','Hungary','Slovenia',
                         'Romania','Bulgaria')='CEE EU';
                         c('Italy','Germany','Great Britain','Sweden','France')='West Europe';
                         else='other'")
datQogSum.w$group_general <- recode(datQogSum.w$cname,
                       "c('France','Germany','Great Britain',
                             'Italy','Sweden')='Western Europe';
                       c('Czech Republic','Estonia','Hungary','Bulgaria',
                       'Latvia','Lithuania','Poland',
                       'Slovakia','Slovenia','Romania')='CEE';
                       c('Armenia','Azerbaijan','Belarus','Georgia','Kazakhstan',
                       'Kyrgyzstan','Moldova','Tajikistan',
                       'Ukraine','Uzbekistan','Russia')='CIS';else=NA")

################################

df.qog <- datQogSum.w
# underschores into dots for latex...
#names <- names(df.qog)
#library(stringr)
#names <- str_replace_all(names, "_",".")
#names(df.qog) <- names
library(gdata)
df.qog <- rename.vars(df.qog, from="cname", to="cntry")


## GDP change from WB
### We need iso2c countrycode
library(countrycode)
cntry <- levels(df$cntry) # countrynames
iso2c <- countrycode(cntry, "country.name", "iso2c")
iso2c # copy paste into WDI search
library(WDI)
# WDIsearch(string='gdp', field='name', cache=NULL)
wb <- WDI(indicator = c("NY.GDP.MKTP.CD"), country = c("AL","AM","AZ","BY","BA","BG","HR",
                                                       "CZ","EE","FR","GE","DE","GB","HU",
                                                       "IT","KZ","KG","LV","LT","MK","MD",
                                                       "MN","ME","PL","RO","RU","RS","SK",
                                                       "SI","SE","TJ","TR","UA","UZ"), 
           start = 2007, end = 2010)

library(reshape2)
names(wb) <- c("iso2c","cntry","var","year")
wb.w <- dcast(wb, cntry ~ year, value.var="var")

names(wb.w) <- c("cntry","x2007","x2008","x2009","x2010")
wb.w$gdpchange07.10 <- wb.w$x2010/wb.w$x2007 * 100 - 100
gdp <- wb.w[,c(1,6)]

gdp$cntry[gdp$cntry == 'Russian Federation'] <- 'Russia'
gdp$cntry[gdp$cntry == 'Kyrgyz Republic'] <- 'Kyrgyzstan'
gdp$cntry[gdp$cntry == 'United Kingdom'] <- 'Great Britain'
gdp$cntry[gdp$cntry == 'Slovak Republic'] <- 'Slovakia'

# yhdistetään nää aikaisempien datojen kanssa
macro <- merge(summary309w,gdp,by="cntry", all.x=TRUE)
macro <- merge(macro,df.qog,by="cntry")

df <- merge(df,macro,by="cntry")

rm(lits2)
rm(df.qog)
rm(df.cross.postsoc)
rm(gdp)
rm(t3)
rm(summary309)
rm(summary309_rec)
rm(d.df)
rm(wb)
rm(wb.w)
rm(cntry)
rm(iso2c)

save.image("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
#load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")





