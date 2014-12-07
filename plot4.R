system("head -n 1 household_power_consumption.txt >data.txt") ##Reads header of source file and copies into target file
system("grep '^[12]/2/2007' household_power_consumption.txt >>data.txt") ##Copies only those observations which are beween Feb-1st-20007 and Feb-02nd-2007 into target file
## Below code reads target file and creates data set with name "DT"
DT <- read.csv("data.txt", sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric"), strip.white = TRUE, na.strings = c("?",""))
## Below code creates new variable "DTTime" by concatenating "Date" and "Time" variable from "DT"
DTTime <- as.POSIXct(strptime(paste(as.character(DT[,1]), as.character(DT[,2]), sep=" "), format="%d/%m/%Y %H:%M:%S"))
## Below code creates new dataframe with name "DT_new"
DT_new <- cbind(DT, DTTime)
## Below code opens PNG file device with filename as "plot4.png"
png(filename="plot4.png", width=480, height=480)
## Below code creates nulti-paneled plotting window 
par(mfrow= c(2, 2))
## Below code plots 4 graphs row-wise i.e. 2 on 1st row and then 2 on 2nd row
plot(DT_new$DTTime, DT_new$Global_active_power, type="l", ylab="Global Active Power",xlab="")
plot(DT_new$DTTime, DT_new$Voltage, type="l", ylab="Voltage",xlab="datetime")
plot(DT_new$Sub_metering_1 ~ DT_new$DTTime, type="n", xlab="", ylab="Energy sub metering")
lines(DT_new$Sub_metering_1 ~ DT_new$DTTime, col="black")
lines(DT_new$Sub_metering_2 ~ DT_new$DTTime, col="red")
lines(DT_new$Sub_metering_3 ~ DT_new$DTTime, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty= 1, bty="n")
plot(DT_new$DTTime, DT_new$Global_reactive_power, type="l", ylab="Global_reactive_power",xlab="datetime")
dev.off() ##Closing PNG device