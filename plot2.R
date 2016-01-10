#read the file
file <- "household_power_consumption.txt"
houseData <- read.table(file, sep=";",  na.string="?", header=TRUE)

#change to date class
houseData$Date <- as.Date(houseData$Date, format="%d/%m/%Y")

#omit nas
houseData <- houseData[complete.cases(houseData),]

#get the right dates and format them again
feb <- subset(houseData, Date == "2007-02-01" | Date == "2007-02-02")
datetime <- strptime(paste(feb[,1], feb[,2]),format="%Y-%m-%d %H:%M:%S")

#open png
png(filename="plot2.png", width=480, height=480)

#create plot2
with(feb, plot(datetime, as.numeric(as.character(Global_active_power)),
                xlab = "", ylab = "Global Active Power (kilowatts)",
                type = "l"))

#copy plot2 and turn off device
dev.off()
