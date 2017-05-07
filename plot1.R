
#import required packages
lapply(list('lubridate', 'dplyr', 'data.table', 'ggplot2'), require, character.only = TRUE)

# download and unzip data
file <- "./data/summarySCC_PM25.rds"
if(!file.exists(file)) {
    temp <- tempfile()
    print("downloading project data")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
    file <- unzip(temp)
    unlink(temp)
} else {
    print("summarySCC_PM25.rds found in working directory!")
}

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Explore NEI dataset
str(NEI)


plot1 <- function(){
    # Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
    # Using the base plotting system, make a plot showing the total PM2.5 emission 
    # from all sources for each of the years 1999, 2002, 2005, and 2008.
    # https://stats.stackexchange.com/questions/8225/how-to-summarize-data-by-group-in-r
    emissTrends <- data.frame(aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum))
    colnames(emissTrends)<- c("year","totalPm25")
    
    # build plot
    plot(emissTrends$year,emissTrends$totalPm25, col="red", type="l", 
         xlab="", ylab="Total pm25", main="Total emissions from PM2.5 in the U.S. 1999-2008")
    dev.copy(png, file="plot1.png", width=480, height=480)
    dev.off()
    
    print("Solution: Total emissions from PM2.5 decreased in the United States from 1999 to 2008")
}

plot1()




















