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

# Plot as png
png("plot1.png")
hist(mydates$Global_active_power, breaks=15, col= "red",
     xlim=c(0,6), ylim=c(0,1200), xlab="Global Active Power (kilowatts",
     ylab="Frequency", main = "Global Active Power")
dev.off()
