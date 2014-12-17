cleanTheData <- function() {

    library(tm); library(NLP)
    library(RWeka); library(openNLP); library(stringi); 
    
    ## in shell: iconv --from-code UTF-8 --to-code US-ASCII -c en_US.news.txt > news.noUTF.txt

    origNames <- c("blog.noUTF.txt","news.noUTF.txt","twitter.noUTF.txt")
    dataType <- c("blog", "news", "twitter")
    
    sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = "en")
    
    ## clean each file
  ##  onlyAlpha <- content_transformer(function(x) stri_replace_all_regex(x,"[^\\p{L}\\s,\\?!\\.]+",""))
  ##  onlyAB <- content_transformer(function(x) stri_replace_all_regex(x,"[^(a-z)\\s,\\?!\\.]+",""))
    
    
        ## get onlyAlpha to reject non-as (?)
    for (i in 2:3) {
        thistype <- dataType[i]
        brokenName <- writeBroken(origNames[i], sentence_token_annotator, dataType[i])
        thisDoc <- readLines(brokenName, encoding="Latin-1")
        thisDoc <- tolower(thisDoc)
        thisDoc <- filterProfanity(thisDoc)
        cleanName <- paste0("data/",thistype,".clean.txt")
        write(thisDoc, file=cleanName)
      
    }

}
