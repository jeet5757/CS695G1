# R scripts for CS695 term project. 
# Every group member should contribute to this scripts
# I will track and grade student contribution through Git

# 1 - Load data



# 2 - Word Cloud

#for Desales

#install the necessary packages
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("plyr")
install.packages("stringr")
install.packages("googleVis")
install.packages("stringi")
install.packages("magrittr")
install.packages("dplyr")


library(readr)
gearoo <- readRDS("DeSales.RDS")
tweets <- gearoo<-tweets

#********************************************
#         Word Cloud
#********************************************
#use this function to clean the tweets
clean.text = function(x)
{
  #tolower
  x = tolower(x)
  #remove rt
  x = gsub("rt", "", x)
  #remove at
  x = gsub("@\\w+", "", x)
  #remove punctuation
  x = gsub("[[:punct:]]", "", x)
  #remove numbers
  x = gsub("[[:digit:]]", "", x)
  #remove links http
  x = gsub("http\\w+", "", x)
  #remove tabs
  x = gsub("[ |\t]{2,}", "", x)
  #remove blank spaces at the beginning
  x = gsub("^ ", "", x)
  #remove blank spaces at the end
  x = gsub(" $", "", x)
  return(x)
}

#clean tweets
tweets = clean.text(tweets)


library("tm")
corpus = Corpus(VectorSource(tweets))

#create term-document matrix
tdm = TermDocumentMatrix(
  corpus,
  control = list(
    wordLengths=c(3,20),
    removePunctuation = TRUE,
    stopwords = c("the", "a", stopwords("english")),
    removeNumbers = TRUE, tolower = TRUE) )

#convert as matrix
tdm = as.matrix(tdm)

#get word counts in decreasing order
word_freqs = sort(rowSums(tdm), decreasing=TRUE) 

#check top 50 most mentioned words
head(word_freqs, 50)

#remove the top words which don’t generate insights such as "the", "a", "and", etc.
word_freqs = word_freqs[-(1)]  #Here “1” is 1st word in the list we want to remove 

#create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

#Plot corpus in a clored graph; need RColorBrewer package

library("RColorBrewer")
library("wordcloud")
wordcloud(head(dm$word, 50), head(dm$freq, 50), random.order=FALSE, colors=brewer.pal(8, "Dark2"))



# for Nuestra

#install the necessary packages
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("plyr")
install.packages("stringr")
install.packages("googleVis")
install.packages("stringi")
install.packages("magrittr")
install.packages("dplyr")


library(readr)
gear <- readRDS("Nuestra.RDS")
tweets <- gear$MESSAGE_BODY

#********************************************
#         Word Cloud
#********************************************
#use this function to clean the tweets
clean.text = function(x)
{
  #tolower
  x = tolower(x)
  #remove rt
  x = gsub("rt", "", x)
  #remove at
  x = gsub("@\\w+", "", x)
  #remove punctuation
  x = gsub("[[:punct:]]", "", x)
  #remove numbers
  x = gsub("[[:digit:]]", "", x)
  #remove links http
  x = gsub("http\\w+", "", x)
  #remove tabs
  x = gsub("[ |\t]{2,}", "", x)
  #remove blank spaces at the beginning
  x = gsub("^ ", "", x)
  #remove blank spaces at the end
  x = gsub(" $", "", x)
  return(x)
}

#clean tweets
tweets = clean.text(tweets)


library("tm")
corpus = Corpus(VectorSource(tweets))

#create term-document matrix
tdm = TermDocumentMatrix(
  corpus,
  control = list(
    wordLengths=c(3,20),
    removePunctuation = TRUE,
    stopwords = c("the", "a", stopwords("english")),
    removeNumbers = TRUE, tolower = TRUE) )

#convert as matrix
tdm = as.matrix(tdm)

#get word counts in decreasing order
word_freqs = sort(rowSums(tdm), decreasing=TRUE) 

#check top 50 most mentioned words
head(word_freqs, 50)

#remove the top words which don’t generate insights such as "the", "a", "and", etc.
word_freqs = word_freqs[-(1)]  #Here “1” is 1st word in the list we want to remove 

#create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

#Plot corpus in a clored graph; need RColorBrewer package

library("RColorBrewer")
library("wordcloud")
wordcloud(head(dm$word, 50), head(dm$freq, 50), random.order=FALSE, colors=brewer.pal(8, "Dark2"))





# 3 - Topic Classification
# DeSaels

#install the necessary packages
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("plyr")
install.packages("stringr")
install.packages("googleVis")
install.packages("stringi")
install.packages("magrittr")
install.packages("dplyr")


library(readr)
topicc  <- readRDS("DeSales.RDS")
tweets <- topicc<-tweets


#********************************************
#         Topic Analysis
#********************************************
sports.words = scan('DeSales.RDS', what='character', comment.char=';')

score.topic = function(sentences, dict, .progress='none')
{
  require(plyr)
  require(stringr)
  
  #we got a vector of sentences. plyr will handle a list
  #or a vector as an "l" for us
  #we want a simple array of scores back, so we use
  #"l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, dict) {
    
    #clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    #and convert to lower case:
    sentence = tolower(sentence)
    
    #split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    #sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    #compare our words to the dictionaries of positive & negative terms
    topic.matches = match(words, dict)
    
    #match() returns the position of the matched term or NA
    #we just want a TRUE/FALSE:
    topic.matches = !is.na(topic.matches)
    
    #and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(topic.matches)
    
    return(score)
  }, dict, .progress=.progress )
  
  topicscores.df = data.frame(score=scores, text=sentences)
  return(topicscores.df)
}

