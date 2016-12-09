#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

choices = c("weight" = "wt",
            "displacement" = "disp",
            "cylinder" = "cyl",
            "horsepower" = "hp",
            "drat" = "drat",
            "1/4 mile time (qsec)" = "qsec",
            "V/S" = "vs",
            "Transmission(0-auto | 1-manual)" = "am",
            "gear" = "gear",
            "carb" = "carb"
            )

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("mtcars Dataset analysis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("examples",
                   "Number of Examples",
                   min = 1,
                   max = 32,
                   value = 10),
       radioButtons("radiobutton", "Select Feature", choices, selected = "wt", inline = FALSE,
                    width = NULL),
       tags$form(
           checkboxGroupInput("checkItems", "Select Features for model building",
                              choices),
           actionButton("action1","Build Model")
       )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("distPlot"),
       verbatimTextOutput("event"),
       br(),
       h3("Model"),
       br(),
       verbatimTextOutput("event1")
    )
  )
  
))
