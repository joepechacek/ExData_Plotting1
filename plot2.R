################################################################################
##                                                                            ##
##             Exploratory Data Analysis - Course Project 1                   ##
##    plot2.R script to generate the plot for part 2 of assignment            ##
##    This plot is a line graph of the Global Active Power                    ##
##                                                                            ##
################################################################################

# First need to read in the data from the default current working directory
# Since the file is so large and we only need a subset of the data, I have 
# read in only the data for dates February 1st and 2nd of 2007.  The data
# format in the file is D/M/YYYY so I am loading 1/2/2007 and 2/2/2007

data <- subset(read.table("household_power_consumption.txt", header = T, 
                          sep = ";", stringsAsFactors = F,), 
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


# With the Master Data file formatted as needed, we can create the graph.
# Since the column I want to plot is not "numeric" we need to fix this first
suppressWarnings(class(data$Global_active_power) <- "numeric")

# Create the basic plot with the y axis label and suppressing all x axis labels
# Since I know that I only grabbed 2 days of data and have confirmed that 
# the first day is Thursday and last day is Friday, I can now add the labels 
# to the x axis more simply. The data file has 2880 values, so half of that 
# will be Thu and half is Fri.  The breaks are then 0, 1440, and 2880 and for
# clarity on the graph, a label for Saturday shows the end of the data.
# Again, there was no attempt to automate this part.
plot(data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

# With the graph looking as we want it - use dev.copy to create a PNG file
dev.copy(png, "plot2.png")
dev.off()
