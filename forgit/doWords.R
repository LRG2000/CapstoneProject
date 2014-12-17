
doWords <- function(thisDoc, dataType){
    print(paste0("getting words for ", dataType))
    nlines <- length(thisDoc)
    allfile <- paste0("data/",dataType,".cleaned.all.words.txt")
    lastfile <- paste0("data/",dataType,".cleaned.last.words.txt")
    
    
    for (i in 1:nlines){ 
        allwords <- WordTokenizer(thisDoc[i])
        lastwords <- allwords[length(allwords)]
        if (floor(i / 10000) != floor((i-1)/10000) ) print(i)
        write(allwords, file=allfile, append=TRUE)
        write(lastwords, file=lastfile, append=TRUE)
    }
 
    last <- readLines(lastfile)
    last <- last[which(last != "and")]
    last <- last[which(last != "a")]
    ##last <- last[which(last != "of")]
    last <- last[which(last != "or")]
    #last <- last[which(last != "")]
    lasttab <- table(last)
    lasttab <- lasttab[order(lasttab, decreasing = TRUE)]
    lasttabName <- paste0("data/",dataType,".cleaned.last.words.tab")
    write.table(lasttab, file = lasttabName)
    lasttab <- lasttab[which(lasttab > 1)]
    lasttabshortName <- paste0("data/",dataType,".cleaned.last.words.short.tab")
    ldf <- data.frame(words = names(lasttab), freq = as.vector(lasttab))
    write.table(ldf, file = lasttabshortName)
    
    
    
    
}