setwd("PATH") # erased
center<-read.csv("서울특별시 공공자전거 대여소 정보(19.12.9).csv")
center

# 날씨 정보 불러오기
setwd("PATH") # erased
wth<-read.csv("weather_data_final.csv")

wth1<-wth[which(wth$구=='영등포구'),]
wth2<-wth[which(wth$구=='송파구'),]
wth3<-wth[which(wth$구=='강서구'),]
wth4<-wth[which(wth$구=='마포구'),]

c1<-center[ which(center$대여소_구=='영등포구'), ]
c2<-center[ which(center$대여소_구=='송파구'), ]
c3<-center[ which(center$대여소_구=='강서구'), ]
c4<-center[ which(center$대여소_구=='마포구'), ]

c1n<-c1[,2]
c2n<-c2[,2]
c3n<-c3[,2]
c4n<-c4[,2]

x <- c('대여소ID','구','일자','요일','시간','기온','습도','강수량','풍속','미세먼지')
df <- as.data.frame(matrix(ncol = length(x), nrow=115340,dimnames = list(NULL,x))) # 변동성
df

date<-format(seq(as.Date("2018-11-01"), as.Date("2019-10-31"), by="days"), format="%Y%m%d")
time<-c(700,800,1800,1900)

df$대여소ID<-rep(c4n,each=1460) # 변동성
df$구<-'마포구' # 변동성
df$일자<-rep(date,each=4)
df$date <- strptime(as.character(df$일자), "%Y%m%d")
df$요일 = strftime(df$date,'%u')
df<-df[,-11]
df$시간<-rep(time)
df$기온<-rep(wth4[,4]) # 변동성
df$습도<-rep(wth4[,5]) # 변동성
df$강수량<-rep(wth4[,6]) # 변동성
df$풍속<-rep(wth4[,7]) # 변동성
df$미세먼지<-rep(wth4[,8]) # 변동성

df4<-df # 변동성
write.csv(df,'data_마포구.csv') # 변동성

# 4개 구 합치기
df_all<-rbind(df1,df2,df3,df4)
df_all
write.csv(df_all,'data_all.csv')







