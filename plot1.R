# Course Project 1
# Plot1
if(!file.exists("./data")){dir.create("./data")}

library(downloader)
# download zip file from website
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileURL,dest="./data/exdata_data_household_power_consumption.zip",mode="wb")
# unzip file
unzip("./data/exdata_data_household_power_consumption.zip",exdir = "./data")

# read ";" separated .txt file
# only use data from the dates 2007-02-01 and 2007-02-02
ElectricPowerConsuption = read.table("./data/household_power_consumption.txt",sep = ";",skip = 66637,nrows = 2880)
# name columns
colnames(ElectricPowerConsuption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                                       "Sub_metering_1","Sub_metering_2","Sub_metering_3")
# make histogram
hist(ElectricPowerConsuption$Global_active_power,xlab = "Global Active Power (kilowatts)",main = "Global Active Power",col = "red",ylim = c(0,1200))
# save to PNG file
dev.copy(png, file = "./data/plot1.png",height = 480,width = 480)
dev.off()
