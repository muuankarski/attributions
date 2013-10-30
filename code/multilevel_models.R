library(xtable)
library(apsrtable)
library(survey)
library(lme4)
#########################################
#########################################
setwd("~/workspace/lits/attrib/attrib_year2013/code")
#########################################
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#########################################
load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")

summary(bisoc.1 <- lmer(pov.log.social ~ incsour3+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.2 <- lmer(pov.log.social ~ edu2+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.3 <- lmer(pov.log.social ~ income2+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.4 <- lmer(pov.log.social ~ past.diff+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.5 <- lmer(pov.log.social ~ future.diff+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.6 <- lmer(pov.log.social ~ crise+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.7 <- lmer(pov.log.social ~ group1+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.8 <- lmer(pov.log.social ~ uw.gini+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.9 <- lmer(pov.log.social ~ gdpchange07.10+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.10 <- lmer(pov.log.social ~ wbgi.vae+(1|cntry),
                         family = binomial, data=df))


mtable(bisoc.1,bisoc.2,
       bisoc.3,bisoc.4,
       bisoc.5,bisoc.6,
       bisoc.7,bisoc.8,
       bisoc.9,bisoc.10)


summary(biind.1 <- lmer(pov.log.individual ~ incsour3+(1|cntry),
                        family = binomial, data=df))
summary(biind.2 <- lmer(pov.log.individual ~ edu2+(1|cntry),
                        family = binomial, data=df))
summary(biind.3 <- lmer(pov.log.individual ~ income2+(1|cntry),
                        family = binomial, data=df))
summary(biind.4 <- lmer(pov.log.individual ~ past.diff+(1|cntry),
                        family = binomial, data=df))
summary(biind.5 <- lmer(pov.log.individual ~ future.diff+(1|cntry),
                        family = binomial, data=df))
summary(biind.6 <- lmer(pov.log.individual ~ crise+(1|cntry),
                        family = binomial, data=df))
summary(biind.7 <- lmer(pov.log.individual ~ group1+(1|cntry),
                        family = binomial, data=df))
summary(biind.8 <- lmer(pov.log.individual ~ uw.gini+(1|cntry),
                        family = binomial, data=df))
summary(biind.9 <- lmer(pov.log.individual ~ gdpchange07.10+(1|cntry),
                        family = binomial, data=df))
summary(biind.10 <- lmer(pov.log.individual ~ wbgi.vae+(1|cntry),
                         family = binomial, data=df))


mtable(biind.1,biind.2,
       biind.3,biind.4,
       biind.5,biind.6,
       biind.7,biind.8,
       biind.9,biind.10)

summary(soc.0 <- lmer(pov.log.social ~ (1|cntry),
                      family = binomial, data=df))
summary(soc.1 <- lmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+(1|cntry),
                      family = binomial, data=df))
summary(soc.2 <- lmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        (1|cntry), family = binomial, data=df))
summary(soc.3 <- lmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw.gini+(1|cntry),family = binomial, data=df))
summary(soc.4 <- lmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw.gini+gdpchange07.10+(1|cntry),family = binomial, data=df))
summary(soc.5 <- lmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw.gini+gdpchange07.10+wbgi.vae+(1|cntry),family = binomial, data=df))

library(memisc)
mtable("Empty model"=soc.0,
       "Model sb1"=soc.1,
       "Model sb2"=soc.2,
       "Model sb3"=soc.3,
       "Model sb4"=soc.4,
       "Model sb5"=soc.5)

summary(ind.0 <- lmer(pov.log.individual ~ (1|cntry),
                      family = binomial, data=df))
summary(ind.1 <- lmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+(1|cntry),
                      family = binomial, data=df))
summary(ind.2 <- lmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        (1|cntry), family = binomial, data=df))
summary(ind.3 <- lmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw.gini+(1|cntry),family = binomial, data=df))
summary(ind.4 <- lmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw.gini+gdpchange07.10+(1|cntry),family = binomial, data=df))
summary(ind.5 <- lmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw.gini+gdpchange07.10+wbgi.vae+(1|cntry),family = binomial, data=df))


mtable("Empty model"=ind.0,
       "Model ib1"=ind.1,
       "Model ib2"=ind.2,
       "Model ib3"=ind.3,
       "Model ib4"=ind.4,
       "Model ib5"=ind.5)
