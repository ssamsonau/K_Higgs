Data_to_predict <- read.csv("test.csv")

load("./calculation_on_AWS/Model_250K2bootAMSrf/modelFile")
library(caret)
#Data_to_predict <- normalize_manually(Data_to_predict)

############################# predictions on TEST
OutputDF <- data.frame(matrix(vector(), 0, 4))
names(OutputDF) =c("EventId", "RankOrder", "Class", "PredProb")

peace_size = 550000 / 10
for (k in seq(0, 9) ){
    
    select = seq(1+ peace_size *k, peace_size* (k+1) )
    Data_part <- Data_to_predict[select, ]

#    source("add_features.R")
#    Data_partExt <- add_features(subset(Data_part))
    
    Data_partExt <- Data_part

    Predictions <- predict(modFIT, newdata=Data_partExt)
    PredProb <- predict(modFIT, newdata=Data_partExt, type = "prob")$s
    
    tempDF <- data.frame(Data_part$EventId, rep(1, peace_size), 
                         Predictions, PredProb)
    names(tempDF) <- c("EventId", "RankOrder", "Class", "PredProb")
    
    OutputDF <- rbind( OutputDF, tempDF)
}

OutputDF$RankOrder <- rank(OutputDF$PredProb, ties.method="first")

write.table(OutputDF[, c("EventId","RankOrder","Class")], 
            file="submittionRF250Kmtry2.csv", sep = ",", row.names = FALSE, quote=FALSE)
