#####
#Global 
library(shiny)
library(tidyverse)
library(nycflights13)
library(DT)
library(bslib)
library(thematic)

thematic_shiny()

shannons_theme<- bs_theme(
  bg = "#FFFFFF", 
  fg = "#4D8DC9", 
  primary = "#447099", 
  secondary = "#A4C689",
  success = "#56cc9d",
  info = "#6cc3d5",
  warning = "#ffce67",
  danger = "#ff7851",
  base_font = font_google("Open Sans"),
  heading_font = font_google("Proza Libre"),
  code_font = font_google("Fira Code")
)

ui <- fluidPage(theme = shannons_theme,
    titlePanel('My Flight Data App'),
  
    sidebarLayout(
     
        sidebarPanel(
    selectInput("carrier", "Carrier", choices = unique(flights$carrier)),
    selectInput("origin", "Origin", choices = unique(flights$origin)) ),
    mainPanel(
    plotOutput("plot"), 
    DTOutput('table')))
    
)

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