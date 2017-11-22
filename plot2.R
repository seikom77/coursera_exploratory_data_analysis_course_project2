
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

#2. Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question.


maryland <- NEI %>%
  dplyr::filter(fips=="24510") %>%
  dplyr::group_by(year) %>%
  dplyr::summarise (Emissions=sum(Emissions))

plot(maryland$year, maryland$Emissions, pch=16, type="o",main = "Total tons of PM2.5 Emissions in Maryland", xlab="year", ylab="total PM2.5 emission")

dev.copy(png, file="plot2.png")
dev.off()