topic.scores= score.topic(tweets, sports.words, .progress='text')
topic.mentioned = subset(topic.scores, score !=0)

N= nrow(topic.scores)
Nmentioned = nrow(topic.mentioned)

dftemp=data.frame(topic=c("Mentioned", "Not Mentioned"), 
                  number=c(Nmentioned,N))


library("googleVis")

Pie <- gvisPieChart(dftemp)
plot(Pie)


# for Nuestra

#install the necessary packages
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("plyr")
install.packages("stringr")
install.packages("googleVis")
install.packages("stringi")
install.packages("magrittr")
install.packages("dplyr")


library(readr)
topiccs  <- readRDS("Nuestra.RDS")
tweets <- topiccs$MESSAGE_BODY



#********************************************
#         Topic Analysis
#********************************************
sports.words = scan('Nuestra.RDS', what='character', comment.char=';')

score.topic = function(sentences, dict, .progress='none')
{
  require(plyr)
  require(stringr)
  
  #we got a vector of sentences. plyr will handle a list
  #or a vector as an "l" for us
  #we want a simple array of scores back, so we use
  #"l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, dict) {
    
    #clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    #and convert to lower case:
    sentence = tolower(sentence)
    
    #split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    #sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    #compare our words to the dictionaries of positive & negative terms
    topic.matches = match(words, dict)
    
    #match() returns the position of the matched term or NA
    #we just want a TRUE/FALSE:
    topic.matches = !is.na(topic.matches)
    
    #and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(topic.matches)
    
    return(score)
  }, dict, .progress=.progress )
  
  topicscores.df = data.frame(score=scores, text=sentences)
  return(topicscores.df)
}

topic.scores= score.topic(tweets, sports.words, .progress='text')
topic.mentioned = subset(topic.scores, score !=0)

N= nrow(topic.scores)
Nmentioned = nrow(topic.mentioned)

dftemp=data.frame(topic=c("Mentioned", "Not Mentioned"), 
                  number=c(Nmentioned,N))


library("googleVis")

Pie <- gvisPieChart(dftemp)
plot(Pie)






# 4 - Sentiment Analysis

# For Desales
#install the necessary packages
install.packages("readr")
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("plyr")
install.packages("stringr")
install.packages("googleVis")
install.packages("stringi")
install.packages("magrittr")
install.packages("dplyr")



library(readr)
gearr <- readRDS("DeSales.RDS")
geartweets <- gearr<-tweets




#********************************************
#         Sentiment Analysis
#********************************************
#R's c() function (for "combine") allows us to add a few industry- and Twitter-specific terms to form our final pos.words and neg.words vectors:

pos.words = scan('positive-words.txt', what='character', comment.char=';')
neg.words = scan('negative-words.txt', what='character', comment.char=';')

neg.words = c(neg.words, 'wtf', 'fail')

#Implementing our sentiment scoring algorithm
require(plyr)
require(stringr)
require(stringi)

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array of scores back, so we use
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

sentiment.scores= score.sentiment(geartweets, pos.words, neg.words, .progress='text')

score= sentiment.scores$score
hist(score)
score = subset(score,score!=0)
sentiscore = data.frame(score)

library("googleVis")
Hist<- gvisHistogram(sentiscore, options=list(
  legend="{ position: 'top', maxLines:2 }",
  colors="['#5C3292', '#1A8763', '#871B47']",
  width=400, height=360))
plot(Hist)






dftemp=data.frame(topic=c("positive_words","negative_words"), 
                  number=c(pos.words,neg.words))



#for Nuestra

#install the necessary packages
install.packages("readr")
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("plyr")
install.packages("stringr")
install.packages("googleVis")
install.packages("stringi")
install.packages("magrittr")
install.packages("dplyr")



library(readr)
gearrr <- readRDS("Nuestra.RDS")
geartweets <- gearrr$MESSAGE_BODY




#********************************************
#         Sentiment Analysis
#********************************************
#R's c() function (for "combine") allows us to add a few industry- and Twitter-specific terms to form our final pos.words and neg.words vectors:

pos.words = scan('positive-words.txt', what='character', comment.char=';')
neg.words = scan('negative-words.txt', what='character', comment.char=';')

neg.words = c(neg.words, 'wtf', 'fail')

#Implementing our sentiment scoring algorithm
require(plyr)
require(stringr)
require(stringi)

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array of scores back, so we use
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

sentiment.scores= score.sentiment(geartweets, pos.words, neg.words, .progress='text')

score= sentiment.scores$score
hist(score)
score = subset(score,score!=0)
sentiscore = data.frame(score)

library("googleVis")
Hist<- gvisHistogram(sentiscore, options=list(
  legend="{ position: 'top', maxLines:2 }",
  colors="['#5C3292', '#1A8763', '#871B47']",
  width=400, height=360))
plot(Hist)






dftemp=data.frame(topic=c("positive_words","negative_words"), 
                  number=c(pos.words,neg.words))





# 5 - User Profile



# 6 - Network Analysis

