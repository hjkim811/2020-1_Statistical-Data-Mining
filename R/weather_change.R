setwd("PATH") # erased
wd<-read.csv("weather_data_n.csv")

new <- wd[ which(wd$구=='영등포구'|wd$구=='송파구'|wd$구=='강서구'|wd$구=='마포구'), ]
new


new$date <- strptime(as.character(new$일자), "%Y%m%d")
new$day = strftime(new$date,'%u')
new

write.csv(new,'weather_data_final.csv')




