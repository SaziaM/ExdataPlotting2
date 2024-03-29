NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
a<-group_by(NEI,year)
b<-summarise(a,S=sum(Emissions))
png("plot1.png",width=480,height=480,units="px")
with(b,plot(year,S,type="l",ylab="Total PM2.5 Emissions",col="blue"))
title(main="Total PM2.5 Emission in each year")
dev.off()
