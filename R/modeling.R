setwd("PATH") # erased
library(ggplot2)
detach(data_n) # 다시 할 때만
data<-read.csv("data_1900n.csv")
data_b<-read.csv("data_borrow.csv")
data_r<-read.csv("data_return.csv")

library("dplyr")
library("ggpubr")
library("e1071") 


# 4개 중 지금 하고 있는 시간 실행
data_700=data
data_800=data
data_1800=data
data_1900=data


data_all=rbind(data_700, data_800, data_1800, data_1900)
dim(data_all)

data_all
hist(data_all$cyl)
boxplot(data_all$cyl_mrt)

hist(data_all$cyl)
hist(data_all$cyl_0)
hist(data_all$cyl_rt)
hist(data_all$cyl)


# y 변환
data_b$count_0<-log(data_b$count)
data_b$count_rt<-(data_b$count)^(1/2)
data_b$count_mrt<-(data_b$count)^(-1/2)

data_r$count_0<-log(data_r$count)
data_r$count_rt<-(data_r$count)^(1/2)
data_r$count_mrt<-(data_r$count)^(-1/2)

# histogram
par(mfrow=c(1,2))

hist(data_b$count)
hist(data_b$count_0)
hist(data_b$count_rt)
hist(data_b$count_mrt)

hist(data_r$count)
hist(data_r$count_0)
hist(data_r$count_rt)
hist(data_r$count_mrt)

# boxplot
boxplot(data_b$count, main="b_count")
boxplot(data_b$count_0, main="b_count_0")
boxplot(data_b$count_rt, main="b_count_rt")
boxplot(data_b$count_mrt, main="b_count_mrt")

boxplot(data_r$count, main="r_count")
boxplot(data_r$count_0, main="r_count_0")
boxplot(data_r$count_rt, main="r_count_rt")
boxplot(data_r$count_mrt, main="r_count_mrt")

# density plot
ggdensity(data_b$count)
ggdensity(data_b$count_0)
ggdensity(data_b$count_rt)
ggdensity(data_b$count_mrt)

ggdensity(data_r$count)
ggdensity(data_r$count_0)
ggdensity(data_r$count_rt)
ggdensity(data_r$count_mrt)

# QQ plot
qqPlot(data_b$count)
qqPlot(data_b$count_0)
qqPlot(data_b$count_rt)
qqPlot(data_b$count_mrt)

qqPlot(data_r$count)
qqPlot(data_r$count_0)
qqPlot(data_r$count_rt)
qqPlot(data_r$count_mrt)

# Skewness
skewness(data_b$count)
skewness(data_b$count_0)
skewness(data_b$count_rt)
skewness(data_b$count_mrt)

skewness(data_r$count)
skewness(data_r$count_0)
skewness(data_r$count_rt)
skewness(data_r$count_mrt)

# Kurtosis
kurtosis(data_b$count)
kurtosis(data_b$count_0)
kurtosis(data_b$count_rt)
kurtosis(data_b$count_mrt)

kurtosis(data_r$count)
kurtosis(data_r$count_0)
kurtosis(data_r$count_rt)
kurtosis(data_r$count_mrt)



