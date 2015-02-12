set.seed(123)
NumberOfSamples <- 10000
source("LoadData.R"); LoadData(NumberOfSamples);

require(caret)

############################### without or with polynom features
TRext <- subset(TR, select=-c(Weight))
VALext <- VAL

#source("add_features.R")
#TRext <- add_features(subset(TR, select=-c(Label, Weight)), maxExp=8 )
#TRext$Label <- TR$Label
#VALext <- add_features(subset(VAL, select=-c(Label)), maxExp=8)
#VALext$Label <- VAL$Label

###################################train

#trGrid <- expand.grid(C = c(0.1, 1, 10))
fitControl <- trainControl(method="cv", number = 5, 
                           #summaryFunction = twoClassSummary,
                           classProbs = TRUE)

numberofSteps <- 10
source("learningCurve.R")
accuracyDFext <- learningCurve(TRext[complete.cases(TRext), ],
                            VALext[complete.cases(VALext), ],
                            #trGrid, 
                            fitControl,
                            preProcessing = c("center", "scale"),
                            met ="Accuracy", numberofSteps )

source("drawLearningCurve.R")
gExt <- drawLearningCurve(accuracyDFext)

png(filename="./learningCurve.png")
plot(gExt)
dev.off()

