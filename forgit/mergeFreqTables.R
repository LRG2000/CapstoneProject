## merge frequency tables that may or may not have all the same columns
## - returns a table with the combined frequecies and [potentially] added elements" 
## and the frequencies as "frequencies
##
## NAs from merge are set to zero
##  t1 and t2 are 2 frequency tables

mergeFreqTables <- function(t1, t2) {
    df1 <- data.frame(colnames = names(t1), frequencies = as.vector(t1))
    df2 <- data.frame(colnames = names(t2), frequencies = as.vector(t2))
    temp <- merge(df1, df2, by="colnames", all=TRUE)
    
    ## now deal with NA's
    temp[is.na(temp)] <- 0
    realfreq <- temp$frequencies.x + temp$frequencies.y
    
    single.df <- data.frame(colnames = temp$colnames, frequencies = realfreq)
    fullTable <- xtabs(frequencies ~ colnames, data=single.df)
    return(fullTable)
        
}