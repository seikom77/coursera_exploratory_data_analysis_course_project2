
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


#6. Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽").
#Which city has seen greater changes over time in motor vehicle emissions?

SCC.sub <- SCC[grepl("Motor Vehicle" , SCC$Short.Name), ]
NEI.sub <- NEI[NEI$SCC %in% SClC.sub$SCC, ]

dt6 <- NEI.sub %>%
  dplyr::filter(fips=="24510"|fips=="06037") %>%
  dplyr::group_by(year, fips) %>%
  dplyr::summarise(Emissions=sum(Emissions))

g <- ggplot(dt6, aes(x=year, y=Emissions, fill=fips))
g <- g + geom_bar(stat="identity")
g <- g + facet_grid(fips ~ .)
g <- g + ggtitle("Total tons of PM2.5 Emissions from Motor Vehicle in United Stets")
g <- g + xlab("year") + ylab("Total tons of PM2.5Emissions")
g <- g + scale_fill_discrete(name="City Name",
                           labels=c("06037(California)", "24510(Baltimore)"))
print(g)

ggsave("plot6.png")
