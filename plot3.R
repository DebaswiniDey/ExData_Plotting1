url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileUrl <- tempfile()
download.file(url, fileUrl)
unzip(fileUrl)

data <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?")

data <- subset(data, grepl("^[12]/2/2007", Date))

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)


with(data, {
  plot(DateTime, Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab="")
  lines(DateTime, Sub_metering_2, col="red", type="l")
  lines(DateTime, Sub_metering_3, col="blue", type="l")
})
legend("topright", col = c("black", "red", "blue"), lwd=1 ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
