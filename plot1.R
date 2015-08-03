################################################################################
##                                                                            ##
##             Exploratory Data Analysis - Course Project 1                   ##
##    plot1.R script to generate the plot for part 1 of assignment            ##
##    The frst graph is a simple Histogram of the Global Active Power         ##
##                                                                            ##
################################################################################

# First need to read in the data from the default current working directory
# Since the file is so large and we only need a subset of the data, I have 
# read in only the data for dates February 1st and 2nd of 2007.  The data
# format in the file is D/M/YYYY so I am loading 1/2/2007 and 2/2/2007

data <- subset(read.table("household_power_consumption.txt", header = T, 
                          sep = ";", stringsAsFactors = F), 
               Date %in% c("1/2/2007", "2/2/2007"))

# Now that the Master Data file for only the dates I need is loaded, we can 
# create the graph requested.  Since the column I want to plot is not "numeric" 
# we need to fix this first.
suppressWarnings(class(data$Global_active_power) <- "numeric")

# And then create the graph to have "red" bars on it.  
# Then output to a PNG file
hist(data$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# With the graph looking as we want it - use dev.copy to create a PNG file
dev.copy(png, "plot1.png")
dev.off()
