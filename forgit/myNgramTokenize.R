## WordTokenizer can't handle the whole file, so break it into chunks
##Maxent_POS_Tag_Annotator(language = "en", probs = FALSE, model = NULL)
myNgramTokenize <- function(thisDoc, gramsize){
    thisDoc <- tolower(thisDoc)
    nlines <- length(thisDoc)
    chunksize <- 100000
    nchunks <- floor(nlines / chunksize)
    leftovers <- nlines %% chunksize

    ## do first chunk outside of loop

    ng <- NGramTokenizer(thisDoc[1:chunksize], Weka_control(min=gramsize, max=gramsize))
    
    gram.tab <- table(ng); remove(ng)
    
    for (k in 2:nchunks){
        print(paste0(k*.1, " million lines"))
        ind1 <- (k-1)*chunksize + 1
        ind2 <- k*chunksize
        
        ## now deal with n-grams and combining tables
        ng <- NGramTokenizer(thisDoc[ind1:ind2], Weka_control(min=gramsize, max=gramsize))
        tgrams <- table(ng); remove(ng)
        gram.tab <- mergeFreqTables(gram.tab, tgrams)
        
    }
    ## deal with leftovers:
    ng <- NGramTokenizer(thisDoc[(ind2+1):nlines], Weka_control(min=gramsize, max=gramsize))
    tgrams <- table(ng); remove(ng)
    gram.tab <- mergeFreqTables(gram.tab, tgrams)
    s <- order(gram.tab, decreasing=TRUE)
    gram.tab <- gram.tab[s]
    return(gram.tab)
}