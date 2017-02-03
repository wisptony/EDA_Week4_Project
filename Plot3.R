#Read and store data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
#load dplyr and ggplot2 package 
library(dplyr)
library(ggplot2)
#group baltimore city data by pollution type
pm25bal_bytype<-NEI %>% subset(fips=="24510") %>% group_by(type,year) %>% 
        summarize(sum(Emissions))
#Naming columns of pm25bal_bytype
names(pm25bal_bytype)<-c("type","year","pm25sum")
#Turn png device on
png("plot3.png")
#Plotting
g<-ggplot(pm25bal_bytype,aes(year,pm25sum,color=type))
g+geom_line()+xlab("year")+ylab("Total PM Emission")+
        ggtitle("Total emmision for Baltimore City from 1999 to 2008 by type")
#Turn device off
dev.off()
