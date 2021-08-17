#####
#Global 
library(shiny)
library(tidyverse)
library(nycflights13)
library(DT)




ui <- fluidPage(
  selectizeInput("carrier", "Carrier", choices = unique(flights$carrier), multiple=T),
  plotOutput("plot")
  
)

server <- function(input, output){

  output$plot<-renderPlot({
    flights %>% 
      filter(carrier %in% input$carrier, origin == 'EWR') %>% 
      ggplot()+ geom_smooth(aes(x=month, y= dep_delay))+
      xlab('Month')+
      ylab('Departure Delay (minutes)')+
      theme_classic()
    
    output$table <- renderDT({
      flights %>% 
        filter(carrier %in% input$carrier, origin == 'EWR') %>% 
        DT()
      
    })
    
  })

}

shinyApp(ui = ui, server = server)