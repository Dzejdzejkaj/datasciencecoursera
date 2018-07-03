## Download the data and unzip
fname <- "data.zip"
download_if_not_exists <- function(fname, url) {
    if (!file.exists(fname))
        download.file(url, destfile = fname, method = "curl")
}
download_if_not_exists(fname, "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
unzip("data.zip")

## Load data into R - only the dates 2007-02-01 and 2007-02-02
hd <- file("household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(hd), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Converting Dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Create Plot 3
with(data, {
    plot(Sub_metering_1 ~ Datetime, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save to png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()