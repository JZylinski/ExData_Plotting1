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
png(filename = "plot2.png", width = 480, height = 480)

plot(powerSubset$datetime,
     powerSubset$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()