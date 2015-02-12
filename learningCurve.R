learningCurve <- function(train, valid, 
                          #trGrid, 
                          fitControl, preProcessing,
                          met, numberofSteps){

    if(sum(complete.cases(train)) != dim(train)[1] ) print("train has NAs")
    if(sum(complete.cases(valid)) != dim(valid)[1] ) print("valid has NAs")
    
    #Number of training examples
    m = dim(train)[1]; 
    
    minSize <- 2*dim(train)[2];
        
    accuracyDF <- data.frame(matrix(0, nrow=0, ncol=3))
    names(accuracyDF) = c("trainAcc", "valAcc", "sampleSize")
        
    library("caret")
    
                   
    for (i in seq(minSize, m, by=round( (m-minSize)/numberofSteps) ) ) {
        
        cat("sample Size: ", i)
        
        k <- dim(accuracyDF)[1]+1
        accuracyDF[k, "sampleSize"] <- i;
                
        curSubset <- sample(m, i)
        model <- train(Label ~ ., data=train[curSubset, ], method="rf", 
                       #tuneGrid = trGrid, 
                       trControl = fitControl,
                        preProc = preProcessing, 
                        metric = met)
        print(model)
        cat("Time of calculation: ", proc.time())
        
        trainPR <- predict(model, newdata=train[curSubset, ] )
        trainCM <- confusionMatrix(trainPR, train[curSubset, "Label"], 
                                   positive ="s")
        accuracyDF[k, "trainAcc"] <- trainCM$overall[met] 
        cat("Train metrics: ", accuracyDF[k, "trainAcc"], "\n" )
            
        validPR <- predict(model, newdata=valid)
        validCM <- confusionMatrix(validPR, valid[, "Label"],
                                   positive ="s")
        accuracyDF[k, "valAcc"] <- validCM$overall[met] 
        cat("Validation metrics: ", accuracyDF[k, "valAcc"], "\n" )
    }
    
    return(accuracyDF)
    
}



