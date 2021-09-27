url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileUrl <- tempfile()
download.file(url, fileUrl)
unzip(fileUrl)

data <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?")

data <- subset(data, grepl("^[12]/2/2007", Date))

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

hist(data$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
