## This program reads the data file, constructs the fourth plot
## and saves it in the file plot4.png in the working directory


## Initialize the URL as per the assignment

url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the file and then unzip into the working directory
destfile=".\\hpc.zip"
if(!file.exists(destfile)){
        download.file(url,destfile)
        unzip("hpc.zip")
}

## Read the file into the table "power"
print("Reading Data into Table....")
power<-read.table("household_power_consumption.txt",
                  sep=";",header=TRUE,stringsAsFactors = FALSE)

## subset only the data for Feb 1 and Feb 2

febpower<-subset(power,as.Date(power$Date,format="%d/%m/%Y")=="2007-02-01" |as.Date(power$Date,format="%d/%m/%Y")=="2007-02-02" )

## Data type conversions - combine date and time into new column

febpower$Global_active_power<-as.numeric(febpower$Global_active_power)
febpower$dtime<-as.POSIXct(paste(febpower$Date, febpower$Time), format="%d/%m/%Y %H:%M:%S")

## Fourth plot begins

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
par(mar=c(4,4,1,1))
plot(febpower$dtime,febpower$Global_active_power,type="l",
     ylab="Global Active Power (Kilowatts)", xlab="")
plot(febpower$dtime,febpower$Voltage,type="l",
     ylab="Voltage", xlab="datetime")
plot(febpower$dtime,febpower$Sub_metering_1,type="l",ylab="Energy Sub Metering", xlab="")
lines(febpower$dtime,febpower$Sub_metering_2,col="orange")
lines(febpower$dtime,febpower$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2",
                           "Sub_metering_3"),
       col=c("black","orange","blue"),lty = c(1,1,1),cex=0.80)
plot(febpower$dtime,febpower$Global_reactive_power,type="l",
     ylab="Global_reactive_power", xlab="datetime")
dev.off()

print("Completed plot generation.")
