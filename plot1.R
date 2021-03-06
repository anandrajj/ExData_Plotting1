plot1 <-function(){
  df <- read.table("household_power_consumption.txt",sep=";",skip=66637,nrows=2280,stringsAsFactors=FALSE,na.strings="?",col.names=c('Date','Time','Global_active_power','Golbal_reactive_power','Voltage','Global_intensity','Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  
  days <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")
  
  df1 <- cbind(days,df)
  
  png('plot1.png')
  hist(df1$Global_active_power,col="red",xlab="Global Active Power (Kilowatts)",main="Global Active Power")
  dev.off()
  
  
}