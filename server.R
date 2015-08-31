library(shiny)

shinyServer(function(input, output) {
    source("loaddata_server.R", local=T)
})