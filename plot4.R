plot4 <-function(){
  df <- read.table("household_power_consumption.txt",sep=";",skip=66637,nrows=2280,stringsAsFactors=FALSE,na.strings="?",col.names=c('Date','Time','Global_active_power','Golbal_reactive_power','Voltage','Global_intensity','Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  
  days <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")
  
  df1 <- cbind(days,df)
  
  png('plot4.png')
  par(mfrow=c(2,2))
  with(df1,{
    plot(Global_active_power ~ days,df1,type="l",col="black")
    
    plot(Voltage ~ days,df1,type="l",col="black")
    
    plot(Sub_metering_1 ~ days,df1,type="l",col="black",ylab="Energy Sub Metering",xlab="")
    lines(Sub_metering_2 ~ days,df1,col="red")
    lines(Sub_metering_3 ~ days,df1,col="blue")
    legend("topright",col="black","red","blue",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),text.col="black")
    
    plot(Golbal_reactive_power ~ days,df1,type="l",col="black")
  })
  dev.off()
  
}