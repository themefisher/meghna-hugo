#
# This is a Shiny web application. You can run the application by clicking
# the Run App button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggstatsplot)
library(plotly)
library(readr)
library(leaflet)
library(haven)
library(funModeling)
library(crosstalk)
library(data.table)

#########
listings <- read_csv("./data/clean/listing_en.csv")
listings <- listings %>%
    select(-c(host_name,listing_url, scrape_id, last_scraped, name, picture_url,host_id, host_url,  host_location, host_about,host_thumbnail_url, host_picture_url, host_listings_count, neighbourhood, bathrooms, host_verifications,calendar_updated,calendar_last_scraped, first_review,last_review,license, description_lang))
final_listings <- listings %>%
    mutate(price, price = parse_number(listings$price)) %>%  
    mutate(host_response_rate, host_response_rate = parse_number(host_response_rate, na = c("", "NA"), locale = default_locale(), trim_ws = TRUE)) %>%
    mutate(host_acceptance_rate, host_acceptance_rate = parse_number(host_acceptance_rate, na = c("", "NA"), locale = default_locale(), trim_ws = TRUE))
######


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Observe variables"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput('variables',
                               'Select variables for observation',
                               choices = final_listings, 
                               selected = c('price','room_type','reivew_scores_rating','host_is_superhost'), 
                               width = 3),
            numericInput("Obs", "Number of observations to view", 10)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           verbatimTextOutput('summary'),
           
           tableOutput('view')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   # Return the requested dataset
    variableInput <- reactive({
        switch(input$variable)
    })
    
    
     output$summary <- renderPrint({
        dataset <- variableInput()
        summary(dataset)
    })
     
     output$view <- renderTable({
         head(variableInput(), n = input$obs)
     })
}

# Run the application 
shinyApp(ui = ui, server = server)
