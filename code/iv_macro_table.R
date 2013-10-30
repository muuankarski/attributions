load("~/workspace/lits/attrib/attrib_year2013/data/lits.RData")
tbl <- macro[, c(1,8:14)]
tbl[,c(2:7)] <- round(tbl[,c(2:7)], 2)
tbl <- tbl[order(tbl$undp_hdi), ]
names(tbl) <- c("country","GDP Change 2007-1010","Failed States Index",
                "Voice And Accountability (WB)","HDI","Democracy (Freedom House)",
                "Gini UNU Wider","Country group")


Data <- c("Ghange in total GDP 2007 – 2010",
          "Gini coefficient",
          "Voice and Accountability")
Description <- c("Relative change from 2007 to 2010",
                 "measures the distribution of income or consumption expenditure among individuals or households within an economy deviates from a perfectly equal distribution",
                 "indicators measuring the political process, civil liberties and political rights. These indicators measure the extent to which citizens of a country are able to participate in the selection of governments. Indicators measuring the independence of the media is also included.")
Source <- c("World Bank (Quality of Government Data)",
            "World Bank (Quality of Government Data)",
            "World Bank (Quality of Government Data)")
Varname <- c("wdi_gdp",
             "uw_gini",
             "wbgi_vae")
# Year <- c("2011",
#            "Latest available gini coefficient based either on income or consumption",
#            "2011")
macrotable <- data.frame(Data,Description,Source,Varname)


# Data & Description & Source & Year
# & $  $ & \href{http://data.worldbank.org/data-catalog/world-development-indicators}{World Bank World Development Indicators} & 2011 \\
# &  & \href{http://www.wider.unu.edu/research/Database/en_GB/database/}{UNU-WIDER World Income Inequality Database, Version 2.0c, May 2008} & 2002-2006 \\
# & . & \href{http://en.wikipedia.org/wiki/Democracy_Index#2011_rankings}{Economist Intelligence Unit} & 2011 \\