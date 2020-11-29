#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(RWeka)
library(data.table)
library(dplyr)
library(ggplot2)
library(plyr)
source("word_predictions.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
    ui <- fluidPage(
        
        #titlePanel("Word Prediction"),
        
        sidebarLayout(
            
            sidebarPanel(
                h4("Directions", style="color:blue"),
                p("1.Type a few words into the text box"),
                p("2. Based on your text entry, the algorithm will predict the next word"),
                p("3. You can add the predicted word to your text and submit again"),
                p("4. Repeat these steps and be creative")
            ),
            
            mainPanel(
                h3("Word Prediction Application"),
                h5("This application will suggest the next word in a sentence using an n-gram algorithm"),
                
                textInput("Tcir",label=h3("Enter your text here:")),
                submitButton('Submit'),
                h4('You entered : '),
                verbatimTextOutput("inputValue"),
                h4('Predicted words 1st option:'),
                verbatimTextOutput("prediction1"),
                h4('Predicted words 2nd option:'),
                verbatimTextOutput("prediction2"),
                h4('Predicted words 3rd option:'),
                verbatimTextOutput("prediction3"),
                h4('Predicted words 4th option:'),
                verbatimTextOutput("prediction4"),
                h4('Predicted words 5th option:'),
                verbatimTextOutput("prediction5")
                
            )
        ))
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$inputValue <- renderText({input$Tcir})
    output$prediction1 <- renderText({suggestions(input$Tcir)[1]})
    output$prediction2 <- renderText({suggestions(input$Tcir)[2]})
    output$prediction3 <- renderText({suggestions(input$Tcir)[3]})
    output$prediction4 <- renderText({suggestions(input$Tcir)[4]})
    output$prediction5 <- renderText({suggestions(input$Tcir)[5]})
}

# Run the application 
shinyApp(ui = ui, server = server)
