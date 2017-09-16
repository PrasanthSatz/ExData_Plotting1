library(sqldf)

filename <- "EPC.zip"

## Downloading Electric Power Consumption Data from UCI Machine Learning Repository
if(!file.exists(filename)) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl,filename,mode="wb")
}

## Unzipping the Downloaded File

if(!file.exists("household_power_consumption.txt"))
  unzip(filename)

data <- read.csv.sql("./household_power_consumption.txt",sep=";",sql="select * from file where Date in ('1/2/2007','2/2/2007')")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

## Plotting the Plot1.png
png("plot1.png",width=480,height=480,units="px")
hist(data$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power(kilowatts)")
dev.off()
