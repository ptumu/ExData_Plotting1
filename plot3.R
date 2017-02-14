# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007.
# This code constructs the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
# Plot is line graph of 3 values (sub_meter_1, _2, and _3) and time.

## read file - only load the lines based on two dates of interest
l1 <- strsplit(grep("^(1/2/2007|2/2/2007);", readLines("household_power_consumption.txt"), value=TRUE), ";")
d1 <- data.frame(Reduce(rbind, l1))
#set the column names
d1ColNames <- strsplit(readLines("household_power_consumption.txt", n=1), ";")
setnames(d1, old = names(d1), new = d1ColNames[[1]]) 

#convert values to right type - they come in as factors
numFormatCols = c(3:9)
d1[,numFormatCols] = apply(d1[,numFormatCols], 2, function(x) as.numeric(as.character(x)))
d1$Time <- strptime(paste(as.character(d1$Date), as.character(d1$Time), sep="-"), "%d/%m/%Y-%H:%M:%S")
d1$Date <- as.Date(as.character(d1$Date), "%d/%m/%Y")


#create the linegraph and copy to file
par(mfrow = c(1, 1))
plot(d1$Time, d1$Sub_metering_1, type = "l", ylab = "Energy sub metering", col="black", xlab ="")
points(d1$Time, d1$Sub_metering_2, type = "l", col="red")
points(d1$Time, d1$Sub_metering_3, type = "l", col="blue")
legend("topright", bty = "o", y.intersp = 0.75, x.intersp = 0.75, cex = 0.75, lty = "solid", col = c("black", "red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()