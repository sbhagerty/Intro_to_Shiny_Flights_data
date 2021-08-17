#####
#Global 
library(shiny)
library(tidyverse)
library(nycflights13)
library(shinythemes)
###



ui <- fluidPage(theme= shinytheme("united"),
                titlePanel('Monthly Departure Delay Time'),
                sidebarLayout(
                    sidebarPanel(
                        selectInput("carrier", "Carrier", choices = unique(flights$carrier)),
                        selectInput("origin", "Origin", choices = unique(flights$origin))
                        
                    ),
                    mainPanel(plotOutput("plot")))
                
)

server <- function(input, output){
    
    output$plot<-renderPlot({
        flights %>% 
            filter(carrier == input$carrier, origin == input$origin) %>% 
            ggplot()+ geom_smooth(aes(x=month, y= dep_delay))+
            xlab('Month')+
            ylab('Departure Delay (minutes)')+
            theme_classic()
        
    })
}

shinyApp(ui = ui, server = server)