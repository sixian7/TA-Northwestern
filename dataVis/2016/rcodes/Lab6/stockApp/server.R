library(ggplot2)

shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    
    setwd("/Users/jieyang/Documents/course/data_visualization/2016_spring/scripts/Lab6/stockApp")
    data<-read.csv(file="AAPL.csv",header=T)
    data$date<-as.Date(as.character(data$date))
    plotdata<-subset(data,(data$date<=as.Date(input$dates[2]) & data$date>=as.Date(input$dates[1])))
    
    ggplot(plotdata,aes_string(x="date",y=input$metric))+geom_line(col="blue")

  })
  
})