# Assignment 1, Part 2

library (dplyr)

createSecondPlot <- function() {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zippedFileName <- "household_power_consumption.zip"
    unzippedFileName <- "household_power_consumption.txt"
    
    if (!file.exists(zippedFileName)) {
        download.file(fileUrl, destfile = zippedFileName, method = "curl")
        dateDownloaded <- date()
    }
    
    if (!file.exists(unzippedFileName)) {
        unzip(zippedFileName)
    }
    
    # Read the data, convert the dates & times, and filter so we have a 
    # smaller data set to work with
    consumptionData <- tbl_df(read.table(file.path("./", unzippedFileName), header = TRUE, na.strings = "?", sep = ";"))
    consumptionData$Date <- as.Date(consumptionData$Date, "%d/%m/%Y")
    str(consumptionData)
    
    selectedConsumptionData <- consumptionData %>%
        filter(Date >= "2007-02-01", Date <= "2007-02-02") %>%
        mutate(datetime = as.POSIXct(paste(Date, Time))) %>%
        select(datetime, Global_active_power:Sub_metering_3, -Date, -Time) %>%
        arrange(datetime) %>%
        print
    
    #
    # Plot 2: Global Active Power Over Time
    #
    with(selectedConsumptionData,
         plot(Global_active_power~datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
    dev.copy(png, file = "plot2.png", width = 480, height = 480)
    dev.off()
    
}