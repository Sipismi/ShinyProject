#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Future Elsevier subcription costs for Finnish universities based on costings from 2010 to 2016"),
  
  # Sidebar with a slider input for predictin the costs  
  sidebarLayout(
    sidebarPanel(
        uiOutput("uniSelection"),
        sliderInput("year", "Select year to which predict cost", 2017, 2100, 2050, step=5),
        h5("Instructions"),
        "Select Finnish university from the drop down menu. Move the slider to show the Elsevier subscription costs on the selected year for the particular university. 
            The result of the extrapolation are shown as text and compared to 2010 level. Graphical presentation of the 2010-2016 costs is provided with the predicted cost.
            The presenation is provocative on purpose.", 
        "Data source: Academic publisher costs in Finland 2010-2016, Ministry of Education and Culture of Finland and its Open Science and Research Initiative 2014-2017 http://urn.fi/urn:nbn:fi:csc-kata20170613104454620616"
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h3(textOutput("prediction")),
        plotOutput("barPlot")
       
    )
  )
))
