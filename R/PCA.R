setwd("PATH") # erased
data<-read.csv("fdataset_1900.csv")
data_n=na.omit(data[,-1])
data_n
attach(data_n)

model<-lm(borrow~sub_r+sub_a+bus_r+bus_a+po_pass+po_home, data=data_n)
model
summary(model)

data_n=cbind(cyl=borrow+return, sub=sub_r+sub_a, bus=bus_r+bus_a, data_n)
data_n

model<-lm(cyl~sub+bus, data=data_n)
summary(model)

 