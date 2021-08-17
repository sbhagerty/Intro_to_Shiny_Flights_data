#####
#Global 
library(shiny)
library(tidyverse)
library(nycflights13)
library(DT)


# Dataset is from CDC at https://gis.cdc.gov/Cancer/USCS/DataViz.html
######

ui <- fluidPage(
  selectInput("carrier", "Carrier", choices = unique(flights$carrier)),
  plotOutput("plot"),
  DTOutput('table'),
  
)

server <- function(input, output){
  data<- flights %>% 
    filter(carrier == input$carrier, origin == 'EWR')
  
  output$plot<-renderPlot({
    flights %>% 
      filter(carrier == input$carrier, origin == 'EWR') %>% 
      ggplot()+ geom_smooth(aes(x=month, y= dep_delay))+
      xlab('Month')+
      ylab('Departure Delay (minutes)')+
      theme_classic()
    
    output$table<- renderDT({
      flights %>% 
        filter(carrier == input$carrier, origin == 'EWR') %>% 
        count(month) %>% 
        datatable()
    
  })
  }
