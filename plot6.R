NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
con1<-levels(SCC$EI.Sector)[49]
con2<-levels(SCC$EI.Sector)[50]
con3<-levels(SCC$EI.Sector)[51]
con4<-levels(SCC$EI.Sector)[52]
con<-c(con1,con2,con3,con4)
c<-filter(SCC,EI.Sector %in% con)
c<-select(c,SCC)
c[,1]<-as.character(c[,1])
data<-merge(NEI,c,by="SCC")
fipsCon<-c("06037","24510")
data<-filter(data,fips %in% fipsCon)
data<-group_by(data,year,fips)
data<-summarise(data,S=sum(Emissions))
count<-nrow(data)
for(i in 1:count)
{
if(data[i,2]=="06037")
data[i,2]="Los Angeles County"
else if(data[i,2]=="24510")
data[i,2]="Baltimore City"
}
png("plot6.png",width=500,height=500,units="px")
qplot(year,S,data=data,facets=fips~.,color=fips,main="Comparison between Baltimore City and Los Angeles County",ylab="Total PM2.5 Emission",geom="path")
dev.off()
