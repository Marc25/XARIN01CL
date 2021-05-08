library('rmarkdown')
library(ggplot2)
rm(list=ls())
source("DMODEX01_LOANS.R")

# Automate
# How can you automate the process of opening the document and changing the parameter value by hand?
# You can supply a different value via the params argument of render() from the {rmarkdown} package:
pathf <- ("/cloud/project/")
rmarkdown::render(input = paste0(pathf,'XARIN01CL_P02.Rmd'),
                  params = reportS)
