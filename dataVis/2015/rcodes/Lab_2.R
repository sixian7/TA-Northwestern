#the inputs for creating the data sample
closeAllConnections()
rm(list=ls())
setwd("/Users/jieyang/Documents/course/data_visualization/2016_Spring/data")

#go over lab exercise 1?

###########   boxplots    ###########  

#good for individual variables oror variables by group
attach(mtcars)
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon")

#add colors
boxplot(mpg~cyl,data=mtcars, main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon",col=(c("blue","red","green")))

#can do other fancy things..
library(aplpack)
bagplot(wt,mpg, xlab="Car Weight", ylab="Miles Per Gallon",
        main="Bagplot")


###########   subsetting    ###########  

#start with subsetting
#read cars data set

#nice trick for missing values
detach(mtcars)
carsdata<-read.csv("04cars data.csv",header=TRUE,na.strings=c("","*","NA"))
mydata <- carsdata[1:20,1:13]
attach(mydata)

#selecting variables by name
myvars <- c("Vehicle.Name","Wagon","SUV")
newdata <- mydata[myvars]

#selecting columns directly:
newdata <- mydata[c(1,2:4)]

#dropping columns 1 and 3
newdata <- mydata[c(-1,-3)]

#OR (more complicated)

names(mydata) # equivalent to colnames(mydata)
rownames(mydata)

myvars <- names(mydata) %in% c("Vehicle.Name","Wagon","SUV")
newdata <- mydata[,!myvars]

#selecting obsevations
newdata <- mydata[1:5,]


#selection based on specific values
newdata <- mydata[ which(Cyl==6),]
newdata <- mydata[ (Cyl==6 & Retail.Price < 40000),]
#can also use OR

#a really nice way to select observations and variables at the same time:
#the subset function

newdata <- subset(mydata, Retail.Price<40000 & Cyl==6, select=c(Vehicle.Name))
newdata <- subset(mydata, Retail.Price<40000 & AWD==1, select=c(Vehicle.Name,Retail.Price:Cyl))

#grep -- what is it?
#used for searching text and matching sequence of characters.
detach(mydata)
attach(carsdata)
Mazda<-carsdata[grep(("Mazda"),Vehicle.Name),]
Mazdaind <- grep("Mazda",carsdata$Vehicle.Name,value=FALSE)
Mazda_Dodge <- carsdata[grep(("Mazda|Dodge"),Vehicle.Name),]

#grep has interesting arguments
# 1) "ignore.case" if FALSE, the pattern matching is case sensitive and if TRUE, 
#case is ignored during matching.
# 2) "value" if FALSE, a vector containing the (integer) indices of the matches 
#determined by grep is returned, and if TRUE, a vector containing the matching elements themselves is returned.
# 3) "invert" if TRUE return indices or values for elements that do not match.

#Take Random Sample 
mysample <- carsdata[sample(1:nrow(mydata), 5,replace=FALSE),]



###########   lattice package    ###########  

#Lattice Graphs: useful for studying multivariate relationships,
#and especially for conditioning on variables.

detach(carsdata)
attach(mtcars)

library(lattice)

# basic command is 

graph_type(formula, data=...)

# Formula syntax is important:

# ~x|A means display the numeric variable x for each level of factor A.

# y~x | A*B means display the relationship between numeric variables y and x seperately for every combination of factor A and B levels

# ~x means display the numeric variable x alone

#can accomodate almost any type of graph type:
#the commands are:
# barchart        -- bar chart
# bwplot          -- box plot
# densityplot     -- kernel density plot
# dotplot         -- dotplot
# histogram       -- histogram
# splom           -- scatterplot matrix
# xyplot          -- scatterplot


gear.f<-factor(gear,levels=c(3,4,5),
               labels=c("3gears","4gears","5gears")) 
cyl.f <-factor(cyl,levels=c(4,6,8),
               labels=c("4cyl","6cyl","8cyl")) 

# kernel density plot 
densityplot(~mpg, 
            main="Density Plot", 
            xlab="Miles per Gallon")

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



###########   Correlograms    ###########  


#Correlograms:
#install corrgram

#The command is:

#corrgram(x, order = , panel=, lower.panel=, upper.panel=, text.panel=, diag.panel=)

#x is a data frame with one observation per row.
#order=TRUE will cause the variables to be ordered using principal component analysis of the correlation matrix.
#panel= refers to the off-diagonal panels:

#Off-Diagonal Panels:  
  
#1) panel.pie (the filled portion of the pie indicates the magnitude of the correlation)
#2) panel.shade (the depth of the shading indicates the magnitude of the correlation)
#3) panel.ellipse (confidence ellipse and smoothed line)
#4) panel.pts (scatterplot)

#Main diagonal Panels:

#1) panel.minmax (min and max values of the variable)
#2) panel.txt (variable name).

##
# Example 1
library(corrgram)
corrgram(carsdata[,8:16], order = F, lower.panel = panel.shade, upper.panel = panel.pie, 
         text.panel = panel.txt,
         main = "Correlation diagram for Car Data Set")

# Example 2
corrgram(carsdata[,8:16], order = T, lower.panel = panel.ellipse, upper.panel = panel.pts, 
         text.panel = panel.txt,
         diag.panel=panel.minmax,
         main = "Correlation diagram for Car Data Set")

#change colors for the homework


###########   probability plots    ###########  


#generate random variables:
x <- rnorm(1000,0,1)
hist(x)

# plot the density function of a normal distribution
x <- seq(-10,10,length=500)
mydens <- dnorm(x,2,1)
plot(x,mydens)

#QQ plots
x <- rt(1000, df=3)
hist(x)
#check fit
y=rnorm(1000,0,1)
qqplot(y,x,ylim=range(c(y,x)),xlim=range(c(y,x)),main="QQ plot")
qqline(x)
qqline(y,col='red')

#fitting distributions

library(MASS)
mlbdata<-read.table("MLB.dat",header=TRUE)
attach(mlbdata)
# estimate the parameters
fit1 <- fitdistr(years, "exponential") 
# plot a graph
hist(years, freq = F) #what happens if freq = T?
curve(dexp(x, rate = fit1$estimate), col = "red", add = TRUE)

detach(mlbdata)


