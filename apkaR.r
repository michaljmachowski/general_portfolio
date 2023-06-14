
# Load R packages
library(shiny)
library('shinythemes')
library('qtl2')
library(tidyverse)

#get input data
dataset_name <- read_csv("")

dataset_name <- dataset_name[, c(1,2,4)] %>% 
  group_by(., pc) %>% 
  slice_max(order_by = revenue, n = 10) %>% 
  mutate(rank = row_number())
  
dataset_name <- dataset_name[, c(4,2,1)]

# Define UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  # theme = "cerulean",  # <--- To use a theme, uncomment this
                  "Dataset info",
                  tabPanel("Page 1",
                           sidebarPanel(
                             tags$h3("Input:"),
                             selectInput("which_pc", "Profit Center:", choices = dataset_name$pc),
                             
                           ), # sidebarPanel
                           mainPanel(
                             h4("Title"),
                             tableOutput("table_output_name")
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Page 2", "This panel is intentionally left blank"),
                  tabPanel("Page 3", "This panel is intentionally left blank")
                  
                ) # navbarPage
) # fluidPage

# Define server function  
server <- function(input, output) {
  output$table_output_name <- renderTable({
    data_filter <- subset(dataset_name, dataset_name$pc == input$which_pc)
  })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)