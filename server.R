suppressWarnings(library(quanteda))
suppressWarnings(library(readr))
suppressWarnings(library(dplyr))
suppressWarnings(library(tidyr))
suppressWarnings(library(sbo))
setwd("/Users/Lina/Desktop/R/Data-Science-Capstone")
# load the ngrams
if(!exists("pred_4gram") | !exists("pred_7gram") ){
    load("pred4c.rda")
    pred_4gram <- sbo_predictor(p4_c)
}
#clean the input
cleaninput <- function(x){
    y <- tokens(
        x,
        what = "word",
        remove_punct = T,
        remove_symbols = T,
        remove_numbers = T,
        remove_url = T,
        remove_separators = T,
    )
    y <- tokens_remove(y, c("the","a"))
    y <- tokens_remove(y,pattern=lexicon::profanity_alvarez)
    y <- tokens_tolower(y)
    
    y <- tokens_replace(y,"[^a-z'\\s]", " ")
    y <- tokens_remove(y, c("the","a"))
    y <- tokens_replace(y,"\\s+", " ")
    y <- tokens_replace(y,"[`'’‘']", "'")
    y <- tokens_replace(y,"[^a-z0-9\\'\\-_\\\\\\s]", " ")
    y <- tokens_remove(y,pattern=lexicon::profanity_alvarez)
    y <- tokens_tolower(y)
    y <- tokens_remove(y, "\\p{Z}", valuetype = "regex")
    y <- unlist(y, use.names = F)
    y <- paste(y, collapse=" ")
    return(y)
}

# Stupid Backoff 7-gram model
predictbo <- function(input){
    input <- cleaninput(input)
    p4 <- predict(pred_4gram,input)
    return(p4)
}

###Call function to UI 
shinyServer(function(input, output) {
    output$prediction <- renderText({
        next_word <- predictbo(input$inputString)
        l <- list(
            val1 = next_word[1],
            val2 = paste(next_word[2:5],collapse=", ")
        )
        paste("<b>Next word is:", l[[1]], "<br>", "</b>Alternative words could be:", l[[2]]) 
        

    })
    
    
}

)
