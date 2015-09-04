loadData <- function(counter) {
    print(paste("try loading data using option # ",counter))
    tryCatch({
        if (counter == 1)
            data <- values$data <- fread(input$file1$datapath, stringsAsFactors=F, data.table = F,verbose=F, header = T ) #fileEncoding="latin1"     
        else if (counter == 2)
            data <- values$data <- read.csv(input$file1$datapath, fileEncoding="latin1", stringsAsFactors=F, header = T) 
        else if (counter == 3)
            data <- values$data <- read.csv(input$file1$datapath, fileEncoding="latin1", stringsAsFactors=F, sep = "", header = F)
        else if (counter == 4)
            data <- values$data <- read.csv(input$file1$datapath, fileEncoding="latin1", stringsAsFactors=F, sep = "", header = T)                       
    }, error = function(e) {
        print(e)
        throw("Error in loading CSV!")
    })
    
    # getting the # of rows & columns to check if data was loaded correctly!
    ncols <- ncol(data)
    nrows <- nrow(data)
    print(paste(ncols,nrows))
    
    if (ncols <= 1 || nrows <= 1) {
        print("CSV read improperly!")
        throw("CSV read improperly!");
    }
    
    return(data)
}

updateDATA <- observe({
    if (!is.null(input$file1$datapath)) {
        
        isolate({
            data <- NULL
            ncols <- nrows <- 0
            counter <- 0
            bool <- TRUE
            while(bool) {
                tryCatch({
                    counter <- counter + 1
                    data <- loadData(counter)
                    bool <- FALSE
                }, 
                warning = function(e) {
                    print(paste("option",counter,"gave a warning!trying next approach..."))
                    if (counter > 5)
                        throw("Could not load CSV!");
                }, 
                error = function(e) {
                    print(paste("option",counter,"did not work!trying next approach..."))
                    if (counter > 5)
                        throw("Could not load CSV!");
                }, finally = print(paste("Loaded data successfully with",nrow(data),"rows"))) ##
            }
        })
    }
})

output$contents <- renderDataTable({
    values$data[1:20,]
}, options = list(
    pageLength = 10,
    lengthChange=FALSE,
    searching=TRUE,
    autoWidth=TRUE,
    paging=FALSE,
    scrollCollapse=TRUE,
    scrollX=TRUE,
    scrollY="370px",
    dom='rt<"pull-left"i><"pull-right"flp><"clear">',
    ordering=FALSE
))

output$rowsNCols <- renderUI({
    text <- ""
    data <- values$data
    isolate({
        if (!is.null(data)) {
            columns <- ncol(data)
            rows <- nrow(data) 
            summ <- paste("<b>Summary</b>")
            rowsTxt <- paste("# of rows:columns = ",rows,":",columns,sep="")
            colsTxt <- paste("<pre>",rowsTxt,"</pre>",sep="")
            text <- paste(summ,colsTxt,sep = "<br/>")
        }
        HTML(text)
    })
})

output$pie_featureTypes <- renderPlot({
    data <- values$data
    classes <- computeFeatureTypes(data)
    print(classes)
    slices <- classes$Freq
    lbls <- classes$classes
    cat(slices, lbls)
    if (length(lbls) > 0) {
        pie(slices, labels = lbls, main="Feature types in data")
    }
    
})