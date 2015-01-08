## define your working directory
setwd(".")

## define language for weekday names
if(.Platform$OS.type=="windows")
  Sys.setlocale("LC_TIME","English_United Kingdom.1252")
if(.Platform$OS.type=="unix")
  Sys.setlocale("LC_TIME", "en_US")

## data file will be load from de working directory
data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?" 
                 , check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## filter data
data <- subset(data, subset=(Date >= "2007-02-01" & Date < "2007-02-03"))

## create new column DateTime with date and time
data$DateTime <- as.POSIXct( paste(as.Date(data$Date), data$Time) )


## define plot properties
png("plot4.png", width=480, height=480, units = "px", bg = "white")

## define 2x2 frames
par(mfrow=c(2,2))

## chart 1
plot(data$DateTime, data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

## chart 2
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

## chart 3
plot(data$DateTime, data$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       box.lwd=0,
       bty="n")
## chart4
plot(data$DateTime, data$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(data$DateTime, data$Global_reactive_power)

## close file
dev.off()
  
