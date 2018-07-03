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

## Create Plot 1
hist(data$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

## Save to png
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

