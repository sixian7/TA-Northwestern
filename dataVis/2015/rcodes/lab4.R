#Lab 4

#Project airline data

library(DBI)
library(RPostgreSQL)

con=dbConnect(PostgreSQL(), user="labuser95", password="", dbname="datavis2015", host="gpdb")
data=dbGetQuery(con, "select * from ontime limit 10")

#Lab2 Q-Q plot
x<-rexp(1000, rate=3)
y<-rchisq(1000,df=1)

qqplot(x,y,ylim=range(c(y,x)),xlim=range(c(y,x)),main="QQ plot",asp=0.25)
abline(lm(quantile(y,c(.25,.75))~quantile(x,c(.25,.75))),col="red")
points(quantile(x,c(.25,.75)),quantile(y,c(.25,.75)),col="blue",cex=2,bg="blue",pch=21)


#the inputs for creating the data sample
closeAllConnections()
rm(list=ls())
setwd("/Users/jieyang/Desktop/2015_Spring/Data visulization/Jie/Dataset")

#comments about hw1

carsdata<-read.csv("04cars data.csv",header=TRUE,na.strings=c("","*","NA"))
attach(carsdata)


#baby version of ggplot2 is qplot()
library(ggplot2)

#Look at syntax of qplot()

qplot(x, y, data=, color=, shape=, size=, alpha=, geom=, 
      method=, formula=, facets=, xlim=, ylim= xlab=, ylab=, main=, sub=)

1)
#color, shape, size, fill: associating the level of a variable with color, shape, size
#e.g. color is used for lines, 
# density and box fill associates fill colors with variable
#Legends done automatically

2)
#facets used for conditioning on variables

3)
#geom: specifies the geometric objects that define graph type.
# point
# smooth
# boxplot
# line
# histogram
# density
# bar
# jitter

4) 
#alpha controls the transparency for overlapping elements. Goes from 0 (complete transparency) to 1
#(complete opacity)

5)
#sub just means subtitle

6)
#method, formula
# if geom = "smooth", a loess line and confidence limits are added. 
# methods include "lm", "gam" etc.
# formula gives form of the fit

#basic plot
qplot(HP,Retail.Price, data = carsdata, geom = "point",main="Retail Price VS HorsePower")

#linear regression
qplot(HP,Retail.Price, data = carsdata, geom = "smooth",formula=y~x, method="lm",main="Retail Price VS HorsePower", se=FALSE)


# kernel density plot
qplot(City.MPG, data=newcardata, geom="density", fill="red", 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")

#multiple kernel density plots
mydata <- carsdata[1:50,]

#create factor for number of cylinders
mydata$Cyl <- factor(mydata$Cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 

qplot(City.MPG, data=mydata, geom="density", fill=Cyl, alpha=I(.9), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")

#http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
qplot(City.MPG, data=mydata, geom="density", fill=Cyl, alpha=I(.9), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")+scale_fill_manual(values=c("red", "blue", "green"))

######################

#ggplot -- the real thing

# grammar of graphics idea:
A plot is a combination of layers: 1) data 2) mapping of aesthetics 3) geometry

#Aesthetics:
#x, y, and color are called aesthetics. other aesthetics are size and shape

#Geometries:
# the visual element you see in the plot itself. examples: point, line, bar etc..


#simple qplot
qplot(HP,Retail.Price, data = carsdata, geom = "point",main="Retail Price VS HorsePower")

#how to do this with ggplot?

ggplot(carsdata, aes(x=HP, y=Retail.Price)) +geom_point(point=2)


######################

#regression lines with ggplot()

#lets also add another layer

ggplot(carsdata, aes(x=HP, y=Retail.Price)) +geom_point(point=0) + geom_smooth(method=lm, se=FALSE)

#by default has a 95% confidence interval

# do loess smoothing

ggplot(carsdata, aes(x=HP, y=Retail.Price)) +geom_point(point=0) + geom_smooth()


######################

#conditional colors and shapes

ggplot(carsdata, aes(x=HP, y=Retail.Price, color=Engine.Size..l.)) + geom_point(point=0)

carsdata$Sports.Car <- factor(carsdata$Sports.Car,levels=c(0,1),
                     labels=c("nonsports","sports")) 


# Multiple regression lines
ggplot(carsdata, aes(x=HP, y=Retail.Price, color=Sports.Car)) + geom_point(point=0) +
  geom_smooth(method=lm)   # Add linear regression lines
              
# Extend the regression lines beyond the domain of the data
ggplot(carsdata, aes(x=HP, y=Retail.Price, color=Sports.Car)) + geom_point(point=0) +
geom_smooth(method=lm,fullrange=T)  

# Set shape by condition
#http://www.cookbook-r.com/Graphs/Shapes_and_line_types/
ggplot(carsdata, aes(x=HP, y=Retail.Price, shape=factor(Sports.Car)) )+ geom_point()+scale_shape_manual(values=c(5,24))


#play with alpha parameter
ggplot(carsdata, aes(x=HP, y=Retail.Price, color=Sports.Car)) + geom_point(point=0,alpha=0.7)



######################

#choropleths

#need the following packages:
1) plyr
2) rgeos
3) maptools

library(plyr)
library(rgeos)
library(maptools)
library(sp)
library(rgdal)

nepal<-read.csv("nepal.csv",header=TRUE,na.strings=c("","*","NA"))

str(nepal)

#donwload shapefile
#go to GADM.org, select the country you are interested in, and donwload the shp file (you will donwload a zip file 
#that contains the shp file you're interested in)

np_dist <- readShapeSpatial("NPL_adm/NPL_adm3.shp")

plot(np_dist)

#This function turns a map into a data frame than can more easily be plotted with ggplot2.
np_dist <- fortify(np_dist)

np_dist$id <- toupper(np_dist$id)  #change ids to uppercase
ggplot() + geom_map(data = nepal, aes(map_id = District, fill = PASS.PERCENT),map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat)


# since each row contains data about 1 school, we want to take the average of schools in the same district.
#use ddply to do averaging

# Take the mean of PASS.PERCENT by District
# Note the use of the '.' function to allow District to be used without quoting
distrpassave <- ddply(nepal, .(District), summarize, PassMean = mean(PASS.PERCENT))
distrpassave <- ddply(nepal, ~District, summarize, PassMean = mean(PASS.PERCENT))

# Same plot, but use the right dataset and fill parameter
ggplot() + geom_map(data = distrpassave, aes(map_id = District, fill = PassMean), 
                    map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat) +
  scale_fill_gradient2(low="red", mid = "white", midpoint = 50, high = "blue",limits=c(0,100))


distlabels <- ddply(np_dist, .(id), summarize, long = mean(long), lat = mean(lat))

ggplot() + geom_map(data = distrpassave, aes(map_id = District, fill = PassMean),
                    map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat)  + 
  scale_fill_gradient2(low="red",mid="white",high="blue",midpoint=50) +
 ggtitle("Nepal School Districts by Average Pass Percentages") + 
  geom_text(data = distlabels,aes(long,lat,label=id),size=2)



  
