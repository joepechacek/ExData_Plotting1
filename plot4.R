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
# read in only the data for dates February 1st and 2nd of 2007.  The data
# format in the file is D/M/YYYY so I am loading 1/2/2007 and 2/2/2007

data <- subset(read.table("household_power_consumption.txt", header = T, 
                          sep = ";", stringsAsFactors = F), 
               Date %in% c("1/2/2007", "2/2/2007"))


# We will need to have a 'Day of Week" value for later, so convert the Date 
# field to POSIXlt format that can then be used to label the Day of Week.
# Then I will create a new column with the Day Name and use head() and tail()
# to find out what the first day and last day are.  This is not used in a
# function, I will just use it to make decisions later on the plot labels.

# First convert to POSIXlt, and then I can use the $wday value to create the 
# DayOfWeek values from a vector of Days

data$Date <- strptime(data$Date, format = "%d/%m/%Y")

# Create a new variable DayOfWeek using a vector of days
days <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
data$DayOfWeek <- days[data$Date$wday + 1]

# Find out what the first day and last day of data are
head(data$DayOfWeek, 1)
tail(data$DayOfWeek, 1)


# With the Master Data file formatted as needed, we can create the graph
# Since the column I want to plot is not "numeric" we need to fix this first
suppressWarnings(class(data$Global_active_power) <- "numeric")
suppressWarnings(class(data$Voltage) <- "numeric")
suppressWarnings(class(data$Global_reactive_power) <- "numeric")
suppressWarnings(class(data$Sub_metering_1) <- "numeric")
suppressWarnings(class(data$Sub_metering_2) <- "numeric")
suppressWarnings(class(data$Sub_metering_3) <- "numeric")

# After first having checked all graphs looked right on the screen, I then 
# wrapped the graphic functions in a png() function to output properly
png(file = "plot4.png")

# In order to generate 4 graphs, the par() option needs to be updated to create
# 4 graph windows on the graphic device.  Using mfrow() so the graphs will populate
# by row first, then column
par(mfrow = c(2, 2))

# Now the graphs can be created starting with a graph similar to plot 2
# The x axis is customized to show days of the week
plot(data$Global_active_power, type = "l", 
     ylab = "Global Active Power", xaxt = "n", xlab = "")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# The next graph is a line graph of the Voltage values.  It also uses the 
# Days of Week for the x axis label
plot(data$Voltage, type = "l", 
     ylab = "Voltage", xaxt = "n", xlab = "data/time")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# The next graph is similar to that used in plot 3
plot(data$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xaxt = "n", xlab = "",)
points(data$Sub_metering_2, type = "l", col = "red")
points(data$Sub_metering_3, type = "l", col = "blue")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, box.col = "white", inset = .01)

# The last graph is the Global_reactive_power graph using some similar attributes
# to that used in Plot 2
plot(data$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xaxt = "n", xlab = "data/time")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

dev.off()

# It is a good idea to now return the mfrow() to normal
par(mfrow = c(1,1))
