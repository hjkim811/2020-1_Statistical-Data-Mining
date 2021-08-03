install.packages("ggplot2")
install.packages("ggmap")
install.packages("raster")
install.packages("rgdal")
install.packages("wesanderson")
library(ggmap)
library(raster)
library(rgdal)
library(wesanderson)
library(data.table)
library(dplyr)
require( lubridate )
citation("ggmap")

register_google(key='KEY') # erased
map <- get_map(location='south korea', zoom=7, maptype='roadmap', color='bw')
map <- get_map(location='seoul', zoom=11, maptype='roadmap', color='bw')
ggmap(map)

setwd("PATH") # erased
df<-read.csv("서울특별시 공공자전거 대여소 정보(19.12.9).csv")
df<-df[-1541,]
head(df)
dim(df)

# 대여소 분포 지도
ggmap(map) + geom_point(data=df, aes(x=lon, y=lat, color=구), size=1)
ggmap(map) + stat_density_2d(data=df, aes(x=lon, y=lat))

# 구 분할 지도
korea <- shapefile('TL_SCCO_SIG.shp')
ggplot() + geom_polygon(data=korea, aes(x=long, y=lat, group=group), fill='white', color='black')

seoul <- korea[korea$SIG_CD <= 11740, ]
ggplot() + geom_polygon(data=seoul, aes(x=long, y=lat, group=group), fill='white', color='black')

# 반납 대여 상위 대여소
setwd("PATH") # erased
df1<-read.csv("data_700n.csv")
df2<-read.csv("data_800n.csv")
df3<-read.csv("data_1800n.csv")
df4<-read.csv("data_1900n.csv")
head(df1)
head(df2)
df1['borrow']

s1<-select(df1, ID, borrow, return)
s2<-select(df2, ID, borrow, return)
s3<-select(df3, ID, borrow, return)
s4<-select(df4, ID, borrow, return)

s<-s1+s2+s3+s4
s['ID']<-s['ID']/4
s

one<-as.vector(s$ID)
two<-as.vector(df$id)
setdiff(two, one) # 결과: 168, 465

dfx<-df[!(df$ID==168 | df$ID==465),]
dfx


total <- merge(dfx,s,by="ID")
head(total)
write.csv(total,'서울특별시 공공자전거 대여소 정보 + 사용량.csv')


# ID 찍어서 지도에 그리기 - 시간대별 이용량 순위
top_all<-read.csv("usage_ranking_전체시간대.csv")
top_7<-read.csv("usage_ranking_7시.csv")
top_8<-read.csv("usage_ranking_8시.csv")
top_18<-read.csv("usage_ranking_18시.csv")
top_19<-read.csv("usage_ranking_19시.csv")

topl_all<-merge(dfx,top_all,by="ID")
topl_7<-merge(dfx,top_7,by="ID")
topl_8<-merge(dfx,top_8,by="ID")
topl_18<-merge(dfx,top_18,by="ID")
topl_19<-merge(dfx,top_19,by="ID")
topl_78<-rbind(topl_7,topl_8)
topl_1819<-rbind(topl_18,topl_19)

ggmap(map) + geom_point(data=topl_all, aes(x=lon, y=lat), color='red3', size=3)
ggmap(map) + geom_point(data=topl_7, aes(x=lon, y=lat), color='red3', size=3)
ggmap(map) + geom_point(data=topl_8, aes(x=lon, y=lat), color='red3', size=3)
ggmap(map) + geom_point(data=topl_18, aes(x=lon, y=lat), color='red3', size=3)
ggmap(map) + geom_point(data=topl_19, aes(x=lon, y=lat), color='red3', size=3)

ggmap(map) + geom_point(data=topl_78, aes(x=lon, y=lat), color='red3', size=4)
ggmap(map) + geom_point(data=topl_1819, aes(x=lon, y=lat), color='red3', size=4)

ggmap(map) + geom_point(data=topl_78, aes(x=lon, y=lat, size=freq), color='red3')
ggmap(map) + geom_point(data=topl_1819, aes(x=lon, y=lat, size=freq), color='red3')


# ID 찍어서 지도에 그리기 - 영등포구 상위 대여소
map <- get_map(location='Yeongdeungpo-gu', zoom=13, maptype='roadmap', color='bw')

topf20<-read.csv("보관소예측률_형식.csv")
topfl20<-merge(dfx,topf20,by="ID")

dfx<-df[,c(2,5,6)]
dfx





ggmap(map)  +
  geom_point(data=top2, aes(x=lon, y=lat, color='출근시간_Borrow'), size=2) +
  geom_point(data=top8, aes(x=lon, y=lat, color='퇴근시간_Return'), size=2) +
  scale_colour_manual(name='예측 ↓', values=c(출근시간_Borrow='blue', 퇴근시간_Return='navyblue'))

ggmap(map)  + 
  geom_point(data=top4, aes(x=lon, y=lat, color='퇴근시간_Borrow'), size=2) +
  geom_point(data=top6, aes(x=lon, y=lat, color='출근시간_Return'), size=2) +
  scale_colour_manual(name='예측 ↓', values=c(퇴근시간_Borrow='red', 출근시간_Return='firebrick'))

ggmap(map)  +
  geom_point(data=top1, aes(x=lon, y=lat, color='출근시간_Borrow'), size=2) +
  geom_point(data=top7, aes(x=lon, y=lat, color='퇴근시간_Return'), size=2) +
  scale_colour_manual(name='예측 ↑', values=c(출근시간_Borrow='blue', 퇴근시간_Return='navyblue'))
  
