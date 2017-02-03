#Read and store data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
#load dplyr package 
library(dplyr)
#pull out data for Baltimore and group them by year
pollutionbal<-NEI %>% subset(fips=="24510") %>% group_by(year) %>% summarize(sum(Emissions))
#Rename columns for pollutionbal
names(pollutionbal)<-c("year","pm25sum")
#Change units of total pollution from tons to kilotons
pollutionbal$pm25sum<-pollutionbal$pm25sum/1000
#turn on png device
png("plot2.png")
#Plot with basic plotting system
with(pollutionbal,plot(year,pm25sum, type="b", 
                       xaxt="n", yaxt="n", ann=FALSE))
title(main="PM emission for Baltimore City from 1999 to 2008",
      xlab="years",
      ylab="total emission(kilotons)")
axis(1,at=seq(1999,2008,by=3))
axis(2,at=seq(0,4,by=0.25))
#turn of device
dev.off()
