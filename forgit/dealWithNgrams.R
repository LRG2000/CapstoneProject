dealWithTrigrams <- function(tridf, df) {
    len <- dim(tridf)[1]
    uselen <- ifelse(len > 5, 5, len)
    for (i in 1:uselen){
        toks <- WordTokenizer(tridf$ngrams[i])
        df$candidates[i] <- toks[3]
        df$trigrams[i] <- tridf$freq[i]
    }
    return(df)
}

##########################################################################

dealWithBigrams <- function(word, df, biend) {
    starthere <- which(df$trigrams != 0)
    n3 <- length(starthere)
    if (n3 > 0){
        for (i in 1:n3){
            ends <- paste0(word, " ", df$candidates[i])
            df$bigrams[i] <- biend$freq[which(biend$ngrams == ends)]
        }
        if (n3 < 5){## get bi-only words
            gram2 <- paste0("^", word)
            bidf <- biend[biend$ngrams %like% gram2,]
            d2 <- dim(bidf)[1]
            upperLim <- ifelse((d2 + n3) >= 5, 5, d2+n3)
            index <- n3 + 1
            counter <- 1
            while((index <= 5) && (counter <= d2)) {
                words <- WordTokenizer(bidf$ngrams[counter])
                if (length(which(df$candidates == words[2])) == 0) {
                    df$candidates[index] <- words[2]
                    df$bigrams[index] <- bidf$freq[counter]
                    index <- index + 1
                } ## if the word is not already a candidate
                counter <- counter + 1
            }        
        } } else{ ## if there were no candidates from trigrams
            bidf <- biend[biend$ngrams %like% gram2,]
            d2 <- dim(bidf)[1]
            if (d2 > 0){
                upperLim <- ifelse(d2 >= 5, 5, d2)
                for (i in 1:upperLim){
                    words <- WordTokenizer(bidf$ngrams[i])
                    df$candidates[i] <- words[2]
                    df$bigrams[i] <- bidf$freq[i]                    
                } ## endfor looping thru bigrams   
            } ## endif - were there bigrams?   
        } ## endelse if there were no trigrams  
    return(df)
}

##########################################################################################

dealWithUnigrams <- function(df, ltab, littletab){ 

    nc <- length(which(df$candidates != ""))
    if (nc > 0){ ## if there are any candidates
        for (i in 1:nc){
            thisone <- which(ltab$words == df$candidates[i])
            if (length(thisone) > 0) {df$unigrams[i] <- ltab$freq[thisone]}
        }
        if (nc < 5) { ## if there are fewer than 5 candidates, add unigrams but check for duplicates
            index <- nc + 1
            i <- 1
            while(index <= 5) {
                if (length(which(df$candidates == littletab$words[i])) == 0) { ## if word isn't already there
                    df$candidates[index] <- littletab$words[i]
                    df$unigrams[index] <- littletab$freq[i]
                    index <- index + 1
                } ## if the word is not already a candidate
                i <- i + 1
            }             
        } } else{ ## if there are no candidates
            df$candiates <- littletab$words[1:5]
            df$unigrams <- littletab$freq[1:5]
        }
    return(df)
}

    
    
    
    
