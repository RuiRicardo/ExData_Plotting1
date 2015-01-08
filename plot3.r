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
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

## the chart
with(data, {
    plot(Sub_metering_1~DateTime , type="S", col="black", ylab="Energy sub metering", xlab=""
          , cex.lab=0.8, cex.axis=0.8)
    lines(Sub_metering_2~DateTime, type="S", col='Red' )
    lines(Sub_metering_3~DateTime, type="S", col='Blue')
})

legend("topright", col=c("black", "red", "blue"), 
       lty = c(1, 1), lwd = c(1, 1, 1), cex=0.8,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.off()
