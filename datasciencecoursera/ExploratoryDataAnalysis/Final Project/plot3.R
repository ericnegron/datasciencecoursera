# Plot 3

library(dplyr)
library(ggplot2)

createThirdPlot <- function() {
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

    # fips == 24510: Baltimore City    
    filteredData <- NEI %>%
        filter(year >= 1999, year <= 2008, fips == "24510") %>%
        select(year, Emissions, type) %>%
        group_by(year, type) %>%
        summarise(Emissions = sum(Emissions)) %>%
        print
    
    
    #
    # Plot 3: ggplot2 - Emissions in Baltimore City by type
    #
    with(filteredData, {
        dataPlot <- ggplot(filteredData, aes(year, Emissions, color = type)) +
            geom_line() + 
            xlab("Year") +
            ylab("Total PM2.5 Emissions (tons)") +
            ggtitle("Total PM2.5 Emissions in Baltimore City, MD by Emission Source Type")
        print(dataPlot)
    })
    dev.copy(png, file = "plot3.png", width = 640, height = 640)
    dev.off()
    
}