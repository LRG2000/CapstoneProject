cleanUp <- function(brokenName, dataType, onlyAlpha){
    fixedName <- paste0("data/",dataType,".fixed.noUTF.txt")
    temp <- system(paste0("wc -l ",brokenName), intern=TRUE)
    pieces <- strsplit(gsub("^\\s+","",temp), " ")
    nlines <- as.numeric(pieces[[1]][1])
    
    thisDoc <- readLines(brokenName, encoding = "UTF-8")
    thisDoc <- tolower(thisDoc)
    ##corp <- Corpus(VectorSource(thisDoc))
    ##remove(thisDoc)
    ##tmp <- tm_map(corp, onlyAlpha, mc.cores=1)
    ##remove(corp) ## to save memory
    ##lines <- NULL
    print(paste0("starting cleanUp for ", dataType))
    for (i in 1:nlines){
        if (floor(i/10000) != floor((i-1)/10000)) print(i)
        lines <- tmp[[i]]$content
        if (lines != "") write(lines, fixedName, append=TRUE)
       
    }
    ##write(lines,fixedName)
    remove(tmp)
}