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
final_listings <- listings %>%
    select(-c(host_name, description, listing_url, scrape_id, last_scraped, name, picture_url,host_id, host_url,  host_location, host_about,host_thumbnail_url, host_picture_url, host_listings_count, neighbourhood, neighborhood_overview, bathrooms, host_verifications,calendar_updated,calendar_last_scraped, first_review,last_review,license, description_lang)) %>%
    mutate(price, price = as.numeric(gsub('\\$|',"", listings$price))) %>%  
    mutate(host_response_rate, host_response_rate = as.numeric(gsub('\\%|',"", listings$host_response_rate))) %>%
    mutate(host_acceptance_rate, host_acceptance_rate = as.numeric(gsub('\\%|',"", listings$host_acceptance_rate)))
######


# Define UI for application that draws a histogram
ui <- fluidPage(
        tabsetPanel(
            tabPanel("variables",
                     sidebarLayout(
                         sidebarPanel(
                             checkboxGroupInput('selected_v',
                                                'Select variables for observation', 
                                                choices = names(final_listings), 
                                                selected = names(final_listings$price), 
                                                width = 1)

        ),
                        mainPanel(
                           h4("Summary of variables selected"),
                           tabPanel("variables",DT::dataTableOutput('df')),
                           tabPanel(verbatimTextOutput('summary'))
                           ),
            tabPanel('Univariate analysis',
                     selectInput(inputId = 'x',
                                 label = 'Select x-variable',
                                 choices = names(final_listings)),
                     selectInput(inputId = 'y',
                                 label = 'Select y-variable',
                                 choices = names(final_listings))
                
            )
    )
)))

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$summary <- renderText({
        selectedData <- final_listings[, input$selected_v, drop = FALSE]
        summary(selectedData)
        })
    
    output$df <- DT::renderDataTable({
        DT::datatable(selectedData)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
