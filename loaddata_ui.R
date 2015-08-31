fluidPage(
    fluidRow(
        column(3,fileInput('file1', 'Choose csv file',accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')))
#         column(3, htmlOutput("rowsNCols")),
#         column(3, selectInput("id", "Select id column(single)",c(),NULL)), #, width = "220px"
#         column(3, selectInput(inputId = "metrics", label = "Select metrics(multiple)", choices = c("Data not loaded yet"), multiple = T, selectize = T))  # selectInput(inputId = "useless", label = "Select redundant variables(multiple):", choices = c("Data not loaded yet"), multiple = T, selectize = T)
    ),
    fluidRow(
        column(12,dataTableOutput('contents'))
    )
)