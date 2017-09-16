filename <- "EPC.zip"

## Downloading Electric Power Consumption Data from UCI Machine Learning Repository
library(sqldf)

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

##Plotting the Plot3.png
png("plot3.png",width=480,height=480,units="px")
plot(data$Time, data$Sub_metering_1,type="l",xlab="",ylab="Energy Sub Metering")
lines(data$Time, data$Sub_metering_2, type="l",col="red")
lines(data$Time, data$Sub_metering_3, type="l",col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))
dev.off()