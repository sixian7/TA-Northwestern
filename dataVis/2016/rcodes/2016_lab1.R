# Lab session 1 topics
# 1. Scatter plots
# 2. Line chart
# 3. Barplot
# 4. Histogram
# 5. Density plots
# 6. Pie chart
# 7. Dot plot
# 8. Fit distribution

# Scatter plots

rm(list=ls()) 
setwd("/Users/jieyang/Documents/course/data_visualization/2016_Spring/data")
mlbdata<-read.table("MLB.dat",header=TRUE)
plot(years,lsalary,col="red", pch=2,ylab="Log Salary",xlab="Number of Years played in the League",main="Scatter Plot Example")

grid(col="grey",lty=2,lwd=1)	
abline(lm(lsalary~years),col="blue") 
text(15,14, "Regression Line",col="blue")

# Line charts

tree1<-Orange[Orange$Tree==1,]
tree2<-Orange[Orange$Tree==2,]
tree3<-Orange[Orange$Tree==3,]

plot(tree1$age, tree1$circumference,type="l",lwd=2,lty=1,col="blue",xlab="Age (days)",ylab="Circumference (mm)",xlim=c(0,1600),ylim=c(0,220),main="Tree Growth")
lines(tree2$age,tree2$circumference, type="l",lwd=2,lty=2,col="cyan")
lines(tree3$age,tree3$circumference, type="l",lwd=2,lty=3,col="green")

legend("topleft",c("tree1","tree2","tree3"),cex=0.8,col=c("blue","cyan","green"),lwd=2,lty=1:3,title="Legend")

# Barplot

carsdata<-read.csv("04cars data.csv",header=TRUE)
attach(carsdata)
sample<-carsdata[1:30,]
example<-table(sample$Cyl,sample$Sports.Car) #watch out for the order

barplot(example, main="Cylinder distribution in sports and non-sports cars",col=c("blue","darkblue","red"),xlab="1: Sports Car, 0: Non-Sports Car",legend=rownames(example))

#grouped bar charts
#use the following option with the same command: beside=TRUE
barplot(example, main="Cylinder distribution in sports and non-sports cars",col=c("blue","darkblue","red"),xlab="1: Sports Car, 0: Non-Sports Car",legend=rownames(example),beside=TRUE)


# Histogram and density plot

hist(mtcars$mpg , breaks=10, col="grey", xlab="Miles Per Gallon", main="Histogram") 
plot(density(mtcars$mpg),col="red", xlab="Miles Per Gallon", main="Kernel Density Plot")

# Pie chart

y<-c(5,4,3,2,2,3)

pie(y,labels=letters[1:length(y)], col=rainbow(length(y)),radius = 1,clockwise=TRUE, main="Rainbow Pie Chart")

# Dot plot

sample<-carsdata[1:30,]

#simple dot plot
dotchart(as.numeric(sample$City.MPG),labels=sample$Vehicle.Name,cex=.8,main="City MPG for different Car Models",xlab="City MPG")

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

# Arrange multiple plots

par(mfrow=c(3,2))

# plot 6 times points 1 to 10
for(i in 1:6){plot(1:10)}

matrixA<-matrix(c(1,2,3,3), 2, 2, byrow=TRUE)
layout(matrixA) 

# plot 3 times points 1 to 10
for(i in 1:3){plot(1:10)}


# Fit distribution
require(MASS)
fit1 <- fitdistr(years, "exponential") 
hist(years, freq = FALSE)
curve(dexp(x, rate = fit1$estimate), col = "red", add = TRUE)
