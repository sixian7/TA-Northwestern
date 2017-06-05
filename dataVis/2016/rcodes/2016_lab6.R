## Shiny Package ##

#Shiny is a new package from RStudio that makes it easy to build interactive web applications with R.
#Shiny applications have two components:
#1. User-interface definition, layout of the webpage.
#2. Server script, what will happen when you click a button, move the position of the slider, etc.


##install.packages("devtools")
##library(devtools)
install.packages("shiny")

##Every Shiny app has the same structure: two R scripts saved together in a directory. At a minimum, a Shiny app has ui.R and server.R files.
##You can create a Shiny app by making a new directory and saving a ui.R and server.R file inside it. Each app will need its own unique directory.

library(shiny) 

##examples
runExample("01_hello") # a histogram
runExample("02_text") # tables and data frames

##basic structure and extension
setwd("/Users/jieyang/Desktop/2015_Spring/Data visulization/Jie/Script/Lab5")
runApp("app1")
runApp("app2")

##insert pictures
runApp("app3")

##reactive
runApp("app4")

##h1,h2,h3...
runApp("app5")

