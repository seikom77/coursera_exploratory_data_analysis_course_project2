
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


#4. Across the United states, how have emissions from coal combustion-related sources changed from 1999–2008?
SCC.sub <- SCC[grepl("Coal" , SCC$Short.Name), ]
NEI.sub <- NEI[NEI$SCC %in% SCC.sub$SCC, ]

dt4 <- NEI.sub %>%
  dplyr::group_by(year, type) %>%
  dplyr::summarise(Emissions=sum(Emissions))

g <- ggplot(dt4, aes(x=year, y=Emissions, fill=type))
g <- g + geom_bar(stat="identity")
g <- g +facet_grid(. ~ type) +
  xlab("Year") +
  ylab(expression("Total Tons of PM"[2.5]*" Emissions")) +
  ggtitle(expression(atop("Total Tons of PM"[2.5]*" Emissions in the United States", paste("from Coal Combustion-Related Sources")))) +
  theme(plot.margin = unit(c(1,1,1,1), "cm")) +
  scale_fill_brewer(palette = "Dark2") +
  guides(fill = FALSE)
print(g)

ggsave("plot4.png")

#5. How have emission
