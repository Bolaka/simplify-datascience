library(shiny)

shinyUI(
    navbarPage("Ayata", 
               tabPanel("Load Data", source("loaddata_ui.R",local=T)$value),
               tabPanel("Metadata"),
               tabPanel("Univariate analysis"),
               tabPanel("Multivariate analysis"),
               tabPanel("Collinearities"),
               tabPanel("Missing values"),
               tabPanel("Outliers"),
               tabPanel("Transformations"),
#                tabPanel("Engineering"),
               tabPanel("Logs")
))