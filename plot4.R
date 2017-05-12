# Course Project 1
# Plot4
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
# Format date col
ElectricPowerConsuption$Date <- as.Date(ElectricPowerConsuption$Date,format="%d/%m/%Y")
# Merge Date and Time cols
DateTime <- as.POSIXct(paste(ElectricPowerConsuption$Date, ElectricPowerConsuption$Time), format="%Y-%m-%d %H:%M:%S")

# 2 rows, 2 cols of plots
par(mfrow = c(2,2)) 
# margins
par(mar = c(4,4,1,1))

# make time series line plot (global active power vs. time)
plot(DateTime,ElectricPowerConsuption$Global_active_power,ylab = "Global Active Power",xlab = "",type = "l")

# make time series line plot (voltage vs. time)
plot(DateTime,ElectricPowerConsuption$Voltage,ylab = "Voltage",type = "l",xlab = "datetime")

# plot multiple series on the same plot
plot(ElectricPowerConsuption$Sub_metering_1~DateTime, col = "black",type = "l",ylab = "Energy sub metering",xlab = "")
points(ElectricPowerConsuption$Sub_metering_2~DateTime, col = "red",type = "l")
points(ElectricPowerConsuption$Sub_metering_3~DateTime, col = "blue",type = "l")
# set up legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1, col = c("black","red","blue"),bty = "n")

# make time series line plot (global reactive power vs. time)
plot(DateTime,ElectricPowerConsuption$Global_reactive_power,ylab = "Global_reactive_power",type = "l",xlab = "datetime")

# save to PNG file
dev.copy(png, file = "./data/plot4.png",height = 480,width = 480)
dev.off()
