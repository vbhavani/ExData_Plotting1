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
png("plot2.png", width=480, height=480)
with(dt2,plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
