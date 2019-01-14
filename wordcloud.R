library(readr)
library(dplyr)
library(magrittr)
library(wordcloud)
library(wordcloud2)

# read plain text file 
opioids_data <- read_delim("C:/RStudio Projects/Personal Projects/Word Cloud/reddit_opioids.txt",
                           delim = "|",
                           col_names = T)

# remove all non-letter characters, convert to lower case & split sentences
opioid_titles <- opioids_data$Title %>% 
  gsub("[^A-Za-z ]", "", .) %>% 
  tolower() %>% 
  strsplit(" ") %>% 
  unlist()

# calculate word frequencies & put in table
opioid_words <- opioid_titles %>% table()

# create data frame for word frequencies table & remove 1st row which is blank 
opioid_words <- data_frame(
  word = opioid_words %>% names(),
  freq = opioid_words %>% as.integer()
) %>% 
  slice(-1)

# filter out some very common uninteresting words & all words with a frequency of less than 5
opioid_words %>% 
  filter(
    freq >= 5
    & word != "the"
    & word != "to"
    & word != "and"
    & word != "a"
    & word != "of"
    & word != "is"
    & word != "in"
    & word != "on"
  ) %>% 
  wordcloud2(color = "red", fontFamily = "Consolas") # create word cloud

# create data frame for second word cloud
opioid_words_filtered <- opioid_words %>% 
  filter(
    word != "the"
    & word != "to"
    & word != "and"
    & word != "a"
    & word != "of"
    & word != "is"
    & word != "in"
    & word != "on"
  )

# second word cloud
wordcloud(words = opioid_words_filtered$word,
          freq = opioid_words_filtered$freq,
          random.order = F,
          rot.per = 0.3,
          max.words = 275,
          colors = brewer.pal(5, "Set1"))

unloa
