tokenizeTheData <- function(){
    
    sent_token_annotator <- Maxent_Sent_Token_Annotator()
    word_token_annotator <- Maxent_Word_Token_Annotator()
    pos_tag_annotator <- Maxent_POS_Tag_Annotator()
    
    dataType <- c("blog", "news", "twitter")
    
    for (i in 2:3) { ## change back to 1 when finshed with news and twitter
        cleanName <- paste0("data/",dataType[i],".clean.txt")
        print(paste0("reading ", dataType[i]))
        thisDoc <- readLines(cleanName, encoding="Latin-1")
    
        for (gramsize in 2:4) {
            print(paste0("starting ",dataType[i]," ",as.character(gramsize),"-grams"))
            tab <- myNgramTokenize(thisDoc,gramsize)
            gramName <- paste0("data/",dataType[i],".cleaned.",as.character(gramsize),"grams.tab")
            writeme <- data.frame(ngrams=names(tab), freq = as.vector(tab))
            remove(tab)
            write.table(writeme, file=gramName)
            remove(writeme)
        }
        doWords(thisDoc,dataType[i])
    }
}