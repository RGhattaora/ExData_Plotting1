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
png("plot2.png")
plot(Data$Global_active_power, type = "l", xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
dev.off()