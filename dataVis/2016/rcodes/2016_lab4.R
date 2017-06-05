# map basics
map()
map.axes()
map.scale(x=-150,-50,relwidth=0.2,axe=0.1)
map("world",c("USA","Mexico","Canada"),exact=T,col=c("red","blue","green"),
    fill=T)
map("world",c("USA","Mexico","Canada"),exact=F,col=c("red","blue","green"),fill=T)
map("world",c("USA","USA:Alaska","Mexico","Canada"),exact=T,col=c("red","red","blue","green"),fill=T)

# US arrest data: USArrests
USArrests$colorBuckets<-as.numeric(cut(USArrests$Assault,c(0, 50, 100, 150, 200, 250, 300,350)))
colors = c("#F1EEF6", "#D4B9DA", "#C994C7","#CD3278", "#DF65B0", "#DD1C77", "#980043")
par(mar=c(1,1,1,1)) # resize the plotting area
map("state", col=colors[USArrests$colorBuckets], fill = TRUE)
title("Assault rate by state",cex=0.8)
legend("bottom", c("<50", "50-100", "100-150", "150-200", "200-250", "250-300", ">300"), fill = colors,
       horiz=TRUE,cex=0.3)

# adjust the chart
map("state", col=colors[USArrests$colorBuckets], fill = TRUE,ylim=c(20,52))
title("Assault rate by state",cex=0.8)
map.axes()
legend(x=-120,y=23, c("<50", "50-100", "100-150", "150-200", "200-250", "250-300", ">300"), fill = colors,
       horiz=TRUE, cex=0.2)


# exercise
sizes<-c(0.5,1,1.5,2,2.5,3,3.5)
points(USArrests$longitude,USArrests$latitude, pch = 21, col=adjustcolor("blue",0.5),bg=adjustcolor("blue",0.5),cex=sizes[USArrests$colorBuckets])

# ggmap

# example 1
setwd("/Users/jieyang/Documents/course/data_visualization/2016_spring/data")
chicago_crime<-read.csv(file="chicago_crime.csv",header=T)
stalking<-subset(chicago_crime,PRIMARY.DESCRIPTION=="STALKING")
qmplot(LONGITUDE,LATITUDE,data=stalking,color="red",size=2,source="google",maptype="terrain")

# example 2

crimeData<-subset(chicago_crime,(PRIMARY.DESCRIPTION=="STALKING"|
                                   PRIMARY.DESCRIPTION=="ARSON"|PRIMARY.DESCRIPTION=="WEAPONS VIOLATION"|PRIMARY.DESCRIPTION=="CRIMINAL DAMAGE"))
crimeData$PRIMARY.DESCRIPTION<-factor(crimeData$PRIMARY.DESCRIPTION,levels=c("STALKING","ARSON","WEAPONS VIOLATION","CRIMINAL DAMAGE"))
Chicago<-qmap("chicago", zoom = 14, color="bw",legend = "topleft")
Chicago+geom_point(aes(x=LONGITUDE,y=LATITUDE,colour=PRIMARY.DESCRIPTION,size=PRIMARY.DESCRIPTION),data=crimeData)

Chicago+stat_bin2d(aes(x=LONGITUDE,y=LATITUDE, color=PRIMARY.DESCRIPTION, fill=PRIMARY.DESCRIPTION),
           size = .5, bins = 30, alpha = 1/2,data =crimeData)

# example 3
Chicago<-qmap("chicago", zoom = 14, legend = "topleft",extent="device")
densities<-stat_density2d(aes(x =LONGITUDE, y =LATITUDE, fill =..level..),h=4,alpha=0.3, data =crimeData,geom = "polygon"
)
Chicago+densities


