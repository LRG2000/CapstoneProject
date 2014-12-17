## global.R for Capstone app

library(shiny); library(quantmod); library(shinyIncubator); library(RWeka)
library(stringi); library(openNLP); library(tm); library(NLP); library(data.table)

source("predictWord.R")
source("dealWithNgrams.R")

sumn1 <- 167073
sumn2 <- 1956737
sumn3 <- 1863608

sumt1 <- 3506378
sumt2 <- 3344602
sumt3 <- 3087883

biendnews <- read.table("data/news.cleaned.last.2grams.short.fixed.tab")
##biendnews <- biendnews[which(biendnews$freq > 1),]
triendnews <- read.table("data/news.cleaned.last.3grams.short.fixed.tab")
ltabnews <- read.table("data/news.cleaned.last.words.short.tab")
littlenews <-data.frame(words = c("said/says", "year(s)", "it", "in", "to", "season"),
                  freq = c(99740, 22319, 16185, 13550, 7756, 7523))


littletwit <- data.frame(words = c("it", "you", "me", "lol", "today", "day"),
                       freq = c(65287, 59638, 43340,39057,33247, 28719))

biendtwit <- read.table("data/twitter.cleaned.last.2grams.short.fixed.tab")
triendtwit <- read.table("data/twitter.cleaned.last.3grams.short.fixed.tab")
ltabtwit <- read.table("data/twitter.cleaned.last.words.short.tab")

littlenews$freq <- log10(littlenews$freq/sumn1)
ltabnews$freq <- log10(ltabnews$freq/sumn1)
biendnews$freq <- log10(biendnews$freq/sumn2)
triendnews$freq <- log10(triendnews$freq/sumn3)

ltabtwit$freq <- log10(ltabtwit$freq/sumt1)
biendtwit$freq <- log10(biendtwit$freq/sumt2)
triendtwit$freq <- log10(triendtwit$freq/sumt3)
littletwit$freq <- log10(littletwit$freq/sumt1)








