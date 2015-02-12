# add_features <- function(df){
#     N <- names(df)
#     for (i in seq(1,length(N)) ) {
#         for (k in seq(i, length(N) ) ){
#             str <- paste0(N[i], "--", N[k])    
#             df[, str] <- df[, n] * df[, k]
#         }
#     }
#     return(df)
# }


add_features <- function(df, maxExp){
    N <- names(df)
    for(i in 2:maxExp){
        for(n in N) {
            str <- paste0(n, ".", i)
            df[, str] <- df[, n]^i
        }    
    }
    return(df)
}

