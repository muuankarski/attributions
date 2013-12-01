
setwd("~/workspace/lits/attributions")
library(knitr)
library(markdown)
#
knit('index.Rmd','README.md')
knit2html('index.Rmd', 
          stylesheet="~/workspace/web/css/rmarkdown.css",
          options = c('toc', markdown::markdownHTMLOptions(TRUE)))
#
knit2html('loadClean.Rmd', 
          stylesheet="~/workspace/web/css/rmarkdown.css",
          options = c('toc', markdown::markdownHTMLOptions(TRUE)))
#
knit2html('finalPlots.Rmd', 
          stylesheet="~/workspace/web/css/rmarkdown.css",
          options = c('toc', markdown::markdownHTMLOptions(TRUE)))
#
knit2html('descriptive_analysis.Rmd', 
          stylesheet="~/workspace/web/css/rmarkdown.css",
          options = c('toc', markdown::markdownHTMLOptions(TRUE)))
#
library(knitr)
library(markdown)
knit2html('compareWaves.Rmd', 
          stylesheet="~/workspace/web/css/rmarkdown.css",
          options = c('toc', markdown::markdownHTMLOptions(TRUE)))
#
knit2html('mapPlots.Rmd', options = c('toc', markdown::markdownHTMLOptions(TRUE)))
#
library(knitr)
library(markdown)
knit2html('regressionModelling.Rmd', 
          stylesheet="~/workspace/web/css/rmarkdown.css",
          options = c('toc', markdown::markdownHTMLOptions(TRUE)))
