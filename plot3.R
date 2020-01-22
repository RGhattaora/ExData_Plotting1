"Read and manipulate data"
Data <- read_delim("household_power_consumption.txt", ";", na = c("?"))
Data <- Data[!is.na(Data$Sub_metering_3), ]
Dates <- pull(Data, 1)
Dates <- strptime(Dates, "%d/%m/%Y")
Data <- Data[, c(2:9)]
Dates <- as.data.frame(Dates)
Data <- cbind(Dates, Data)
Data <- as_tibble(Data)
rm(Dates)
StartDate <- strptime("01/02/2007", "%d/%m/%Y")
EndDate <- strptime("02/02/2007", "%d/%m/%Y")
Data <- Data[Data$Dates <= EndDate, ]
Data <- Data[Data$Dates >= StartDate, ]
rm(EndDate)
rm(StartDate)

"Plot and export graph"
png("plot3.png")
plot(Data$Sub_metering_1,type="l",xaxt="n",ylab="Energy sub metering",xlab="")
lines(Data$Sub_metering_2,type="l",col="red")
lines(Data$Sub_metering_3,type="l",col="blue")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()