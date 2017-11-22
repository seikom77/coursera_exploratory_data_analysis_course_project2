
#down load files
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./data2/Dataset.zip", method="auto")

#unzip file
unzip(zipfile="./data2/Dataset.zip", exdir="./data2")

#road data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to
#2008? Using the base plotting system, make a plot showing the total PM2.5 emission
#from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)
total.emissions <- NEI %>%
  dplyr::group_by(year) %>%
  dplyr::summarise(Emissions=sum(Emissions))

head(total.emissions)

plot(total.emissions$year, total.emissions$Emissions, pch=16, type="o",main = "Total tons of PM2.5 Emissions", xlab="year", ylab="total PM2.5 emission")

dev.copy(png, file="plot1.png")
dev.off()
