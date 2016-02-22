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

## Create Plot 1

png(file="plot1.png",width=480,height=480)
hist(consumption_subset$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()