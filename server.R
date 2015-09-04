library(shiny)

shinyServer(function(input, output) {
    values <- reactiveValues()
    source("functions.R", local = TRUE)
    source("data.R", local=T)
})