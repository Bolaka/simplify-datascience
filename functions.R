computeFeatureTypes <- function(raw) {
    # null check
    if (is.null(raw))
        return(NULL)
    
    names <- names(raw)

    # the class
    classes <- mapply(function(x,name) {
        non_nas <- x[!is.na(x)]
        
        # check if date?
        if (!is.numeric(non_nas)) {
            good.rows<-ifelse(nchar(non_nas,c("chars"),T)>=8,FALSE,TRUE)
            
            if (length(which(!good.rows)) == 0) {
                as_date1 <-as.Date(non_nas,format="%m/%d/%Y")
                as_date2 <-as.Date(non_nas,format="%d/%m/%Y")
                as_date3 <-as.Date(non_nas,format="%Y-%m-%d")
                if (sum(!is.na(as_date1)) > 0 || sum(!is.na(as_date2)) > 0 || sum(!is.na(as_date3)) > 0)
                    return("Date")                                        
            }
        }
        
        if(is.numeric(non_nas)){
            # check for ordinal
            sorted <- sort(unique(non_nas))
            len <- length(sorted)
            if (is.integer(sorted) && len < length(non_nas)/2) { #
                xAxis <- c(1:len)
                fit <- lm(formula = sorted ~ xAxis)
                summaryFit <- summary.lm(fit)
                rsquared <- ifelse(is.na(summaryFit$adj.r.squared),summaryFit$r.squared,summaryFit$adj.r.squared)
                rsquared <- round(rsquared,1)
                if (rsquared == 1) {
#                     cat(name, 'CATEGORICAL\n')
                    return("CATEGORICAL")
                }
            }
#             cat(name, 'NUMERICAL\n')
            return("NUMERICAL")
        } else if(class(non_nas) %in% c("character", "factor")) {
            dis <- length(unique(non_nas))
            if (dis <= length(non_nas)/2) {
#                 cat(name, 'CATEGORICAL\n')
                return("CATEGORICAL")
            } else {
#                 cat(name, 'Others\n')
                return("Others")
            }
        }
        return(NA)
    }, raw, names)
    
    classes <- unlist(classes)
    
    # force class on columns
    for(name in names(classes)) {
        if (!is.na(classes[[name]]) && classes[[name]] == "CATEGORICAL") {
            raw[[name]] <- as.character(raw[[name]])
        }
    }
    classes <- as.data.frame(table(classes))
    return(classes)
}
