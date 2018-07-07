# Assignment 1, Part 3

library (dplyr)

createThirdPlot <- function() {
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
    # Plot 3: Energy Sub Metering Over Time
    #
    with(selectedConsumptionData, {
        plot(Sub_metering_1~datetime, ylab = "Energy sub metering", xlab = "", col = "black", type = "l")
        lines(Sub_metering_2~datetime, col = "red")
        lines(Sub_metering_3~datetime, col = "blue")
        legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    })
    dev.copy(png, file = "plot3.png", height = 480, width = 480)
    dev.off()
}