library(shiny)

nav_ui <-
    list(windowTitle = "Data Science", id = "nav_main", inverse = TRUE,
         collapsible = TRUE, tabPanel("Getting started", includeMarkdown('help.md')))

source("data_ui.R", encoding = "UTF-8", local = TRUE)
source("univariate_ui.R", encoding = "UTF-8", local = TRUE)
source("multivariate_ui.R", encoding = "UTF-8", local = TRUE)
source("collinearities_ui.R", encoding = "UTF-8", local = TRUE)
source("missing_ui.R", encoding = "UTF-8", local = TRUE)
source("outliers_ui.R", encoding = "UTF-8", local = TRUE)
source("transformations_ui.R", encoding = "UTF-8", local = TRUE)
source("logs_ui.R", encoding = "UTF-8", local = TRUE)

shinyUI(
    do.call(navbarPage, c("Data Science", nav_ui, data_ui, univariate_ui, multivariate_ui, collinearities_ui, missing_ui, outliers_ui,
                          transformations_ui, logs_ui
                          ))
)