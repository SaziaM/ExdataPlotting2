NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
con1<-levels(SCC$EI.Sector)[49]
con2<-levels(SCC$EI.Sector)[50]
con3<-levels(SCC$EI.Sector)[51]
con4<-levels(SCC$EI.Sector)[52]
con<-c(con1,con2,con3,con4)
c<-filter(SCC,EI.Sector %in% con)
c<-select(c,SCC)
c[,1]<-as.character(c[,1])
data<-merge(NEI,c,by="SCC")
data<-group_by(data,year)
data<-filter(data,fips == "24510")
data<-summarise(data,S=sum(Emissions))
png("plot5.png",width=480,height=480,units="px")
with(data,plot(year,S,type="l",ylab="Total PM2.5 Emissions",col="blue"))
title(main="PM2.5 Emission from Motor Vehicle sources in Baltimore City")
dev.off()
