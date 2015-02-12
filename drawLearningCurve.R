drawLearningCurve <- function(Data){

    require(ggplot2)
    g <- ggplot(aes(x=sampleSize), data=Data) +
        geom_line(aes(y=trainAcc, col="trainAcc")) +
        geom_line(aes(y=valAcc, col="valAcc")) +
        ylab("Accuracy metrics")
    print(g)
    return(g)   
}


