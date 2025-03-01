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

png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
