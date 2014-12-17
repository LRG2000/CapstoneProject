writeBroken <- function(thisFile, sentence_token_annotator, dataType) {
    library(stringr)
    print(paste0("starting writeBroken for ", thisFile))
    
    dir <- "~/Desktop/DataScience/DataScienceSpecialization/Capstone/final/en_US/"
    fullFileName <- paste0(dir,thisFile)
    thisDoc <- readLines(fullFileName, encoding = "Latin-1")
    brokenName <- paste0("~/Desktop/DataScience/DataScienceSpecialization/Capstone/data/",
                      dataType,".broken.noUTF.thirdtry.txt")
    ## DO NOT LOWER THE CASE BEFORE SENDING TO SENTENCE TOKENIZER!
    ## w <- grep("[a-z]+ \\s [a-z]+ \\s [a-z]+", thisDoc)
    ##thisDoc <- stri_replace_all_regex(thisDoc,"[^(a-zA-Z)\\s,\\?!\\.]+","")
    thisDoc <- stri_replace_all(thisDoc,"[^(a-zA-Z)\\s,\\?!\\.]+","")
    thisDoc <- thisDoc[which(thisDoc != "")]    
    thisDoc <- gsub("\\s\\s+", ",", thisDoc)
    thisDoc <- thisDoc[which(nchar(thisDoc) > 2)]
    ##thisDoc <- stri_replace_all_regex(thisDoc,"[^\\p{L}\\s,\\?!\\.]+","")
    oldlines <- length(thisDoc)

    for (k in 1:oldlines){
        if (floor(k/10000) != floor((k-1)/10000)) print(k) 
        thisLine <- myBreakLines(thisDoc[k], sentence_token_annotator)
        if(thisLine$adding == FALSE) {realLines <- thisDoc[k]} else{
            realLines <- NULL
            for (i in 1:length(thisLine$bounds$start)){
                realLines <- c(realLines, 
                               substr(thisDoc[k], thisLine$bounds$start[i], thisLine$bounds$end[i]))
            }
        }
        write(realLines, file = brokenName, append=TRUE)
    }
        
    return(brokenName)
   
}