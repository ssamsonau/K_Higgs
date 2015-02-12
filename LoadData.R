LoadData <- function(NumberOfSamples){
    library(caret)
    ###################################load data
    ValueForNA = -999.0;
        
    if(! exists("DF") ){
        
        cat("Reading the data from file", "\n")
        DF <- read.csv("training.csv")
        cat("DF$Label table:")
        print(table(DF$Label))
        #c( range(TR[TR$Label=="s", "Weight"]), range(TR[TR$Label=="b", "Weight"]) )
        #max value for Weight for "s" is 0.019. Min for "b" is 0.064
        DF <- subset(DF, select = -c(EventId))

        DF[ DF == ValueForNA ] <- NA;
 
        # Subset the data to work with limited memory
        DF <- DF[sample( dim(DF)[1], NumberOfSamples), ]
        
        # Imputation is commented - without it accuracy is better.
        #cat("Imputing loaded data..", "\n")
        #tempLabel <- DF$Label
        #ImpMOD <- preProcess(subset(DF, select=-Label), method="knnImpute") 
        #DF <- predict(ImpMOD, subset(DF, select=-Label))
        #DF$Label <- tempLabel;
        #cat("Done imputing", "\n")
        
        DF <- DF[ complete.cases(DF), ]

        # it seams that PRI_jet_num is a factor. I do not know this for sure
        #I will just remove it for now..
        DF <- subset(DF, select=-PRI_jet_num)

        #manual normilization made simulation worse..
        #source("normalize_manually.R")
        #DF <- normalize_manually(DF)
    
    }
    
    ########################## separate data
    inTrain = createDataPartition(DF$Label, p = 0.6)[[1]]
    TR <<- DF[ inTrain, ] ;  
    inVal = createDataPartition(DF[-inTrain,]$Label, p = 0.5)[[1]]   
    VAL <<- (DF[ -inTrain,])[inVal, ]
    TST <<- (DF[ -inTrain,])[-inVal, ]
    
    
    #TR <<-subset(TR, select = -Weight); #we should not use Weight in training
    #VAL <<-subset(VAL, select = -Weight); #we should not use Weight in training

}
