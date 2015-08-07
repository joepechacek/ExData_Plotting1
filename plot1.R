################################################################################
##                                                                            ##
##             Exploratory Data Analysis - Course Project 1                   ##
##    plot1.R script to generate the plot for part 1 of assignment            ##
##    The frst graph is a simple Histogram of the Global Active Power         ##
##                                                                            ##
################################################################################

# First need to read in the data from the default current working directory
# Since the file is so large and we only need a subset of the data, I have 
# read in only the data for dates February 1st and 2nd of 2007.  The date
# format in the file is D/M/YYYY so I am subsetting on 1/2/2007 and 2/2/2007

data <- subset(read.table("household_power_consumption.txt", header = TRUE, 
                          sep = ";", stringsAsFactors = FALSE), 
               Date %in% c("1/2/2007", "2/2/2007"))

# The column I want to plot is not "numeric", so need to fix this first.
class(data$Global_active_power) <- "numeric"

# Now create the graph to have "red" bars and output to a PNG file
png(file = "plot1.png", width = 480, height = 480)

hist(data$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
