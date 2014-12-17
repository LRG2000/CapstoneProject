##################################################################
##
##     myBreakLines 
## return separate sentences in text that might be all one line
## 
## intended to be used only for Capstone project in Data Science Specialization
##
##################################################################################
require(tm); require(NLP); require(openNLP)


myBreakLines <- function(text, sentence_token_annotator){
  sent.bounds <- annotate(text, sentence_token_annotator)
  ifelse((length(sent.bounds$id) > 1), adding <- TRUE, adding <- FALSE)
  returnme <- list(bounds = sent.bounds, adding = adding)
  return(returnme)
}