suppressWarnings(library(shiny))
suppressWarnings(library(markdown))
suppressWarnings(library(shinyBS))
shinyUI(navbarPage("Data Science Capstone Project: Next Word Prediction",
                   tabPanel("Next Word Prediction",
                            sidebarLayout(

                                sidebarPanel(
                                    helpText("Enter the word or phrase to get a prediction of the next word"),
                                    textInput("inputString", "Write the phrase here",value = ""),
                                    br(),
                                    br(),
                                ),
                                mainPanel(
                                    h2("Next Word Prediction"),
                                    htmlOutput("prediction"),
     
                                )
                                
                            )
                   ),
                   
                   tabPanel(
                       
                       "About",
                       
                       h4("Data Science Capstone Project: Next Word Prediction"),
                       
                       h4("Author: Lina Grusliene - 16/06/2021"),
                       
                       br(),
                       
                       p("This Shiny app takes a phrase as an input and gives a prediction of the next word as an output."),
                       
                       p("The Stupid Backoff model using 4-grams is used to predict the next word."),
                       
                       p("Source code is available at",
                         a(href = "https://github.com/linagrus/Data-Science-Capstone",
                           "https://github.com/linagrus/Data-Science-Capstone")
                       )
                       
                   )
                   
)
)