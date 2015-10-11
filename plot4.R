# download data
library(dplyr)
sFile <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
if (!file.exists("data/household_power_consumption.zip")) {
  download.file(sFile, destfile = "data/household_power_consumption.zip")
}

dt <-read.table("data/household_power_consumption.txt",sep = ";", header=TRUE, na.strings = c("?"),
                stringsAsFactors = FALSE, dec = ".")
                
dt$DateTime <- strptime(paste(dt$Date,dt$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
dt2 <- dt[dt$DateTime >= "2007-02-01 00:00:00" & dt$DateTime <= "2007-02-02 23:59:59",]

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# 1,1
with(dt2,plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# 1,2
with(dt2,plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
# 2,1
with(dt2,plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab="Energy Submetering"))
with(dt2,lines(DateTime, Sub_metering_2, type="l", col="red"))
with(dt2,lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# 2,2
with(dt2, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
