# Get Data
dataseturl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datazip <- "household_power_consumption.zip"
download.file(dataseturl, destfile = datazip, method="curl")

# Extract Data
unzip(datazip)

# read data
power <- read.table("household_power_consumption.txt",
                    sep=";", header = TRUE)

# Convert dates to datetime
library(lubridate)
power$Datetime <- with(power, dmy(Date) + hms(Time))


# Subset data
mydates <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",]

# convert numerics
mydates$Global_intensity <- as.numeric(as.character(mydates$Global_intensity))
mydates$Global_active_power <- as.numeric(as.character(mydates$Global_active_power))
mydates$Sub_metering_1 <- as.numeric(as.character(mydates$Sub_metering_1))
mydates$Sub_metering_2 <- as.numeric(as.character(mydates$Sub_metering_2))
mydates$Sub_metering_3 <- as.numeric(as.character(mydates$Sub_metering_3))
mydates$Voltage <- as.numeric(as.character(mydates$Voltage))
mydates$Global_reactive_power <- as.numeric(as.character(mydates$Global_reactive_power))



# Plot as png
png("plot4.png")
par(mfrow=c(2,2))
# First subplot
plot(mydates$Datetime, mydates$Global_active_power, type="n",
     xlab="", ylab="Global Active Power")
lines(mydates$Datetime, mydates$Global_active_power)

# Second subplot
plot(mydates$Datetime, mydates$Voltage, type="n",
     xlab="datetime", ylab="Voltage")
lines(mydates$Datetime, mydates$Voltage)

# Third subplot
plot(mydates$Datetime, mydates$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(mydates$Datetime, mydates$Sub_metering_1, col="black")
lines(mydates$Datetime, mydates$Sub_metering_2, col="red")
lines(mydates$Datetime, mydates$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1, bty="n")

# Forth subplot
plot(mydates$Datetime, mydates$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(mydates$Datetime, mydates$Global_reactive_power)
dev.off()
