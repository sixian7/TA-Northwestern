# Assignment 1 #

x1<-seq(-4,4,0.01)
y1<-sin(x1)

x2<-seq(-2,2,0.01)
y2<-x2^2

x3<-seq(-3,3,0.01)
y3<-ifelse( x3>0 | x3==0, 1, 0)

cuts<-c(-1,0,1)
values<-c(2,3,4,5)
y4<-values[findInterval(x3,c(-Inf,cuts,Inf))]
plot(x3,y4,type="l")

library("ggplot2")
df1<-data.frame(x=x1,y=y1, lineColor="red",lineType="solid")
df2<-data.frame(x=x2,y=y2, lineColor="blue",lineType="dashed")
df3<-data.frame(x=x3,y=y3, lineColor="purple",lineType="dotted")

df<-rbind(df1,df2,df3)

ggplot(data=df, aes(x, y))+geom_line(aes(linetype=lineType, color=lineColor))

# Assignment 2 #

setwd("/Users/jieyang/Desktop/MSiA400lab/lab7")
redwine<-read.table(file="redwine.txt",header=T)

# Q1
mean(redwine$RS,na.rm=T)
mean(redwine$SD,na.rm=T)

# Q2
missing.SD<-is.na(redwine$SD)
SD.obs<-redwine$SD[!missing.SD]
FS.obs<-redwine$FS[!missing.SD]
reg.obs<-lm(SD.obs~FS.obs)
coefficients(reg.obs)

# Q3
FS.imp<-redwine$FS[missing.SD]

SD.imp<-predict(reg.obs,FS.imp)
SD.imp<-predict(reg.obs,data.frame(FS.imp))
SD.imp<-predict(reg.obs,data.frame(FS.obs=FS.imp))

redwine$SD[missing.SD]<-SD.imp
mean(redwine$SD)

# Q4
RS.avg<-mean(redwine$RS,na.rm=T)
missing.RS<-is.na(redwine$RS)
redwine$RS[missing.RS]<-RS.avg

mean(redwine$RS)

# Q5
winemodel<-lm(QA~., data=redwine)
coefficients(winemodel)

# Q6
summary(winemodel)

# Q7
library("DAAG")
validation<-CVlm(data=redwine,form.lm=winemodel,m=5,printit=FALSE)
attr(validation,'ms')

# Q8
PH.avg<-mean(redwine$PH)
PH.sd<-sd(redwine$PH)
PH.lb<-PH.avg-3*PH.sd
PH.ub<-PH.avg+3*PH.sd
redwine2<-subset(redwine, PH<PH.ub & PH>PH.lb)
dim(redwine2)
dim(redwine)

# Q9
winemodel2<-lm(QA~., redwine2)
summary(winemodel2)


for(i in 1:nrow(redwine)) {
  if(redwine$PH[i] < lower)  {
    rem <- c(rem, i)
    
  }
  if(redwine$PH > upper)
  {
    rem <- c(rem, i)
  }
  
}


