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

plot2 <- function(){
    # Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
    # Use the base plotting system to make a plot answering this question.
    
    # filter NEI Baltimore City fips code
    NEIBaltimore = filter(NEI, fips == "24510")
    #head(NEIBaltimore)
    
    emissTrendsBaltimore <- data.frame(aggregate(NEIBaltimore$Emissions, by=list(NEIBaltimore$year), FUN=sum))
    colnames(emissTrendsBaltimore)<- c("year","totalPm25")
    
    # build plot
    plot(emissTrendsBaltimore$year,emissTrendsBaltimore$totalPm25, col="red", type="l", 
         xlab="", ylab="Total pm25 emissions", main="Total emissions from PM2.5 in the Baltimore city 1999-2008")
    dev.copy(png, file="plot2.png", width=480, height=480)
    dev.off()
    
    print("Solution: Total emissions from PM2.5 decreased  in the Baltimore City from 1999 to 2008")
}

plot2()