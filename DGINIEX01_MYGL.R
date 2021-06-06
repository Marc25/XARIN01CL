# My Project Example Gini and Lorentz tutorial
# Data : Url Source ----
# https://jackblun.github.io/Globalinc/ 
# Librarys ----
library(data.table)
path1 <-  c("/cloud/project/data/")
#Global Income Distribution since 1980
data <- read.csv2(paste0(path1,"GCIPrawdata.txt"), sep=",")
View(data)
data <- data.table(data)
data[which.max(Decile.9.Income),]
data[which.max(Mean.Income),]

