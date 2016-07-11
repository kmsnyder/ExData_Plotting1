install.packages("dplyr")
library(dplyr)

# Capture link address so that source can be provided
powerConsumptionLink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download file with bit mode and unzip file
download.file(powerConsumptionLink, destfile = "Electric_Power_Consumption.zip", mode = "wb")
unzip("Electric_Power_Consumption.zip")

# Read table headers and sample of 5 for classes
hpc_file <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows=5)
hpc_file
classes <- sapply(hpc_file, class)

# Read entire table using classes
hpc_file <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?")

# setup date as a postix date and time
head(hpc_file)
dt <- paste(hpc_file$Date,hpc_file$Time)
dt <- strptime(dt, format = "%d/%m/%Y %H:%M:%S" )
dt
hpc_file$Date <- dt

# Filter for February 1 and February 2, 2007
hpc_file <- subset(hpc_file, Date >= "2007-2-1" & Date <= "2007-2-2")

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(x = hpc_file$Date, y = hpc_file$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(x = hpc_file$Date, y = hpc_file$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

sm1 <- hpc_file$Sub_metering_1
sm2 <- hpc_file$Sub_metering_2
sm3 <- hpc_file$Sub_metering_3

plot(hpc_file$Date, sm1, type = "l", col="black", ylab = "Energy sub metering", xlab = "")
lines(hpc_file$Date, sm2, col="red")
lines(hpc_file$Date, sm3, col="blue")
legend(x = "topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"), bty = "n")

plot(x = hpc_file$Date, y = hpc_file$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
