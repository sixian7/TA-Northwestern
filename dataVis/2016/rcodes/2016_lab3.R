# Lab session 3 topics

library(ggplot2)

# scatter plot

p1<-ggplot(data=iris,aes(x=Sepal.Length,y=Sepal.Width,color=Species))
p1+geom_point(aes(shape=Species),size=3)

# add smooth line
p1<-ggplot(data=iris,aes(x=Sepal.Length,y=Sepal.Width))
p1+geom_point(aes(shape=Species,color=Species),size=3)+geom_smooth()

# add by species
p1+geom_point(aes(shape=Species,color=Species),size=3)+geom_smooth(aes(color=Species))

# linear regression
p1+geom_point(aes(shape=Species,color=Species),size=3)+geom_smooth(aes(color=Species),method="lm")

# legend position
p2<-p1+geom_point(aes(shape=Species,color=Species),size=3)+geom_smooth(aes(color=Species),method="lm")

p2+theme(legend.position="bottom")

# legend background
p2+theme(legend.background=element_rect(color="purple",fill="yellow"))

# legend key
p2+theme(legend.key=element_rect(color="purple",fill="yellow"))

# line chart
p1<-ggplot(data=beaver1,aes(x=time, y=temp))
p2<-geom_line(colour ="steelblue",size=1, linetype=2)
p1+p2+geom_ribbon(aes(ymin=temp-0.05,ymax=temp+0.05),fill="green",alpha=0.3)

# bar plots
ggplot(diamonds,aes(clarity,depth))+geom_bar(width=.5,stat="identity")
ggplot(diamonds,aes(clarity))+geom_bar(width=.5) 
  
# another bar plot solution
ggplot(diamonds,aes(clarity,depth))+stat_summary(fun.y="sum",geom="bar")

# stacked bar plot
ggplot(diamonds, aes(clarity,fill=cut))+geom_bar()

# grouped bar plot
ggplot(diamonds, aes(clarity,fill=cut)) + geom_bar(position="dodge")

# histogram

p1<-ggplot(faithful, aes(waiting))
p1+geom_histogram(binwidth=8,fill="steelblue", colour="black")

# density plot

p1<-ggplot(faithful, aes(waiting))
p1+geom_density(fill="blue",alpha=0.1)

# pie chart

df<-data.frame(variable=c("cat","mouse","dog","bird","fly"), value=c(1,3,3,4,2))
p1<-ggplot(df,aes(x = "", y = value,fill = variable)) 
p2<-geom_bar(width = 1,stat="identity") 
p1+p2+coord_polar("y",start=pi / 3)

# multiplot

q1<-ggplot(df,aes(x="",y=value,fill=variable))+geom_bar(stat="identity")+coord_polar("y")
q2<ggplot(diamonds,aes(clarity,fill=cut))+geom_bar()
q3<ggplot(diamonds,aes(clarity,fill=cut))+geom_bar(position="dodge")
multiplot(q1,q2,q3,cols=2)

# facet.grid

ggplot(diamonds,aes(clarity,fill=cut))+geom_bar()+facet_grid(~cut)

# facet.wrap
ggplot(diamonds, aes(clarity,fill=cut))+geom_bar()+facet_wrap(~cut, ncol=2)



