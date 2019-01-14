https://github.com/selfagency/bs-detector

news_data <- read_csv("C:/RStudio Projects/Personal Projects/Word Cloud/fake.csv") %>% 
  filter(title != "")

# remove all non-letter characters, convert to lower case & split sentences
news_titles <- news_data$title %>% 
  gsub("[^A-Za-z ]", "", .) %>% 
  tolower() %>% 
  strsplit(" ") %>% 
  unlist()

# calculate word frequencies & put in table
news_words <- news_titles %>% table()

# create data frame for word frequencies table & remove 1st row which is blank  
news_words <- data_frame(
  word = news_words %>% names(),
  freq = news_words %>% as.integer()
) %>% 
  slice(-1)

# filter out some very common uninteresting words & all words with a frequency of less than 40
news_words %>% 
  filter(
    freq >= 40
    & word != "the"
    & word != "to"
    & word != "and"
    & word != "a"
    & word != "of"
    & word != "is"
    & word != "in"
    & word != "on"
    & word != "are"
    & word != "from"
    & word != "at"
    & word != "as"
    & word != "for"
  ) 
  wordcloud2(color = "black", fontFamily = "Consolas") # create word cloud
