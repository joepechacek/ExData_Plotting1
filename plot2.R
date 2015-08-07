################################################################################
##                                                                            ##
##             Exploratory Data Analysis - Course Project 1                   ##
##    plot2.R script to generate the plot for part 2 of assignment            ##
##    This plot is a line graph of the Global Active Power                    ##
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

# The column I want to plot is not "numeric", so need to fix this first.
class(data$Global_active_power) <- "numeric"

# Create a line graph with the DateTime on the x-axis and power on the y-axis.
# This is output to a png file.

png(file = "plot2.png", width = 480, height = 480)

plot(data$DateTime, data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.off()
