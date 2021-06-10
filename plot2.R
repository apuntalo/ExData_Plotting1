## Download data
household_power_consumption <- read.table("./data/household_power_consumption.txt",
                                          header = 1,
                                          sep = ";")


## Convert Date and Time to datetime
x <- paste(household_power_consumption$Date, household_power_consumption$Time)
household_power_consumption$datetime <- strptime(x, "%d/%m/%Y %H:%M:%S")
## Filter only between 2007-02-01 and 2007-02-02
filtered = subset(household_power_consumption, (datetime >= "2007/02/01 00:00:00")
                  & (datetime < "2007/02/03 00:00:00"))
## Convert values to numeric
filtered[,3:8] <- sapply(filtered[,3:8],as.numeric)

## Create line plot of Global_active_power
plot(filtered$datetime, filtered$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Copy my plot to a PNG file
dev.copy(png, file = "plot2.png")
## close the PNG device!
dev.off()

