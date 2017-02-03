#Read and store data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
#load dplyr and ggplot2 package 
library(dplyr)
library(ggplot2)
#Merge NEI and SCC by SCC variable
merged<-merge(NEI,SCC,by="SCC")
#Sort out index for vehicle pollution data
vehicles_index<-grep("Vehicles$",merged$EI.Sector)
#Group data for Baltimore and LA by year
pm25_balcal_vehicles<-merged[vehicles_index,] %>% subset(fips=="24510"|fips=="06037") %>%group_by(year,fips) %>% summarize(sum(Emissions))
#Renames columns
names(pm25_balcal_vehicles)<-c("year","county","pm25sum")
#factorize county variable
pm25_balcal_vehicles$county<-factor(pm25_balcal_vehicles$county,labels=c("LA","Bal"))
#Turn on device
png("plot6.png")
#Plot with ggplot2 package
g<-ggplot(pm25_balcal_vehicles,aes(factor(year),pm25sum,group=county,color=county))
g+geom_point()+geom_line()+xlab("year")+
        ylab("total pm25 emissions(tons)")+
        ggtitle("pm25 emissions in Baltimore and LA from vehicles by year")
#Turn off device
dev.off()
