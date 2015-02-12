AMS <- function(PredLabel, ActualLabel, ActualWeight){
    
    TruePos <- ( PredLabel == ActualLabel ) & ( PredLabel == "s" )
    FalsePos <- ( PredLabel != ActualLabel ) & ( PredLabel == "s" )

    s = sum( ActualWeight[TruePos] )
    b = sum( ActualWeight[FalsePos] )

    br <- 10

    AMS <- sqrt(2*( (s+b+br)*log( 1+s/(b+br ) ) - s ))
    
}