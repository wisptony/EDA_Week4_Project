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
#Group data for Baltimore City by year
pm25_bal_vehicles<-merged[vehicles_index,] %>% subset(fips=="24510") %>%
        group_by(year) %>% summarize(sum(Emissions))
#Change Column Names
names(pm25_bal_vehicles)<-c("year","pm25sum")
#Turn on device
png("plot5.png")
#Plot with ggplot2 package
g<-ggplot(pm25_bal_vehicles,aes(factor(year),pm25sum,group=1))
g+geom_point()+geom_line()+xlab("year")+
        ylab("total pm25 emissions(tons)")+
        ggtitle("pm25 emissions in Baltimore City from vehicles by year")
#Turn off device
dev.off()
