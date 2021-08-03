#setup
setwd("PATH") # erased
detach(data_n)
data<-read.csv("dataset_1900.csv")
library("Hmisc")

data_n=na.omit(data)
attach(data_n)
data_n=cbind(cyl=borrow+return, sub=sub_r+sub_a, bus=bus_r+bus_a, data_n)

vars<-c('sub', 'sub_r', 'sub_a', 'bus', 'bus_r', 'bus_a', 'cyl', 'borrow', 'return')
pairs(data_n[vars])
corm <- rcorr(as.matrix(data_n))
corm
