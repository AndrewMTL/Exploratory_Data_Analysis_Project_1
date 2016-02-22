## Load data from text file into variable "consumption" if not loaded already
## Converts Date column to Date format and creates a new column with POSIX Date/Time format

if(exists("consumption")==FALSE) {
    consumption<-read.csv("household_power_consumption.txt",sep=";",na.strings="?")
    consumption$Date<-as.Date(consumption$Date,format="%d/%m/%Y")
    consumption$DateTime<-paste(consumption$Date,consumption$Time,sep=" ")
    consumption$DateTime<-strptime(consumption$DateTime,format="%Y-%m-%d %H:%M:%S")
}

## Subset the data to just Feb 1st and 2nd, 2007 if not already done

if(exists("consumption_subset")==FALSE) {
    consumption_subset<-subset(consumption,Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
}

## Create Plot 4

png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(consumption_subset,plot(DateTime, Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(consumption_subset,plot(DateTime, Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(consumption_subset,plot(DateTime, Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(consumption_subset,points(DateTime, Sub_metering_2, type="l", col="red"))
with(consumption_subset,points(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2)
with(consumption_subset,plot(DateTime, Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
dev.off()