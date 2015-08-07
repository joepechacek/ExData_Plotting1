################################################################################
##                                                                            ##
##             Exploratory Data Analysis - Course Project 1                   ##
##    plot4.R script to generate the plots for part 4 of assignment           ##
## This plot includes 4 graphs on a single device output.  Some of the graphs ##
## are a repeat of previous graphs for part 2 and 3, while others are new     ##
##                                                                            ##
################################################################################

# First need to read in the data from the default current working directory
# Since the file is so large and we only need a subset of the data, I have 
# read in only the data for dates February 1st and 2nd of 2007.  The date
# format in the file is D/M/YYYY so I am subsetting on 1/2/2007 and 2/2/2007

data <- subset(read.table("household_power_consumption.txt", header = TRUE, 
                          sep = ";", stringsAsFactors = FALSE), 
               Date %in% c("1/2/2007", "2/2/2007"))


# The Day of Week will be needed for the graph, so I am using the lubridate
# package to create a DateTime variable after
library(lubridate)
data$DateTime <- dmy_hms(paste(data$Date, data$Time))


# The columns I want to plot are not "numeric", so need to fix this first.
class(data$Global_active_power) <- "numeric"
class(data$Voltage) <- "numeric"
class(data$Global_reactive_power) <- "numeric"
class(data$Sub_metering_1) <- "numeric"
class(data$Sub_metering_2) <- "numeric"
class(data$Sub_metering_3) <- "numeric"


# In order to generate four graphs, the par() option needs to be set to create 
# four graph windows. Using mfrow() so the graphs will populate
# by row first, then column
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Upper left graph is the same as plot 2 created eariler
plot(data$DateTime, data$Global_active_power, type = "l", 
     ylab = "Global Active Power",
     xlab = "")

# The upper right graph is a line graph of the Voltage values.  
plot(data$DateTime, data$Voltage, type = "l", 
     ylab = "Voltage",
     xlab = "datetime")

# The lower left graph is similar to that used in plot 3
plot(data$DateTime, data$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering",
     xlab = "")
points(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
points(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# The lower right graph is the Global_reactive_power graph similar to upper left graph
plot(data$DateTime, data$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.off()

# It is a good idea to now return the mfrow() to normal
par(mfrow = c(1,1))
