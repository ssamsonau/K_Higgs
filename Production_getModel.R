require(caret)
set.seed(123)
library(doMC);  registerDoMC(cores = 8)
###################  Load Data
#DF <- read.csv("imputedData_full.csv")
DF <- read.csv("training.csv")
DF <- omit.na(DF)
DF <- DF[1:100, ]

################### Model Control
source("AMS_metrics.R")
fitControl <- trainControl(
                            method = "boot", number =2,
                            #method="cv", number = 8,
                           summaryFunction = AMS_metrics, ## Evaluate performance using the following function
                           classProbs = TRUE)             ## Estimate class probabilities
#tGrid <- expand.grid( mtry= c(2))
#tGrid <- expand.grid( size= c(3), decay=c(0.1))

wtt <- DF$Weight
################### Build model
modFIT <- train(Label ~ ., data=DF, 
                #method="rf", 
                #method="nnet"
                method = "svmLinear",
                trControl = fitControl,
 #               tuneGrid = tGrid,
                weights = wtt
                ,metric ="AMS_metr"
                )
print(modFIT)
##########################  Save Model
save(file="modelFile",modFIT);
sink("modelFIT.txt");  modFIT;  sink()