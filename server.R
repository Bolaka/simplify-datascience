library(shiny)

shinyServer(function(input, output) {
    values <- reactiveValues()
    source("loaddata_server.R", local=T)
})