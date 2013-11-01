load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
tbl <- macro[, c(1,8:14)]
tbl[,c(2:7)] <- round(tbl[,c(2:7)], 2)
tbl <- tbl[order(tbl$undp_hdi), ]
names(tbl) <- c("country","GDP Change 2007-1010","Failed States Index",
                "Voice And Accountability (WB)","HDI","Democracy (Freedom House)",
                "Gini UNU Wider","Country group")