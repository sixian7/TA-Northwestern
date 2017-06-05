# Lab session 2 topics
# Review session 1
# Boxplot
# Lattice package
# Corrgram package
# Q-Q plot

rm(list=ls()) 
setwd("/Users/jieyang/Documents/course/data_visualization/2016_Spring/data")

# Session 1 review
# Histogram
par(mfrow=c(2,2))
hist(mtcars$mpg , breaks=10, col="grey", xlab="Miles Per Gallon", main="Histogram")
hist(mtcars$mpg , breaks=20, col="grey", xlab="Miles Per Gallon", main="Histogram")
hist(mtcars$mpg , breaks=c(10,15,25,50), col="grey", xlab="Miles Per Gallon", main="Histogram")
hist(mtcars$mpg , breaks=10, col="grey", xlab="Miles Per Gallon", main="Histogram",xlim=c(10,50))

# Boxplot
#good for individual variables oror variables by group
dev.off()
attach(mtcars)
matrixA<-matrix(c(1,2,3,3), 2, 2, byrow=TRUE)
layout(matrixA)
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon")

#add colors
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon",col=(c("blue","red","green")))

#horizontal

boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon",col=(c("blue","red","green")),horizontal=TRUE)

#add points
dev.off()
install.packages("beeswarm")
library(beeswarm)
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon")
beeswarm(mpg ~ cyl, data =mtcars, col = 4, pch = 16, add = TRUE)

#boundary color
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon",border=(c("blue","red","green")))

# Lattice package

library(lattice)

gear.f<-factor(gear,levels=c(3,4,5),
               labels=c("3gears","4gears","5gears")) 
cyl.f <-factor(cyl,levels=c(4,6,8),
               labels=c("4cyl","6cyl","8cyl")) 

# histogram by factor level 
histogram(~mpg|cyl.f, 
          main="Histogram by Number of Cylinders",
          xlab="Miles per Gallon")

#  histogram by factor level (alternate layout) 
histogram(~mpg|cyl.f, 
          main="Histogram Plot by Numer of Cylinders",
          xlab="Miles per Gallon", 
          layout=c(1,3))

#  histogram for combination of factors
histogram(~mpg|cyl.f*gear.f, 
          main="Histogram by Cylinders and Gears", 
          xlab="Miles Per Gallon")

#  boxplot for combination of factors
bwplot(~mpg|cyl.f*gear.f, 
       main="Histogram by Cylinders and Gears", 
       xlab="Miles Per Gallon")

# Correlogram
carsdata<-read.csv("04cars data.csv",header=TRUE)
attach(carsdata)

library(corrgram)
corrgram(carsdata[,8:16], order = F, lower.panel = panel.shade, upper.panel = panel.pie, 
         text.panel = panel.txt,
         main = "Correlation diagram for Car Data Set")

corrgram(carsdata[,8:16], order = T, lower.panel = panel.ellipse, upper.panel = panel.pts, 
         text.panel = panel.txt,
         diag.panel=panel.minmax,
         main = "Correlation diagram for Car Data Set")

# colorRampPalette example

col<- colorRampPalette(c("blue", "white", "red"))(20)
fakedata<-rep(1,20)
pie(fakedata,clockwise = T,col=col)

# 
library(corrplot)
source("http://www.sthda.com/upload/rquery_cormat.r")
mydata<-carsdata[,8:16]
rquery.cormat(mydata,type="full")

#check variable's type
sapply(mydata,mode)

#convert * to NA
mydata$City.MPG<-as.numeric(as.character(mydata$City.MPG))
mydata$Hwy.MPG<-as.numeric(as.character(mydata$Hwy.MPG))
mydata<-na.omit(mydata)

rquery.cormat(mydata,type="full")

#quantile-quantile plot

x <- rnorm(2000)
par(mfrow = c(2, 1))
hist(x)
qqnorm(x)
qqline(x)

x <- rchisq(2000, 5)
par(mfrow = c(2, 1))
hist(x)
qqnorm(x)
qqline(x)


