load("./calculation_on_AWS/Model_250K2bootAMSrf/modelFile")
DF <- read.csv("training.csv")

ValueForNA = -999.0;
DF[ DF == ValueForNA ] <- NA;

cDF <- DF[complete.cases(DF), ]

library(caret)
confusionMatrix(predict(modFIT, newdata=cDF), cDF[, "Label"], positive ="s")


source("AMS.R")

cat("Ideal AMS on vAL: ",  
    AMS(cDF$Label, cDF$Label, cDF$Weight), "\n",
    "current AMS on validation: ",  
    AMS(predict(modFIT, newdata=cDF), cDF[, "Label"], cDF[, "Weight"]) )
