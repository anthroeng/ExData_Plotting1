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

# Filter data for teh required dates
tidy_data <- data %>% 
    mutate(Dates = as.Date(Date, "%d/%m/%Y")) %>%
    filter(Dates == "2007-02-01" | Dates == "2007-02-02")

# Plot the data
hist(as.numeric(tidy_data$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# Export plot to .png file
dev.print(png, file = "plot1.png", width = 480, height = 480)

