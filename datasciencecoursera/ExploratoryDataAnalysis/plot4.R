# Assignment 1, Part 4

library (dplyr)

createFourthPlot <- function() {
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
    # Plot 4: Multi-Row/Multi-Column Plot
    #
    par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
    with(selectedConsumptionData, {
        plot(Global_active_power~datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
        plot(Voltage~datetime, type = "l")
        plot(Sub_metering_1~datetime, ylab = "Energy sub metering", xlab = "", col = "black", type = "l")
        lines(Sub_metering_2~datetime, col = "red")
        lines(Sub_metering_3~datetime, col = "blue")
        legend("topright", lty = 1, lwd = 2, bty = "n", cex = 0.75, xjust = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~datetime, type = "l")
    })
    
    dev.copy(png, file = "plot4.png", width = 480, height = 480)
    dev.off()

}