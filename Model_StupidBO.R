options(java.parameters = "-Xmx2048m")
library(downloader)
library(knitr)
library(stringi)
library(stringr)
library(dplyr)
library(NLP)
library(tidytext)
library(RWeka)
library(ngram)
library(corpus)
library(wordcloud)
library(quanteda)
library(quanteda.textstats)
library(lexicon)
library(tidyr)
library(sbo)

data_url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
if (!file.exists("swiftkey.zip")){
        download(url = data_url, dest = "swiftkey.zip", mode="wb")
        unzip ("swiftkey.zip", exdir = "./")
}
filenames <- list.files(pattern = "en_US(.*?)txt$", recursive = TRUE)
file_names <-gsub(pattern = "final/en_US/en_US.|\\.txt", replacement = "", x = filenames)
files <- lapply(filenames,readLines)
names(files) <-file_names
rm(filenames)
rm(data_url)
rm(file_names)

start.time_c <- Sys.time()

set.seed(13254)
sampled <- sapply(files, function(x){sample(x,size=0.15*length(x), replace=FALSE)}) # Sampling
sampled <- sapply(sampled, function(x){iconv(x, "latin1", "ASCII", sub = "")}) # Remove non-ASCII characters
corp_unlist <- corpus(unlist(sampled))
rm(files)
rm(sampled)

tokens_c <- tokens(
        corp_unlist,
        what = "word", #tokenize by words
        remove_punct = T,
        remove_symbols = T,
        remove_numbers = T,
        remove_url = T,
        remove_separators = T,
)

tokens_c <- tokens_replace(tokens_c,"[^a-z'\\s]", " ")
tokens_c <- tokens_remove(tokens_c, c("the","a"))
tokens_c <- tokens_replace(tokens_c,"\\s+", " ")
tokens_c <- tokens_replace(tokens_c,"[`'’‘']", "'")
tokens_c <- tokens_replace(tokens_c,"[^a-z0-9\\'\\-_\\\\\\s]", " ")
tokens_c <- tokens_remove(tokens_c,pattern=lexicon::profanity_alvarez)
tokens_c <- tokens_tolower(tokens_c)
tokens_c <- tokens_remove(tokens_c, "\\p{Z}", valuetype = "regex")
tokens_s <- tokens_remove(tokens_c, c(stopwords("english")))
c <- corpus(sapply(tokens_c, paste, collapse=" ")) # clean corpus with stop words
cs <- corpus(sapply(tokens_s, paste, collapse=" ")) # clean corpus without stop words

end.time_c <- Sys.time()
time.taken_c <- end.time_c - start.time_c
time.taken_c # Time difference of 3.715386 mins

######################
#Predictors
######################

start.time_p4 <- Sys.time()
p4_c <- sbo_predtable(c,N=4,L=5,dict = target ~ 0.9, .preprocess=identity,lambda=0.4)
end.time_p4 <- Sys.time()
time.taken_p4 <- end.time_p4 - start.time_p4
time.taken_p4
save(p4_c,file="pred4c.rda") #Time difference of 32.05669 mins

start.time_p4s <- Sys.time()
p4_cs <- sbo_predtable(cs,N=4,L=5,dict = target ~ 0.9, .preprocess=identity,lambda=0.4)
end.time_p4s <- Sys.time()
time.taken_p4s <- end.time_p4s - start.time_p4s
time.taken_p4s
save(p4_cs,file="pred4cs.rda") #Time difference of 26.73929 mins

start.time_p5 <- Sys.time()
p5_c <- sbo_predtable(c,N=5,L=5,dict = target ~ 0.9, .preprocess=identity,lambda=0.4)
end.time_p5 <- Sys.time()
time.taken_p5 <- end.time_p5 - start.time_p5
time.taken_p5
save(p5_c,file="pred5c.rda") #Time difference of 


start.time_p7 <- Sys.time()
p7_c <- sbo_predtable(c,N=7,L=5,dict = target ~ 0.9, .preprocess=identity,lambda=0.4)
end.time_p7 <- Sys.time()
time.taken_p7 <- end.time_p7 - start.time_p7
time.taken_p7
save(p7_c,file="pred7c.rda")

start.time_p7cs <- Sys.time()
p7_cs <- sbo_predtable(cs,N=7,L=5,dict = target ~ 0.9, .preprocess=identity,lambda=0.4)
end.time_p7cs <- Sys.time()
time.taken_p7cs <- end.time_p7cs - start.time_p7cs
time.taken_p7cs
save(p7_cs,file="pred7cs.rda")

