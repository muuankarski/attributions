setwd("~/workspace/lits/attrib/attrib_year2013/code")

#########################################
load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
library(lme4)
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
summary(bisoc.8 <- lmer(pov.log.social ~ uw_gini+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.9 <- lmer(pov.log.social ~ gdpchange07.10+(1|cntry),
                        family = binomial, data=df))
summary(bisoc.10 <- lmer(pov.log.social ~ wbgi_vae+(1|cntry),
                         family = binomial, data=df))

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
summary(biind.8 <- lmer(pov.log.individual ~ uw_gini+(1|cntry),
                        family = binomial, data=df))
summary(biind.9 <- lmer(pov.log.individual ~ gdpchange07.10+(1|cntry),
                        family = binomial, data=df))
summary(biind.10 <- lmer(pov.log.individual ~ wbgi_vae+(1|cntry),
                         family = binomial, data=df))
