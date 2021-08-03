#setup
setwd("PATH") # erased
library(ggplot2)
detach(data_n)
data<-read.csv("dataset_1900.csv")

data_n=na.omit(data)
attach(data_n)
data_n=cbind(cyl=borrow+return, sub=sub_r+sub_a, bus=bus_r+bus_a, data_n)

# 4개 중 지금 하고 있는 시간 실행
data_700=data_n
data_800=data_n
data_1800=data_n
data_1900=data_n


data_all=rbind(data_700, data_800, data_1800, data_1900)
dim(data_all)

boxplot(data_1800$borrow, data_1800$return)
boxplot(data_700$sub_r, data_700$sub_a)
hist(data_all$borrow, col="lightblue", main='출퇴근 시간대 대여소별 대여량 분포',xlab='대여량', ylab='빈도수', xlim=c(0,12000), ylim=c(0,5000))
hist(data_all$return, col="grey", main='출퇴근 시간대 대여소별 반납량 분포',xlab='반납량', ylab='빈도수', xlim=c(0,12000), ylim=c(0,5000))

hist(data_all$cyl)
hist(data_all$sub)
hist(data_all$bus)

# csv로 저장
write.csv(data_700,'data_700n.csv')
write.csv(data_800,'data_800n.csv')
write.csv(data_1800,'data_1800n.csv')
write.csv(data_1900,'data_1900n.csv')




# 날씨-이용량 그래프
detach(package:plyr)
library(plyr)
library(lubridate)
library(dplyr)
setwd("PATH") # erased
dm<-read.csv("서울특별시 공공자전거 이용정보_2019.9.csv")
head(dm)
frq <- dm %>% group_by(대여일자) %>% summarise(frequency = n()) # 9/7: 데이터가 없음, 그래프에서 빼기
write.csv(frq,'201909 이용량.csv')


cd1<-read.csv("서울특별시_공공자전거 일별 대여건수_(2018_2019.03).csv")
cd1[305:455,]
cd2<-read.csv("서울특별시 공공자전거 일별 대여건수(2019.4_5).csv")
cd2
cd3<-read.csv("서울특별시 공공자전거 일별 대여건수_20190601_20191130.csv")
cd3[1:152,]

all<-rbind(cd1[305:455,], cd2, cd3[1:152,])
write.csv(all,'201811-201910 이용량.csv')


temp<-read.csv("201909 temp.csv")
temp
