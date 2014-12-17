predictWord <- function(text, biend, triend, ltab, littletab, nwords){
    df <- data.frame(candidates = character(5), trigrams = numeric(5), bigrams = numeric(5),
                     unigrams = numeric(5), stringsAsFactors = FALSE)
    text <- tolower(text)
    words <- WordTokenizer(text)  ## keep this line    
    l <- length(words) ## keep this line
    
    gram3 <- paste0("^",words[(l-1)], " ",words[l]," ")
    tridf <- triend[triend$ngrams %like% gram3,]
    n3 <- length(tridf$freq)
    if (n3 > 0) {df <- dealWithTrigrams(tridf, df)}
    df <- dealWithBigrams(words[l], df, biend)
    df <- dealWithUnigrams(df, ltab, littletab)
    w <- which(df$trigrams == 0)
    if (length(w) > 0) {df$trigrams[w] <- (min(df$trigrams) -1)} 
    w <- which(df$bigrams == 0)
    if (length(w) > 0){ df$bigrams[w] <- (min(df$bigrams) -1)}
##    df$trigrams <- 8 + df$trigrams
##    df$bigrams <- 7.75 + df$bigrams
##    df$unigrams <- 6 + df$unigrams
##    rs <- rowSums(df[,2:4])  
##    ors <- order(rs, decreasing = TRUE)
    ### break ties
    u3 <- unique(df$trigrams)
    if (length(u3) < 5) {
        for (i in 1:length(u3)){
            w3 <- which(df$trigrams == u3[i])
            if (length(w3) > 1) {
                tiedrows <- df[w3,]
                u2 <- unique(tiedrows$bigrams)
                if (length(u2) < length(w3)) { ## break ties with unigrams:
                    for (j in 1:length(u2)){
                       w2 <- which(tiedrows$bigrams == u2[j])
                       ord1 <- order(tiedrows$unigrams[w2], decreasing = TRUE)
                       tiedrows[w2,] <- tiedrows[w2[ord1],]
                    }
                } else{
                   ords <- order(tiedrows$bigrams, decreasing = TRUE)
                   tiedrows <- tiedrows[ords,] 
                }
                df[w3,] <- tiedrows
            }
        }
    }

    ## make the statements:
    ##returns <- paste0("The most likely word to complete your senetence is '", 
    ##                  df$candidates[1], "'.")
    ##if (nwords > 1){
    ##    for (i in 2:nwords){
    ##        returns <- paste0(returns,"<br>The next most likely word to complete your sentence is '",
    ##                                     df$candidates[i], "'.")
    ##    }
    ##}
    
    ##return(returns)
    return(df$candidates)
}