## define your working directory
setwd(".")

## data file will be load from de working directory
data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?" 
                 , check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## filter data
data <- subset(data, subset=(Date >= "2007-02-01" & Date < "2007-02-03"))

## create new column DateTime with date and time
data$DateTime <- as.POSIXct( paste(as.Date(data$Date), data$Time) )

## define plot properties
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

## the chart
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## close file
dev.off()
