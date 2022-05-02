# Set the working directory to the correct repository
setwd("./ExData_Plotting1/")

# Libraries
library(dplyr)

# Download, extract and read in the data
## Create a data directory
if(!file.exists("./data")){dir.create("./data")}
## Download dataset
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url,destfile="./data/Dataset.zip")
## Extract dataset
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Read in data
data <- read.table("./data/household_power_consumption.txt", sep = ";", skip = 1)
names <- read.table("./data/household_power_consumption.txt", sep = ";", nrows = 1)
colnames(data) <- as.character(names)

# Filter data for the required dates
tidy_data <- data %>% 
    mutate(Dates = as.Date(Date, "%d/%m/%Y")) %>%
    filter(Dates == "2007-02-01" | Dates == "2007-02-02")

# Convert Date/Time
tidy_data$Date_Time <- strptime(paste(tidy_data$Dates,tidy_data$Time), format = "%Y-%m-%d %H:%M:%S")

# Plot the data
plot(x = as.numeric(tidy_data$Date_Time), y = as.numeric(tidy_data$Sub_metering_1), type = "l",
     ylab = "Energy sub metering",
     xlab = "", # Makes the legend empty
     xaxt = "n", ) # Suppresses the x-axis values
lines(x = as.numeric(tidy_data$Date_Time), as.numeric(tidy_data$Sub_metering_2), col = "red")
lines(x = as.numeric(tidy_data$Date_Time), as.numeric(tidy_data$Sub_metering_3), col = "blue")
axis(side = 1, at = c(as.numeric(tidy_data$Date_Time[1]),
                      as.numeric(tidy_data$Date_Time[1440]),
                      as.numeric(tidy_data$Date_Time[2880])),labels = c("Thu","Fri","Sat"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Export plot to .png file
dev.print(png, file = "plot3.png", width = 480, height = 480)
