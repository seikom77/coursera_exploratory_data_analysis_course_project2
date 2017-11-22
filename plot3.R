
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

#3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
dt3 <- NEI %>%
  dplyr::filter(fips=="24510") %>%
  dplyr::group_by(year, type) %>%
  dplyr::summarise(Emissions=sum(Emissions))

library(ggplot2)
g <- ggplot(dt3, aes(x=year, y=Emissions, colour=type))
g <- g + geom_line()
g <- g + ggtitle("Total tons of PM"[2.5]*" Emissions im Maryland comparing types of sources") + xlab("year")+ylab("total PM"[2.5]*" Emission")
print(g)

ggsave("plot3.png")

