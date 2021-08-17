#####
#Global 
library(shiny)
library(tidyverse)
library(nycflights13)
library(DT)




ui <- fluidPage(
            selectInput("carrier", "Carrier", choices = unique(flights$carrier)),
            selectInput("origin", "Origin", choices = unique(flights$origin)),
            plotOutput("plot"), 
            DTOutput('table'))


server <- function(input, output){
    
    data<- reactive({flights %>% 
            filter(carrier == input$carrier, origin == input$origin)})
    
    output$plot<-renderPlot({
        data() %>% 
            ggplot()+ geom_smooth(aes(x=month, y= dep_delay))+
            xlab('Month')+
            ylab('Departure Delay (minutes)')+
            theme_classic()
        
    })
    output$table<- renderDT({
        data() %>% 
            count(month) %>% 
            datatable()
    })
}

shinyApp(ui = ui, server = server)