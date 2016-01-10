#read the file
file <- "household_power_consumption.txt"
houseData <- read.table(file, sep=";", na.string="?", header=TRUE)

#change to date class
houseData$Date <- as.Date(houseData$Date, format="%d/%m/%Y")

#omit NAs
houseData <- houseData[complete.cases(houseData),]

#get the right dates
feb <- subset(houseData, Date == "2007-02-01" | Date == "2007-02-02")

#open png
png(filename="plot1.png", width=480, height=480)

#create plot1
hist(as.numeric(as.character(feb$Global_active_power)),
    col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency",
    main="Global Active Power", breaks=15)

#turn off device
dev.off()
