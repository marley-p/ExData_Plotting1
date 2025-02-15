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
         Global_active_power=as.numeric(Global_active_power))

hist(hps$Global_active_power,
     col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.copy(png,file="plot1.png",width=480,height = 480)
dev.off()




