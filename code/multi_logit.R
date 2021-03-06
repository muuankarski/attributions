setwd("~/workspace/lits/attrib/attrib_year2013/code")

#########################################
load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
# malleista länkkärit pois!
df.multi <- subset(df, group_general %in% c("CEE","CIS"))

library(lme4)
summary(soc.0 <- glmer(pov.log.social ~ (1|cntry),
                      family = binomial(logit)(logit),
                       data=df.multi))
summary(soc.1 <- glmer(pov.log.social ~ incsour3+edu2+income2+
                         past.diff+future.diff+crise+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))
summary(soc.2 <- glmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw_gini+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))
summary(soc.3 <- glmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw_gini+gdpchange07.10+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))
summary(soc.4 <- glmer(pov.log.social ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw_gini+gdpchange07.10+wbgi_vae+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))


summary(ind.0 <- glmer(pov.log.individual ~ (1|cntry),
                      family = binomial(logit),
                       data=df.multi))
summary(ind.1 <- glmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+(1|cntry),
                      family = binomial(logit),
                       data=df.multi))
summary(ind.2 <- glmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw_gini+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))
summary(ind.3 <- glmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw_gini+gdpchange07.10+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))
summary(ind.4 <- glmer(pov.log.individual ~ incsour3+edu2+income2+
                        past.diff+future.diff+crise+
                        uw_gini+gdpchange07.10+wbgi_vae+(1|cntry),
                       family = binomial(logit),
                       data=df.multi))