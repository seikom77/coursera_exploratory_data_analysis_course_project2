
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

#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
SCC.sub <- SCC[grepl("Motor Vehicle" , SCC$Short.Name), ]
NEI.sub <- NEI[NEI$SCC %in% SCC.sub$SCC, ]

dt5 <- NEI.sub %>%
  dplyr::group_by(year) %>%
  dplyr::summarise(Emissions = sum(Emissions))

g <- ggplot(dt5, aes(x=year, y=Emissions))
g <- g + geom_line()
g <- g + ggtitle("Total tons of PM2.5 Emissions from Motor Vehicle in United Stets")
g <- g + xlab("year") + ylab("Total tons of PM2.5Emissions")
print(g)

ggsave("plot5.png")
