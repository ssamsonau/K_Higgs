DF1 <- read.csv("./calculation_on_AWS/Imputations_of_Data/imputed_data_1_50000.csv")
DF2 <- read.csv("./calculation_on_AWS/Imputations_of_Data/imputed_data_50001_100000.csv")
DF3 <- read.csv("./calculation_on_AWS/Imputations_of_Data/imputed_data_100001_150000.csv")
DF4 <- read.csv("./calculation_on_AWS/Imputations_of_Data/imputed_data_150001_200000.csv")
DF5 <- read.csv("./calculation_on_AWS/Imputations_of_Data/imputed_data_200001_250000.csv")


DF_full <- rbind(DF1, DF2)
DF_full <- rbind(DF_full, DF3)
DF_full <- rbind(DF_full, DF4)
DF_full <- rbind(DF_full, DF5)

sum(complete.cases(DF_full))

write.csv(DF_full, file="./imputedData_full.csv", quote=FALSE, row.names=FALSE)

