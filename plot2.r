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
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

## the chart
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## close file
dev.off()
