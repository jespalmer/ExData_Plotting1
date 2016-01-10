#read the file
file <- "household_power_consumption.txt"
houseData <- read.table(file, sep=";",  na.string="?", header=TRUE)

#change to date class
houseData$Date <- as.Date(houseData$Date, format="%d/%m/%Y")

#omit NAs
houseData <- houseData[complete.cases(houseData),]

#get the right dates and format them again
feb <- subset(houseData, Date == "2007-02-01" | Date == "2007-02-02")
datetime <- strptime(paste(feb[,1], feb[,2]),format="%Y-%m-%d %H:%M:%S")

#open png
png(filename="plot4.png", width=480, height=480)

#change number of plots to display
par(mfrow=c(2,2))

#create plot1
with(feb, plot(datetime, as.numeric(as.character(feb$Global_active_power)),
    xlab="", ylab="Global Active Power", type = "l"))

#create plot2
with(feb, plot(datetime, Voltage,
    xlab = "datetime", ylab = "Voltage", type = "l"))

#create plot3
with(feb, plot(datetime, feb$Sub_metering_1,
    xlab = "", ylab = "Energy sub metering", type = "l"))
    with(feb, points(datetime, Sub_metering_1, col="black", type="l"))
    with(feb, points(datetime, Sub_metering_2, col="red", type="l"))
    with(feb, points(datetime, Sub_metering_3, col="blue", type="l"))
legend("topright", lwd = 2, col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#create plot4
with(feb, plot(datetime, as.numeric(as.character(feb$Global_reactive_power)),
    xlab="datetime", ylab="Global_reactive_power", type="l"))

#copy plots and turn off device
dev.off()
