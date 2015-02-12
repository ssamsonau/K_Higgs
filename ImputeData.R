
#######Load the data
DF <- read.csv("training.csv")

# assing appropriate NA and remove EventId
ValueForNA = -999.0;
DF[ DF == ValueForNA ] <- NA;
DF <- subset(DF, select = -c(EventId))

# Imputation function
ImputeData <- function(df, fileTowrite){
    require(caret)
    
    cat("Imputing loaded data..", "\n")
    tempLabel <- df$Label
    
    ImpMOD <- preProcess(subset(df, select = -Label), method="bagImpute") 
    df <- predict(ImpMOD, subset(df, select=-Label))
    
    df$Label <- tempLabel;
    
    cat("Done imputing", "\n")
    write.csv(df, file=fileTowrite, quote=FALSE, row.names=FALSE)
    return(df)
}
    
library(doMC)
registerDoMC(cores = 2)

system.time(ImputeData(DF[1:250, ], "./imputed_data.csv"))


##########################################
# ## Loop to check time needed for imputation by size
# timeOfImpute <- data.frame("NumberOrRows"=numeric(), "UserTime"=numeric())
# for (i in seq(100, 5e3, by=400)){
#     cat(i," rows", "\n")
#     st <- system.time(ImputeData(DF[1:i, ], "imputed_data.csv"))
#     print( st )
#     timeOfImpute <- rbind(timeOfImpute, c(i, st[1]) )
# }
#
#names(timeOfImpute) <- c("NumberOrRows", "UserTime")
#
#plot(timeOfImpute)

##########################################check 

#DFnew <- read.csv("imputed_data.csv")
#dim(DFnew)
#sum(complete.cases(DFnew))
#rm("DFnew")
