################################################################################
##                                                                            ##
##             Exploratory Data Analysis - Course Project 1                   ##
##    plot3.R script to generate the plot for part 3 of assignment            ##
##    This plot is a line graph of the three Sub Metering data                ##
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
class(data$Sub_metering_1) <- "numeric"
class(data$Sub_metering_2) <- "numeric"
class(data$Sub_metering_3) <- "numeric"

# Create the first layer of the plot. This graph has 3 lines of different colors,
# so the first plot function is for the first Sub_meter data with subsequent points()
# being added for 2 more lines for the remaining 2 Sub_meters.
# The final item to add is a legend in the upper right corner with the
# corresponding colors.  The plot will be output as a PNG file
png(file = "plot3.png", width = 480, height = 480)

plot(data$DateTime, data$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering",
     xlab = "")
points(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
points(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()