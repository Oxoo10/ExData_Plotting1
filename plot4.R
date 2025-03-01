# Load necessary libraries
library(data.table)

# Read only relevant data (skip large dataset load)
data <- fread("household_power_consumption.txt", sep=";", na.strings="?")

# Convert Date column to Date type
data[, Date := as.Date(Date, format="%d/%m/%Y")]

# Subset for the required dates
data <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Combine Date and Time into a single Datetime column
data[, Datetime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))  # 2x2 layout

# Global Active Power
plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Voltage
plot(data$Datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Energy Sub-metering
plot(data$Datetime, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, col="red")
lines(data$Datetime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, bty="n")

# Global Reactive Power
plot(data$Datetime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()
