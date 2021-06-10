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

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(filtered, {
    ## Create line plot of Global_active_power
    plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
    plot(datetime, Voltage, type="l", ylab = "Voltage")
    plot(datetime,Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
    lines(datetime,Sub_metering_2, type = "l", col = "red")
    lines(datetime,Sub_metering_3, type = "l", col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
    plot(datetime, Global_reactive_power, type="l", ylab = "Global Reactive Power")
    #plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    #plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    #plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer = TRUE)
    })

## close the PNG device!
dev.off()