ggmap(map)  + 
  geom_point(data=top3, aes(x=lon, y=lat, color='퇴근시간_Borrow'), size=2) +
  geom_point(data=top5, aes(x=lon, y=lat, color='출근시간_Return'), size=2) +
  scale_colour_manual(name='예측 ↑', values=c(퇴근시간_Borrow='red', 출근시간_Return='firebrick'))





ggmap(map)  +
  geom_point(data=top1_10, aes(x=lon, y=lat, color='type1'), size=2) +
  geom_point(data=top3_10, aes(x=lon, y=lat, color='type3'), size=2) +
  geom_point(data=top5_10, aes(x=lon, y=lat, color='type5'), size=2) +
  geom_point(data=top7_10, aes(x=lon, y=lat, color='type7'), size=2) +
  geom_point(data=top2_10, aes(x=lon, y=lat, color='type2'), size=2) +
  geom_point(data=top4_10, aes(x=lon, y=lat, color='type4'), size=2) +
  geom_point(data=top6_10, aes(x=lon, y=lat, color='type6'), size=2) +
  geom_point(data=top8_10, aes(x=lon, y=lat, color='type8'), size=2) +
  scale_colour_manual(name='Point Color', 
                      values=c(type1='skyblue', type3='royalblue', type5='blue', type7='navyblue', 
                               type2='orangered', type4='red3', type6='firebrick', type8='red1'))


ggmap(map)  +
  geom_point(data=top1_10, aes(x=lon, y=lat), size=2, color='blue') +
  geom_point(data=top3_10, aes(x=lon, y=lat), size=2, color='skyblue') +
  geom_point(data=top5_10, aes(x=lon, y=lat), size=2, color='navyblue') +
  geom_point(data=top7_10, aes(x=lon, y=lat), size=2, color='purple') +
  geom_point(data=top2_10, aes(x=lon, y=lat), size=2, color='red') +
  geom_point(data=top4_10, aes(x=lon, y=lat), size=2, color='orange') +
  geom_point(data=top6_10, aes(x=lon, y=lat), size=2, color='pink') +
  geom_point(data=top8_10, aes(x=lon, y=lat), size=2, color='tomato') 


ggmap(map)  +
  geom_point(data=top8, aes(x=lon, y=lat), size=2, color='red')
  
  
  geom_point(data=top4_10, aes(x=lon, y=lat), size=2, color='orange') +
  geom_point(data=top6_10, aes(x=lon, y=lat), size=2, color='pink') +
  geom_point(data=top8_10, aes(x=lon, y=lat), size=2, color='tomato') 



# 반납 대여 상위 대여소
total_b <- total[order(-total$borrow, -total$return),]
total_b10 <- total_b[1:154,] # 대여량 상위 10% 대여소
total_r <- total[order(-total$return, -total$borrow),]
total_r10 <- total_r[1:154,] # 반납량 상위 10% 대여소

ggmap(map) + geom_point(data=total_b10, aes(x=lon, y=lat, color=borrow), size=2) + scale_color_gradient(low="turquoise2", high="blue")
ggmap(map) + geom_point(data=total_r10, aes(x=lon, y=lat, color=return), size=2) + scale_color_gradient(low="turquoise2", high="blue")
ggmap(map) + geom_point(data=total_b10, aes(x=lon, y=lat, size=borrow, color=구))
ggmap(map) + geom_point(data=total_r10, aes(x=lon, y=lat, size=return, color=구))


# 대여-반납 상위
data1<-read.csv("서울특별시 공공자전거 대여정보_201909_1.csv")
data2<-read.csv("서울특별시 공공자전거 대여정보_201909_2.csv")
data3<-read.csv("서울특별시 공공자전거 대여정보_201909_3.csv")

d1<-data1 %>% select(2, 3, 7)
d2<-data2 %>% select(2, 3, 7)
d3<-data3 %>% select(2, 3, 7)
d1<-d1[-(1:25),]

d<-rbind(d1,d2,d3)
d<-d[order(d$대여.대여소번호),]
d<-d[-(1:21),]
d<-d[order(d$대여일시),]
write.csv(d,'201909 반납대여정보_시간순.csv')


# 시간별로 분류
d<-with(d, d[ hour(대여일시) >= 18 & hour(대여일시) < 20 , ] )


# 대여-반납 순서쌍 만들기
count<-d %>% group_by(대여.대여소번호,반납대여소번호) %>% summarize(Count = n())
# count<-count[-(1:7),] # 이제 할 필요 x
count_order <- count[order(-count$Count),]
count_order
# write.csv(count_order,'201909 반납대여쌍.csv')

count_order<-count_order %>% rename(ID = 대여.대여소번호)
mg<-merge(count_order, df[, c("ID", "lat", "lon")], by="ID")
attach(mg)
mg<-mg %>% rename(bID=ID, ID=반납대여소번호, blat=lat, blon=lon)
mg<-merge(mg, df[, c("ID", "lat", "lon")], by="ID")
mg<-mg %>% rename(rID=ID, rlat=lat, rlon=lon)
mg<-mg[,c(2,1,4,5,6,7,3)]
mg<-mg[order(-mg$Count),]
head(mg)
detach(mg)

write.csv(mg,'201909 반납대여쌍+위치_퇴근시간.csv')

mg_mor<-mg
mg_eve<-mg

mg<-read.csv("201909 반납대여쌍+위치.csv")
mg2000<-mg[1:2000,]
mg2000

mg<-mg_eve[1:2000,]

ggmap(map)  + geom_segment(data=mg,
            aes(x=blon, y=blat, xend=rlon, yend=rlat, alpha=Count),
            col="blue", size=1.5) 

+ geom_point(data=df, aes(x=lon, y=lat), size=0.3, color="blue")
