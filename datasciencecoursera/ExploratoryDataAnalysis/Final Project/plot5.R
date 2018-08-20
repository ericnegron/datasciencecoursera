# Plot 5

library(dplyr)
library(ggplot2)

createFifthPlot <- function() {
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
    
    # fips == 24510: Baltimore City
    # Included Nonroad as that category included offroad motor vehicles. 
    filteredData <- combinedData %>%
        filter(year >= 1999, year <= 2008, fips == "24510", grepl("Onroad|Nonroad", Data.Category, ignore.case = TRUE)) %>%
        select(year, Emissions, Data.Category) %>%
        group_by(year, Data.Category) %>%
        summarise(Emissions = sum(Emissions)) %>%
        print
    
    #
    # Plot 4: ggplot2 - Emissions from Motor Vehicle Sources in Baltimore City 1999-2008
    #
    with(filteredData, {
        dataPlot <- ggplot(filteredData, aes(year, Emissions, color = Data.Category)) +
            geom_line() +
            xlab("Year") +
            ylab("Total PM2.5 Emissions (tons)") +
            ggtitle("Total PM2.5 Emissions in Baltimore City from Motor Vehicle Sources") +
            labs(color = "Vehicle Type")
        print(dataPlot)
    })
    dev.copy(png, file = "plot5.png", width = 640, height = 640)
    dev.off()
    
}