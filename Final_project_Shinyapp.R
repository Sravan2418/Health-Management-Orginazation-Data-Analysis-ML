#ndy 20
#Sam 30 ....

#library(DT) # when selecting multiple columns need to install this package
library(shiny)
library(ggplot2)
library(tidyverse)

ui <- fluidPage(
  titlePanel (""),
  sidebarLayout(
    sidebarPanel( (""),
                  selectInput("Names","Name",choices = c(data$Names),
                              selectize = FALSE, multiple = TRUE, selected = "John"),
                  radioButtons("Button", "Do you want to display the chart", 
                               list("Yes","No"),"") ) ,
    mainPanel( 
      tabsetPanel(type="tab",
                  tabPanel("Histogram", plotOutput("myhist")),
                  tabPanel("Data", tableOutput("mydata"))
      ) ) ) )

server <- function(input, output) {
  test <- reactive ({
    if(input$Button == 'Yes'){
      output$myhist <- renderPlot({
        barplot(Data$Values[Data$Names %in% input$Names], xlab = "Count", names = input$Names) }
        else { output$mydata <- renderTable({
          subset(Data, Data$Names == input$Name)
        })  
        }  
        }  
  })})  
      }
shinyApp(ui = ui , server = server)