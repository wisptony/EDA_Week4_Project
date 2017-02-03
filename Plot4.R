#Read and store data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
#load dplyr and ggplot2 package 
library(dplyr)
library(ggplot2)
#Merge NEI and SCC by SCC variable
merged<-merge(NEI,SCC,by="SCC")
#Sort out index for coal combustion related source
coalindex<-grep("Coal$",as.character(merged$EI.Sector),ignore.case = TRUE)
#Subset pollution data into coal-related and group them by year
pollution_coal<-merged[coalindex,] %>% group_by(year) %>% summarize(sum(Emissions))
#Change column names for pollution_coal
names(pollution_coal)<-c("year","pm25sum")
#Turn on png device
png("plot4.png")
#Plotting with ggplot 2 package
g<-ggplot(pollution_coal,aes(factor(year),pm25sum,group=1))
g+geom_point()+geom_line()+xlab("year")+
        ylab("total pm25 emissions(tons)")+
        ggtitle("Total emissions from coal sources from 1999 to 2008")
#Turn of device
dev.off()
