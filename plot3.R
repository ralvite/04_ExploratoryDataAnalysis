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


plot3 <- function(){
    # Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
    # which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
    # Which have seen increases in emissions from 1999-2008? 
    # Use the ggplot2 plotting system to make a plot answer this question.
    
    # filter NEI Baltimore City fips code
    NEIBaltimore = filter(NEI, fips == "24510")
    #head(NEIBaltimore)
    
    emissTrendsBaltByType <- data.frame(aggregate(NEIBaltimore$Emissions, by=list(NEIBaltimore$year,NEIBaltimore$type), FUN=sum))
    colnames(emissTrendsBaltByType)<- c("year","type","totalPm25")
    
    # qplot(year, totalPm25, data = emissTrendsBaltByType, color = type, geom = c("line") )
    
    g <- ggplot(emissTrendsBaltByType, aes(year, totalPm25))
    g + geom_line(aes(color=type))
    
    dev.copy(png, file="plot3.png", width=480, height=480)
    dev.off()
}

plot3()
