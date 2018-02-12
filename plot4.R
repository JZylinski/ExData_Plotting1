library(sqldf)

## Read only lines for dates 2007-02-01 & 2007-02-02
powerSubset <- read.csv.sql("./household_power_consumption.txt", sep = ';', 
                            header = TRUE, sql="select * from file where 
                            Date in ('1/2/2007', '2/2/2007')")

## Convert Date variable from character to Date class
powerSubset$Date <- as.Date(powerSubset$Date, format = "%d/%m/%Y", 
                            na.strings = "?")

## Create datetime character variable
powerSubset$datetime <- paste(powerSubset$Date, powerSubset$Time)

## Convert datetime variable from character to POSIXlt and POSIXt class
powerSubset$datetime <- strptime(powerSubset$datetime, 
                                 format = "%Y-%m-%d %H:%M:%S")

## create PNG file to specifications

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

## Plot 1 of 4

plot(powerSubset$datetime,
     powerSubset$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

## Plot 2 of 4

plot(powerSubset$datetime,
     powerSubset$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## Plot 3 of 4

plot(powerSubset$datetime,
     powerSubset$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")

legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1)

lines(powerSubset$datetime,
      powerSubset$Sub_metering_2, col = "red")

lines(powerSubset$datetime,
      powerSubset$Sub_metering_3, col = "blue")

## Plot 4 of 4

plot(powerSubset$datetime,
     powerSubset$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()