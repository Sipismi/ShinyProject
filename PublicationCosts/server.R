#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
# Define server logic required to draw a histogram

costs <- read.csv("Publisher_Costs_FI_Full_Data.csv")
costs <- filter(costs, Publisher.Supplier == "Elsevier") %>% filter(Organization.type == "University")
korjattava <- as.vector(costs[, 1])
korjattava[29:35] <- "University of Jyvaskyla"
korjattava[84:90] <- "Abo Akademi University"
costs$Organisation <- korjattava
unis <- as.vector(unique(costs$Organisation))


shinyServer(function(input, output) {
  output$uniSelection <- renderUI(selectInput("uni", "Choose University", as.list(unis)) )
  output$barPlot <- renderPlot({
    
    # select correct university 
    x    <- input$uni
    selection <- filter(costs, Organisation == x)
    # draw the bar plot for the university in question
    #Calculate predicted value
    model.i <- lm(Cost~Year, selection)
    y <- predict(model.i, data.frame(Year = input$year))
    #add prediction to values
    yearlyCosts <- c(selection$Cost, y)
    #create vector to color the predicted bar differently 
    colours <- c(rep("gray", length(selection$Cost)), "red")
    
    barplot(yearlyCosts, names.arg = c(selection$Year,input$year) , col = colours, xlab = "Year", ylab="Subscription Cost (EUR)")
    
  })
  
  output$prediction <- renderText({
      x    <- input$uni
      selection <- filter(costs,  Organisation == x)
      model.i <- lm(Cost~Year, selection)
      y <- predict(model.i, data.frame(Year = input$year))
      z <- y/selection$Cost[1]
      paste(x, "will pay", signif(y, digits = 4), "EUR at",input$year, ".", "This is", round(z, digits=2), "times the 2010 level"  )
    
  })
  
})
