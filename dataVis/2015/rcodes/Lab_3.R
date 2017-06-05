#Lab 3
#the inputs for creating the data sample
rm(list=ls())
setwd("/Users/jieyang/Desktop/2015_Spring/Data visulization/Jie/Dataset")


mlbdata<-read.table("MLB.dat",header=TRUE)
attach(mlbdata)

#Interactive Plots

#inbuilt package: manipulate (in R Studio)

#manipulate package adds interactive capabilities to standard R plots, by binding plot inputs to custom controls rather than static hard-coded values.
#slider control
#picker control
#checkbox control

library(manipulate)

#slider & different options
manipulate(plot(years,lsalary,xlim=c(0,x.max)),x.max=slider(0,25))

#inital value
manipulate(plot(years,lsalary,xlim=c(0,x.max)),x.max=slider(0,25, initial = 10, step =2))

#can also arrange step, by step = ...

#custom label for slider
manipulate(plot(years,lsalary,xlim=c(0,x.max)),x.max=slider(0,25, label = "x-axis"))


detach(mlbdata)
carsdata<-read.csv("04cars data.csv",header=TRUE,na.strings=c("","*","NA"))
attach(carsdata)

#picker 

#selecting data with picker
manipulate(hist(carsdata[,factor], main = "histogram", xlab=factor),factor = picker("City.MPG","Hwy.MPG","Cyl"))

#picker with type of graphics
manipulate(plot(City.MPG,type = type), type = picker("points" = "p", "line" = "l", "step" = "s"))

#picker with groups
manipulate(plot(carsdata[group,"HP"],carsdata[group,"Retail.Price"]),group = picker("Group1"=1:50,"Group2"=51:102,"Group3"=102:150))

#checkbox 
#ann: a logical value indicating whether the default annotation (title and x and y axis labels) should appear on the plot.
manipulate(plot(HP,Retail.Price,axes=axes, ann=label),axes = checkbox(T, "Draw Axes"),label = checkbox(F, "Draw Labels"))

#
manipulate(boxplot(Retail.Price ~ Cyl, data = cars, outline = outline),outline = checkbox(FALSE, "Show outliers"))

#can use all these things with lattice graphs, for example


#Identify() and Locator()
#identify() clicking the mouse over points in a graph will display the row number or (optionally) the rowname for the point. This continues until you select stop.
#locator() you can add points or lines to the plot using the mouse. The function returns a list of the (x,y) coordinates. Again, this continues until you select stop.


plot(mtcars$mpg, mtcars$wt)
identify(mtcars$mpg,mtcars$wt,labels = row.names(mtcars),n = 3) # number of points 
coords <- locator(type="l") # press Esc to exit

#Iplots


#install iplots() -- must have R 3.1.0
#The iplots package provides interactive mosaic plots, bar plots, box plots, parallel plots, scatter plots and histograms that can be linked and color brushed. 
#Highlighting observations in one graph will automatically highlight the same observations in all other open graphs.


library(iplots)
library(JGR)
JGR()
setwd("/Users/jieyang/Desktop/2015_Spring/Data visulization/Jie/Dataset")
carsdata<-read.csv("04cars data.csv",header=TRUE,na.strings=c("","*","NA"))
attach(carsdata)

#different plots:
# scatterplots
# barcharts
#histograms
# parallel plots


iplot(HP,Retail.Price,xlab="horse power",ylab="retail price")
l<-lowess(HP,Retail.Price)
ilines(l)

# histograms
ihist(HP)

#interactive selection:
#get indices
iset.selected()

#select cases from here:
iset.select(grep(("Toyota|Mazda|Audi"),Vehicle.Name))

#creating more complex selections
#press shift and select things data from the plots.


# bars
library(MASS)
ibar(Cyl)

#change the order of factors
#particular example doesn't make much sense to do this, but you get the idea
Cyl.f <- factor(Cyl)
levels(Cyl.f)

Cyl.f2 <- ordered(Cyl.f,c("-1","4","3","5","6","10","8","12"))
ibar(Cyl.f2)


# parallel plots
ipcp(Retail.Price,HP,Cyl,Hwy.MPG,City.MPG,Engine.Size..l.)


# mosaic plots: useful examining relationships among two/more categorical variables
# The surfaces of the rectangular fields that are available for a combination of features are proportional to the number of observations that have this combination of features

detach(carsdata)
attach(mtcars)
imosaic(data.frame(gear,cyl))
#otherwise, first convert to factors


#Google Vis 
#Hans Rosling 2006
#interface between R and Google Chart Tools
#data visualization for websites
library(googleVis)

demo(WorldBank)

#simple examples:
#1)
hist <- gvisHistogram(data.frame(carsdata$HP))
plot(hist)
#2)
table <-T <- gvisTable(carsdata,
                       options=list(width=1000, height=500))
plot(table)


#interactive features

#Motion-charts, geo-charts
#Fruits data set
M <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(M)

#Exports data set
G <- gvisGeoChart(Exports, "Country","Profit",options=list(width=1000,height=500))
plot(G)

#combining charts with gvisMerge
G <- gvisGeoChart(Exports, "Country","Profit",options=list(width=200,height=100))
T <- gvisTable(Exports,
               options=list(width=200, height=270))
M <- gvisMotionChart(Fruits, "Fruit", "Year",
                      options=list(width=400, height=370))
GT <- gvisMerge(G,T, horizontal=FALSE)
GTM <- gvisMerge(GT, M, horizontal=TRUE,
                    )
plot(GTM)
