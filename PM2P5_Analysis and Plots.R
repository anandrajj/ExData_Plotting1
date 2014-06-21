## Read input datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Processing & Plot
yeartot <- ddply(NEI,.(year),summarize,Emmissions=sum(Emissions,rm.na=T))
png('plot1.png')
par(bg="grey")
plot(yeartot$year,yeartot$Emmissions,typ="b",xlab="Year",ylab="Total Emissions",main="Trend of Emission by Year",col="blue")
dev.off()

#Processing & Plot
subdf <- subset(NEI,fips==24510)
balttot <- ddply(subdf,.(year),summarize,Emissions=sum(Emissions,rm.na=T))
png('plot2.png')
par(bg="grey")
plot(balttot$year,balttot$Emissions,typ="b",xlab="Year",ylab="Total Emissions",main="Trend of Emission in Baltimore City",col="red")
dev.off()

#Processing & Plot
subdf <- subset(NEI,fips==24510)
tot <- ddply(subdf,.(year,type),summarize,Emissions=sum(Emissions,rm.na=T))

png('plot3.png')
ggplot(tot, aes(x = year, y = Emissions,colour=type)) + geom_line(aes(group=type)) + ggtitle("Baltimore City - Emission by type")
dev.off()


df <- NEI[NEI$SCC %in% SCC[grepl(c("[C]oal"),SCC$Short.Name),1],]
yeartot <- ddply(df,.(year),summarize,Emissions=sum(Emissions,rm.na=T))
png('plot4.png')
par(bg="grey")
plot(yeartot$year,yeartot$Emissions,typ="b",xlab="Year",ylab="Total Emissions",main="Trend of Coal Emission by Year",col="red")
dev.off()

df <- NEI[((NEI$SCC %in% SCC[grepl("[V]ehicle",SCC$EI.Sector),1]) & (NEI$fips == "24510")),]
vehicletot <- ddply(df,.(year),summarize,Emissions=sum(Emissions,rm.na=T))
png('plot5.png')
par(bg="white")
plot(vehicletot$year,vehicletot$Emissions,typ="b",xlab="Year",ylab="Total Emissions",main="Trend of Baltimore Vehicle Emission by Year",col="blue")
dev.off()

df <- NEI[(NEI$SCC %in% SCC[grepl("[V]ehicle",SCC$EI.Sector),1]) & (NEI$fips %in% c("06037","24510")),]
vehicletot <- ddply(df,.(year,fips),summarize,Emissions=sum(Emissions,rm.na=T))

png('plot6.png')
library(ggplot2)
ggplot(vehicletot, aes(x = year, y = Emissions,colour=fips)) + geom_line(aes(group=fips)) + ggtitle("Vehicle Emission - Los Angels County Vs Baltimore City")
dev.off()

