# Plot 6

library(dplyr)
library(ggplot2)

createSixthPlot <- function() {
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
    print(combinedData)
    
    # fips == 06037: Los Angeles County
    # fips == 24510: Baltimore City
    
    # Filtered data based on fips # and if data category was onroad or nonroad.
    # Included Nonroad as that category included offroad motor vehicles. 
    filteredData <- combinedData %>%
        filter(grepl("24510|06037", fips), grepl("Onroad|Nonroad", Data.Category, ignore.case = TRUE)) %>%
        mutate(location = ifelse(fips == "06037", "Los Angeles County", "Baltimore City")) %>%
        select(year, Emissions, location) %>%
        group_by(year, location) %>%
        summarise(Emissions = sum(Emissions)) %>%
        print
    
    #
    # Plot 4: ggplot2 - Emissions from Motor Vehicle Sources in Baltimore City vs Los Angeles County 1999-2008
    #
    with(filteredData, {
        dataPlot <- ggplot(filteredData, aes(year, Emissions, color = location)) +
            geom_line() +
            xlab("Year") +
            ylab("Total PM2.5 Emissions (tons)") +
            ggtitle("Total PM2.5 Emissions in Baltimore City vs Los Angeles County from Motor Vehicle Sources") +
            labs(color = "City")
        print(dataPlot)
    })
    dev.copy(png, file = "plot6.png", width = 640, height = 640)
    dev.off()
    
}