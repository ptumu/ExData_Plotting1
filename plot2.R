# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007.
# This code constructs the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
# Plot is line graph of Global Active Power value and time

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
plot(d1$Time, d1$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()