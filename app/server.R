#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(broom)
library(dplyr)
data("mtcars")
mtcars <- as.data.frame(mtcars)
#mtcars$cyl <- as.factor(mtcars$cyl)
#mtcars$vs <- as.factor(mtcars$vs)
#mtcars$am <- as.factor(mtcars$am)
#mtcars$gear <- as.factor(mtcars$gear)
#mtcars$carb <- as.factor(mtcars$carb)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    specify_decimal <- function(x, k) format(round(x, k), nsmall=k)
    
    output$distPlot <- renderPlotly({
        mtcars1 <- mtcars[0:input$examples,];
        feature <- input$radiobutton
        # draw the histogram with the specified number of bins
        fit <- lm(mtcars1$mpg~mtcars1[[feature]])
        ## plot(mtcars$mpg~mtcars$wt)
        
        output$event <- renderPrint({
            paste0(
                paste0("P-Value ", specify_decimal(glance(fit)$p.value, 6)),
                paste0(" | adj R-squared ", specify_decimal(glance(fit)$adj.r.squared, 6))
            )
        })
        
        plot_ly(mtcars1, x = mtcars1[[feature]], y = mtcars1$mpg,type = "scatter" ,mode = "markers" ) %>% 
            add_trace(data = mtcars1, x = mtcars1[[feature]], y = fitted(fit), mode = "lines") %>%
            layout(yaxis = list(title = "mpg"), xaxis = list(title = feature))
    })
    
    randomVals <- eventReactive(input$action1, {
        mtcars2 <- mtcars
        mtcars2$cyl <- as.factor(mtcars2$cyl)
        mtcars2$vs <- as.factor(mtcars2$vs)
        mtcars2$am <- as.factor(mtcars2$am)
        mtcars2$gear <- as.factor(mtcars2$gear)
        mtcars2$carb <- as.factor(mtcars2$carb)
        df1 <- data.frame(mtcars2[,input$checkItems])
        df1$mpg <- mtcars2$mpg
        model <- glm(mpg~.,data = df1)
        print(model)
    })
    
    output$event1 <- renderPrint({
        randomVals()
    })
    
    
})
