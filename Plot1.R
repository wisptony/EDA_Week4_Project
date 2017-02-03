#Read and store data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
#load dplyr package 
library(dplyr)
#group pm25 pollution data by year and summarize the sum for each year
pollutionsum<-NEI %>% group_by(year) %>% summarize(sum(Emissions))
#change coloumn names for summarized output 
names(pollutionsum)<-c("year","pm25sum")
#change units of pm25sum from tons to million tons
pollutionsum$pm25sum<-pollutionsum$pm25sum/10^6
#save image to png file
png("plot1.png")
#Plotting plot1 to show pm25 emission trend from 1999 to 2008
with(pollutionsum,plot(year,pm25sum, type="b", 
                       xaxt="n", yaxt="n", ann=FALSE))
title(main="PM emission from 1999 to 2008",
      xlab="years",
      ylab="total emission(million tons)")
axis(1,at=seq(1999,2008,by=3))
axis(2,at=seq(3,7,by=1))
#turn off device
dev.off()
#According to the plot, total pollution decreased during the period