# Plot 1

library(dplyr)

createFirstPlot <- function() {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    zippedFileName <- "exdata-data-NEI_data.zip"
    pm25SummaryFileName <- "summarySCC_PM25.rds"
    classCodeFileName <- "Source_Classification_Code.rds"
    
    if (!file.exists(zippedFileName)) {
        download.file(fileUrl, destfile = zippedFileName, method = "curl")
        dateDownloaded <- date()
    }
    
    if (!file.exists(pm25SummaryFileName)) {
        unzip(zippedFileName)
    }
    
    if (!file.exists(classCodeFileName)) {
        unzip(zippedFileName)
    }
    
    NEI <- tbl_df(readRDS(pm25SummaryFileName))
    
    filteredData <- NEI %>%
        filter(year >= 1999, year <= 2008) %>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise(Emissions = sum(Emissions)) %>%
        print
        
    
    #
    # Plot 1: Base Plot - Total PM2.5 emission from all sources for 1999, 2002, 2005, 2008
    #
    with(filteredData, {
        plot(year, Emissions, type = "b", col = "red", lwd = 5, xaxt="n", xlab = "Year", ylab = "PM2.5 Emissions (tons)", main = "Total PM2.5 Emisions (tons)")
        axis(1, at = year, labels = year)
    })
    dev.copy(png, file = "plot1.png", width = 640, height = 640)
    dev.off()
    
}