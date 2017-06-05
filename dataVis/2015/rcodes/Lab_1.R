# Lab session 1 topics
# 1. Scatter plots
# 2. Fitting line through data
# 3. Plot two charts together
# 4. Histogram
# 5. Dot plot
# 6. Line chart
# 7. Bar plots
# 8. Fitting distribution

#the inputs for creating the data sample
rm(list=ls()) # remove all objects in memory
setwd("/Users/jieyang/Documents/course/data_visualization/2016_Spring/data")

#contains observations on the salary, performance and other characteristics
#for 353 Major League Baseball players for the year 1993

mlbdata<-read.table("MLB.dat",header=TRUE)

#nice trick
attach(mlbdata) #don't forget to detach data after you are done


######################   Scatter Plots   ######################  

#create a simple plot
plot(years,lsalary)

#adding colors:
plot(years,lsalary,col="blue")

#changing point type
plot(years,lsalary,col="blue",pch=1) #plot character
#1 is circles
#2 is triangles
#3 is crosses ...

#adding labels to the axes:
plot(years,lsalary,col="red", pch=2,ylab="Log Salary",xlab="Number of Years played in the League",main="Scatter Plot Example") 

title("blabla")
#add title
#use main="    "

######################   FITTING LINES THROUGH DATA   ######################  

#Fit lines through the data
abline(lm(lsalary~years),col="blue",lty=2,lwd=5)    #simple linear regression
#lty stands for line type: 
#0 is blank
#1 is solid
#2 is dashed
#3 is dotted etc...

#lwd stands for line width:
#the larger the value, the thicker the line

lines(lowess(lsalary~years),col="green")   #lowess -- locally weighted scatterplot smoothing


#add legend
legend(x=14,y=12,legend=c("linear regression","lowess"),col=c("blue","green"),lty=c(2,1),cex=)
#cex controls to the size of the legend



######################  TWO PLOTS ON SAME FIGURE   ######################  

#years>10
years_g10<-years[which(years>10)]

#and years<=10
years_le10<-years[which(years<=10)]

#salary for years>10
lsalary_g10<-lsalary[which(years>10)]

#salary for years<=10
lsalary_le10<-lsalary[which(years<=10)]

#start with plots:
plot(years_g10,lsalary_g10,col="blue")
par(new=TRUE)
plot(years_le10,lsalary_le10,col="red")

#what is the problem? axes are duplicated!
#how to solve the problem
plot(years_g10,lsalary_g10,ylim=range(c(lsalary_g10,lsalary_le10)),xlim=range(c(years_g10,years_le10)),main="Log salary versus years",xlab="years",ylab="log salary",col="blue")
abline(lm(lsalary_g10~years_g10),col="blue")
par(new=TRUE)
plot(years_le10,lsalary_le10,ylim=range(c(lsalary_g10,lsalary_le10)),xlim=range(c(years_g10,years_le10)),axes=F,xlab="",ylab="",col="red")
abline(lm(lsalary_le10~years_le10),col="red")


plot(tree1$age, tree1$circumference,type="l",lwd=2,lty=1,col="blue",xlab="Age (days)",ylab="Circumference (mm)",xlim=c(0,1600),ylim=c(0,220),main="Tree Growth")

######################  HISTOGRAMS   ######################  

#simple histograms
hist(years)

#add color and change size of bins
#the larger the breaks, the larger the size of the bins
hist(years,breaks=100,col="red")

#Kernel Density plots
#better way to visualizae the distribution of variables
d<-density(years)
plot(d)

#colors
polygon(d,col="red",border="green")

#combining histograms (or whatever graphic you want)
par(mfrow=c(1,2))
hist(years)
hist(bavg)



######################  DOT PLOTS   ######################  
#import another data set
detach(mlbdata)
carsdata<-read.csv("04cars data.csv",header=TRUE)
attach(carsdata)

#take small sample for illustration
sample<-carsdata[1:30,]

#simple dot plot
dotchart(as.numeric(sample$City.MPG),labels=sample$Vehicle.Name,cex=.8,main="City MPG for different Car Models",xlab="City MPG")
#if you try it without as.numeric you get the following error:
#       'x' must be a numeric vector or matrix

#grouping and sorting:

#sort them by City.MPG
x<-sample[order(sample$City.MPG),]

#group them based on number of cylinders
x$Cyl <- factor(x$Cyl)  #to group things, must first turn them into factors

#now create color groups:
x$color[x$Cyl==4] <- "green"
x$color[x$Cyl==6] <- "darkgreen"
x$color[x$Cyl==8] <- "red"

dotchart(as.numeric(x$City.MPG),labels=x$Vehicle.Name,cex=.8,groups=x$Cyl,color=x$color)




######################  LINE CHARTS   ######################  

#Line charts are used when we have points (x,y) and we want to connect them with a line
#follows plot command
#create data
x <- c(-10:10) 
y <- (x^2)  

#no plotting
plot(x,y,type="n") #n stands for no plotting, the focus is on the line
lines(x, y, type="l")

#if plotting type is not specified, data points will always be visible.


#type refers to the type of the line:
#p is points
#l is line
#o is overplotted points and lines
#....



######################  BAR PLOTS   ######################  


#simple Bar plots
#must first convert to table!
example<-table(carsdata$City.MPG)
barplot(example, main = "City MPG distribution for all cars", xlab="Frequency",horiz=TRUE)

#can change to horizontal barplot by adding -- horiz=TRUE

#stacked bar charts
#distribution of cylinders in sports and non-sports cars
sample<-carsdata[1:30,]
example<-table(sample$Cyl,sample$Sports.Car) #watch out for the order

barplot(example, main="Cylinder distribution in sports and non-sports cars",col=c("blue","darkblue","red"),xlab="1: Sports Car, 0: Non-Sports Car",legend=rownames(example))

#grouped bar charts
#use the following option with the same command: beside=TRUE
barplot(example, main="Cylinder distribution in sports and non-sports cars",col=c("blue","darkblue","red"),xlab="1: Sports Car, 0: Non-Sports Car",legend=rownames(example),beside=TRUE)

##remaining: pie charts and boxplots

######################  FITTING DISTRIBUTIONS    ######################  
require(MASS)

# estimate the parameters
fit1 <- fitdistr(years, "exponential") 
# plot a graph
hist(years, freq = FALSE)
curve(dexp(x, rate = fit1$estimate), col = "red", add = TRUE)