library(downloader)
library(data.table)
library(lubridate)
library(tidyverse)
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")
dat<-fread(file="household_power_consumption.txt")
hps<-subset(dat,Date=="1/2/2007"|Date=="2/2/2007") %>% 
  mutate(Date=dmy(Date),
         Time=hms(Time),
         dt=Date+Time,
         Global_active_power=as.numeric(Global_active_power),
         Day=wday(Date,label=TRUE))

with(hps,plot(dt,Sub_metering_1,type="n",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n"))
axis(1, at = c(min(hps$dt),median(hps$dt), max(hps$dt)),
     labels = c("Thu", "Fri","Sat"))

points(hps$dt,hps$Sub_metering_1,type="l")
points(hps$dt,hps$Sub_metering_2,type="l", col="red")
points(hps$dt,hps$Sub_metering_3,type="l", col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

dev.copy(png,file="plot3.png",width=480,height = 480)
dev.off()




