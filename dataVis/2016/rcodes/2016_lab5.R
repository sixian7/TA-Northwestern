#Lab 5

# identify() and locator()
plot(mtcars$mpg,mtcars$wt,xlab="mpg",ylab="wt")
identify(mtcars$mpg,mtcars$wt,labels=row.names(mtcars),n=3)
locator(type="l",n=4)

# manipulate package
# add slider to control x-axis, y-axis
manipulate(plot(x=mtcars$mpg,y=mtcars$wt,xlim=c(0,max)),max=slider(20,30))
# add picker to select observation to show
manipulate(barplot(as.matrix(mtcars[,column_pick]),main=column_pick,beside=TRUE),
           column_pick=picker("mpg","wt"))
# add picker to select type of points to show
manipulate(plot(pressure,type =point_type),point_type=picker("points"="p","line"="l","step"="s"))
# add checkbox to show outlier in boxplot
manipulate(boxplot(Freq ~ Class, data = Titanic, outline = outline_check),
  outline_check = checkbox(FALSE, "Show outliers"))
# combine different controls
manipulate(
  plot(cars, xlim = c(0, x.max), 
       type = type, ann = label),
  x.max = slider(10, 25, step=5, initial = 25),
  type = picker("Points" = "p", 
                "Line" = "l", "Step" = "s"),
  label = checkbox(TRUE, "Draw Labels"))



#Iplots


#install iplots() -- must have R 3.1.0
#The iplots package provides interactive mosaic plots, bar plots, box plots, parallel plots, scatter plots and histograms that can be linked and color brushed. 
#Highlighting observations in one graph will automatically highlight the same observations in all other open graphs.


library(iplots)
library(JGR)
JGR()

attach(mtcars)
gears <- factor(gear)

ihist(mpg)
ibar(gears)
iplot(mpg, wt)
ibox(mtcars[c("mpg", "wt", "qsec", "disp", "hp")])
ipcp(mtcars[c("mpg", "wt", "qsec", "disp", "hp")])



#plotly
library(plotly)

#scatter plot
p0<-plot_ly(mtcars,x=mpg,y=wt,color=mpg,mode="markers")
plot_ly(mtcars,x=mpg,color=factor(cyl),type="box")

p1<-ggplot(mtcars,aes(x=mpg,y=wt))+geom_point(aes(color=mpg,size=wt,alpha=0.5))
p2<-ggplotly(p1)

#multiplot
p3<-plot_ly(mtcars,x=cyl,y=wt,color=mpg,mode="markers")
subplot(p0,p3,nrows=2)

#plotly package

library(plotly)
plot_ly(mtcars,x=mpg,y=wt,size=wt,color=mpg,mode="markers")

# convert ggplot2
p1<-ggplot(mtcars,aes(x=mpg,y=wt))+geom_point(aes(color=mpg))
p2<-ggplotly(p1)

# plotly:barplot
plot_ly(mtcars,x=levels(cyl),y=ddply(mtcars,c("cyl"),summarize,MPG=mean(mpg))$MPG,
        type="bar",color=levels(cyl))


#Google Vis 
#Hans Rosling 2006
#interface between R and Google Chart Tools
#data visualization for websites
library(googleVis)

demo(WorldBank)

#simple examples:
#1)
hist <- gvisHistogram(data.frame(mtcars$hp))
plot(hist)

#configure hist
hist <- gvisHistogram(data.frame(mtcars$hp),
                      options=list(title="Histogram for horse power",colors="['green']",
                                   dataOpacity=0.5,orientation="vertical"))
plot(hist)

#2)
table<-gvisTable(mtcars,options=list(width=1000, height=500))
plot(table)


#interactive features

#Motion-charts, geo-charts
#Fruits data set
M<-gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(M)

#Exports data set
G<-gvisGeoChart(Exports, "Country","Profit",options=list(width=1000,height=500))
plot(G)

#combining charts with gvisMerge
G<-gvisGeoChart(Exports, "Country","Profit",options=list(width=400,height=300))
M<-gvisMotionChart(Fruits, "Fruit", "Year",options=list(width=400, height=370))
GT<-gvisMerge(M,G,horizontal=TRUE)
plot(GT)
