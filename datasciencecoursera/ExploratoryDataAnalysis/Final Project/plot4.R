# Plot 4

library(dplyr)
library(ggplot2)

createFourthPlot <- function() {
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
    SCC <- tbl_df(readRDS(classCodeFileName))
    
    combinedData <- inner_join(NEI, SCC, by = "SCC")
    
    filteredData <- combinedData %>%
        filter(year >= 1999, year <= 2008, grepl("coal", Short.Name, ignore.case = TRUE)) %>%
        select(year, Emissions) %>%
        group_by(year) %>%
        summarise(Emissions = sum(Emissions)) %>%
        print
    
    #
    # Plot 4: ggplot2 - Emissions from Coal Combustion Sources 1999-2008
    #
    with(filteredData, {
        dataPlot <- ggplot(filteredData, aes(year, Emissions)) + 
            geom_line(stat = "identity") +
            xlab("Year") +
            ylab("Total PM2.5 Emissions (tons)") +
            ggtitle("Total PM2.5 Emissions From Coal-Related Sources")
        print(dataPlot)
    })
    dev.copy(png, file = "plot4.png", width = 640, height = 640)
    dev.off()
    
}