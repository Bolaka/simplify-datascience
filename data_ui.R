data_ui <- tagList(
    navbarMenu("Data", 
               tabPanel("Load", 
                        fluidPage(
                            fluidRow(
                                column(3, fileInput('file1', 'Choose csv file', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
                                )
                            ),
                            fluidRow(
                                column(12, dataTableOutput('contents')
                                )
                            )
                        )
               ),
               tabPanel("Metadata",
                        fluidPage(
                            fluidRow(
                                column(12, h1("First level title")
                                )
                            )
                        )
                )
    )
)