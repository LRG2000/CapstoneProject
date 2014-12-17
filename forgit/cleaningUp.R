library(tm); library(RWeka); library(openNLP); ##library(stringi)

blogfile <- "~/Desktop/DataScience/DataScienceSpecialization/Capstone/final/en_US/en_US.blogs.txt"
newsfile <- "~/Desktop/DataScience/DataScienceSpecialization/Capstone/final/en_US/en_US.news.txt"
twitfile <- "~/Desktop/DataScience/DataScienceSpecialization/Capstone/final/en_US/en_US.twitter.txt"
news.fixed <- "~/Desktop/DataScience/DataScienceSpecialization/Capstone/final/en_US/new-fix.txt"

##bloglines <- readLines(blogfile, n = 10000, encoding = "UTF-8")
##newslines <- readLines(news.fixed, encoding = "UTF-8")
##twitlines <- readLines(twitfile, encoding = "UTF-8")

thisFile <- news.fixed ## change for news and twitter
thisDoc <- readLines(thisFile, encoding = "UTF-8")
oldlines <- length(thisDoc)
## oldlines values:
##  blog      news      twitter
##  899288    1010242*
## * in original file, but 8 are just "" and ___ more are not used because they are not 
## sentences.

sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = "en")
source("code/myBreakLines.R")

## make sure there's something in all the lines:
notEmpty <- which(thisDoc != "")
thisDoc <- thisDoc[notEmpty]
## do it in manageable chunks:

for (k in 1:101){
    realLines <- NULL
    kk <- (k-1)*10000
    for (j in 1:10000){
        ind <- kk + j
        thisLine <- myBreakLines(thisDoc[ind], sentence_token_annotator)
        if(thisLine$adding == FALSE) {realLines <- c(realLines, thisDoc[ind])} else{
            for (i in 1:length(thisLine$bounds$start)){
                realLines <- c(realLines, 
                         substr(thisDoc[ind], thisLine$bounds$start[i], thisLine$bounds$end[i]))
            }
        }
    }
    print(k)
   ## fileConn <- file("blogSentences_keepingContractionsAndCase.txt")
    write(realLines, file = "newsSentences_keepingContractionsAndCase.txt", append=TRUE)
    ##close(fileConn)
}
realLines <- readLines("data/blogSentences_keepingContractionsAndCase.txt", encoding = "UTF-8")
##,                     n = 100000)
## newlines <- length(realLines)

## keep this version for later analysis (after Capstone project)
fileConn <- file("blogSentences_keepingContractionsAndCase.txt")
writeLines(realLines, fileConn)
close(fileConn)
file <- "blogSentences_keepingContractionsAndCase.txt"
realLines <- readLines(paste0("data/", file), encoding="UTF-8")
realLines <- thisDoc
realLines <- tolower(realLines)
## change to possible misspellings as an intermediate step, then change to un-contracted version
realLines <- gsub("i'm", "i am", realLines)
#realLines <- gsub("can't", "cant", realLines)
realLines <- gsub("can't", "cannot", realLines)
realLines <- gsub("won't", "wont", realLines)
realLines <- gsub("wont", "will not", realLines)
realLines <- gsub("couldn't", "couldnt", realLines)
realLines <- gsub("couldnt", "could not", realLines)
realLines <- gsub("wouldn't", "wouldnt", realLines)
realLines <- gsub("wouldnt", "would not", realLines)
realLines <- gsub("isn't", "isnt", realLines)
realLines <- gsub("isnt", "is not", realLines)
realLines <- gsub("aren't", "arent", realLines)
realLines <- gsub("arent", "are not", realLines)
realLines <- gsub("you're", "youre", realLines)
realLines <- gsub("youre", "you are", realLines)
realLines <- gsub("i'll", "i will", realLines)
realLines <- gsub("i've", "i have", realLines)
realLines <- gsub("didn't", "didnt", realLines)
realLines <- gsub("didnt", "did not", realLines)
realLines <- gsub("don't", "dont", realLines)
realLines <- gsub("dont", "do not", realLines)
realLines <- gsub("he's", "he is", realLines)
realLines <- gsub("she's", "she is", realLines)
realLines <- gsub("they're", "they are", realLines)
realLines <- gsub("'", "", realLines)

write(realLines, file="data/blogSentences_removedContractionsAndApostrophes.txt")


fileConn <- file("blogSentences_removedContractionsAndApostrophes.txt")
write(realLines, file = "data/blogSentences_removedContractionsAndApostrophes.txt")
close(fileConn)
realLines <- readLines("data/blogSentences_removedContractionsAndApostrophes.txt",
                       encoding="UTF-8")

### playing with blog data
set.seed(1234)
inds <- as.logical(rbinom(2344838, 1, .2)) ## length of blog file
playset <- realLines[inds]
safeset <- playset
remove(realLines) ## otherwise takes to much memory
corp <- Corpus(VectorSource(playset))
onlyAlpha <- content_transformer(function(x) stri_replace_all_regex(x,"[^\\p{L}\\s,\\?!\\.]+",""))
test <- tm_map(corp, onlyAlpha, mc.cores=1)
length(playset)

extractFromTm_map <- function(x) {
    nlines <- length(names(x))
    lines <- NULL
    for (i in 1:nlines){
        lines <- c(lines, x[[i]]$content)
    }
    return(lines)    
}
newplayset <- extractFromTm_map(test)
allwords <- WordTokenizer(newplayset)
t.all <- table(allwords)
s.all <- order(t.all)



inds <- grep("^_+[a-z]", playset)
playset <- gsub("_","", playset)

inds <- grep("[^a-z]_+[^a-z]", playset)
playset <- playset[-inds]
inds <- grep("_+",playset)
playset <- playset[-inds]

inds <- grep("-",playset)
inds1 <- grep("--+[a-z+]* --+", playset)
playset <- gsub("-", " ", playset)

eos <- lastWords(cleaned)
write(eos,"data/lastwords_blog_subset_1234.txt")
allwords <- WordTokenizer(cleaned)
t.all <- table(allwords)
t.eos <- table(eos)
s.all <- order(t.all)
d.all <- order(t.all, decreasing=TRUE)
t.all[s.all[1:10]]
t.all[d.all[1:50]]
words <- names(t.all)
playset <- playset[inds]
cleaned <- gsub('[])(;:#%$^*\\~{}[&+=@/"`|<>_]+', " ", playset)
cleaned <- gsub("[¤º–»«Ã¢â¬Å¥¡Â¿°£·©Ë¦¼¹¸±€ð\u201E\u201F\u0097\u0083\u0082\u0080\u0081\u0090\u0095\u009f\u0098\u008d\u008b\u0089\u0087\u008a■①�…]+", " ", 
                cleaned)
cleaned <- gsub("[\002\020\023\177\003]", "", cleaned)
cleaned <- gsub("[\u009d]", " ", cleaned)
inds <- grep("[^(a-z!?)]", allwords)

mycorp <- Corpus(VectorSource(bloglines))

## things to remove:
## \u009d \177
## numerics
setwd("~/Desktop/DataScience/DataScienceSpecialization/Capstone")
thisDoc <- readLines("data/blog.fixed.txt", encoding="UTF-8")
allwords <- WordTokenizer(thisDoc[200001:300000])



