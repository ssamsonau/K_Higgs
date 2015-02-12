AMS_metrics <- function(data, lev = NULL, model = NULL){
    
    source("AMS.R")
    
    out <- AMS(data[, "pred"], data[, "obs"], data[,"weights"])
    
    names(out) <- c("AMS_metr")
    
    out

    
}    