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
         Voltage=as.numeric(Voltage),
         Global_reactive_power=as.numeric(Global_reactive_power),
         Day=wday(Date,label=TRUE))

par(mfcol=c(2,2))

with(hps,plot(dt,Global_active_power,type="l",
              xlab = "",
              ylab = "Global Active Power",
              xaxt = "n"))
axis(1, at = c(min(hps$dt),median(hps$dt), max(hps$dt)),
     labels = c("Thu", "Fri","Sat"))

with(hps,plot(dt,Sub_metering_1,type="n",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n"))
axis(1, at = c(min(hps$dt),median(hps$dt), max(hps$dt)),
     labels = c("Thu", "Fri","Sat"))
points(hps$dt,hps$Sub_metering_1,type="l")
points(hps$dt,hps$Sub_metering_2,type="l", col="red")
points(hps$dt,hps$Sub_metering_3,type="l", col="blue")
legend(x="topright",y="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),cex=0.75)

with(hps,plot(dt,Voltage,type="l",
              xlab = "datetime",
              ylab = "Voltage",
              xaxt = "n"))
axis(1, at = c(min(hps$dt),median(hps$dt), max(hps$dt)),
     labels = c("Thu", "Fri","Sat"))

with(hps,plot(dt,Global_reactive_power,type="l",
              xlab = "datetime",
              ylab = "Global Reactive Power",
              xaxt = "n"))
axis(1, at = c(min(hps$dt),median(hps$dt), max(hps$dt)),
     labels = c("Thu", "Fri","Sat"))

dev.copy(png,file="plot4.png",width=480,height = 480)
dev.off()




