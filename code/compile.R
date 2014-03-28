setwd("~/workspace/lits/clone/attributions")
#
pandoc_md <- function(name="index") {
    input <- paste(name,".md", sep="")
    output <- paste(name,".html", sep="")
    system(paste("pandoc -s -S -H /home/aurelius/workspace/web/css/rmarkdown.css",input,"-o",output))
}

library(knitr)
knit("index.Rmd")
system("cp index.md README.md")
pandoc_md('index')