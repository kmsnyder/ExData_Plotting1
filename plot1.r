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

# Setup histogram 
hist(hpc_file$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
