
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

## remove incomplete data
filtered <- filtered[complete.cases(filtered), ]

## Create line plot differentiating Sub_metering
png("plot3.png", width = 480, height = 480)
plot(filtered$datetime,filtered$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
lines(filtered$datetime,filtered$Sub_metering_2, type = "l", col = "red")
lines(filtered$datetime,filtered$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

## Copy my plot to a PNG file
#dev.copy(png, file = "plot3.png")
## close the PNG device!
#dev.off()