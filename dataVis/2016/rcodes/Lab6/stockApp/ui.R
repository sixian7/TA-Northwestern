library(shiny)

shinyUI(
  
  pageWithSidebar(
  
  titlePanel("stockApp"),
  
  sidebarPanel(
      
      textInput("symb", "Symbol", "AAPL"),
      
      dateRangeInput("dates", 
                     "Date range",
                     start = "2015-05-05", 
                     end = "2016-05-05"),
      
      selectInput("metric", "Choose a metric:", choices=c("AAPL.Close","AAPL.Open"))
      
    ),
    
    mainPanel(plotOutput("plot"))
  )
)