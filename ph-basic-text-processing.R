#
# Proj: Basic Text Processing in R
# Desc: Learn how to use R to analyze high-level patterns in texts, 
#       apply stylometric methods over time and across authors, and 
#       use summary methods to describe items in a corpus.
#       This source code is from a Programming Historian tutorial:
#       https://programminghistorian.org/en/lessons/basic-text-processing-in-r
# Date: 2022-05-06
#

# Package Set-up 
# Two R packages need to be installed for the tutorial: tidyverse3 and tokenizers
install.packages("tidyverse")
install.packages("tokenizers")

library(tidyverse)
library(tokenizers)

# ISSUE 1 section: Tokenization
text <- paste("Now, I understand that because it's an election season",
              "expectations for what we will achieve this year are low.",
              "But, Mister Speaker, I appreciate the constructive approach",
              "that you and other leaders took at the end of last year",
              "to pass a budget and make tax cuts permanent for working",
              "families. So I hope we can work together this year on some",
              "bipartisan priorities like criminal justice reform and",
              "helping people who are battling prescription drug abuse",
              "and heroin abuse. So, who knows, we might surprise the",
              "cynics again")

# the function tokenize_words returns a list object with one entry per document 
# in the input. this explains the funky output from running "> words" [[1]]
# > length(words[[1]]) would yield [1] 89 -- or 89 words in the snippet
words <- tokenize_words(text)

# put the unique words in a Tidy table and get the frequency of occurences
tab <- table(words[[1]])
tab <- data_frame(word = names(tab), count = as.numeric(tab))

# put the table into descending order
arrange(tab, desc(count))

# Do this in console: > tab

# ISSUE 2 section: Detecting Sentence Boundaries
sentences <- tokenize_sentences(text)
# Do this in console: > sentences

sentence_words <- tokenize_words(sentences[[1]])
# Do this in console: > sentence_words

length(sentence_words)
# Direct access makes it possible to figure out how many words are in 
# each sentence of the paragraph:
length(sentence_words[[1]])
length(sentence_words[[2]])
length(sentence_words[[3]])
length(sentence_words[[4]])

# Cumbersome. There's an easier way. The sapply function applies its 
# second argument to every element of its first argument. As a result, 
# we can calculate the length of each sentence in the paragraph with 
# a single line of code:
sapply(sentence_words, length)

# Issue 3 section: Exploratory Analysis
# First, build the URL of the text file 
base_url <- "https://programminghistorian.org/assets/basic-text-processing-in-r"
url <- sprintf("%s/sotu_text/236.txt", base_url)
text <- paste(readLines(url), collapse = "\n")

# Tokenize the text and obtain word count for the document: 6113 words
words <- tokenize_words(text)
length(words[[1]])

# reuse Tidy code from above
tab <- table(words[[1]])
# The following generates a warning:
# Warning message:
#  `data_frame()` was deprecated in tibble 1.1.0.
# Please use `tibble()` instead--but I can't get tibble() to work
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab <- arrange(tab, desc(count))
# Do this in console: > tab

# need to obtain word frequency occurence data for the English language
# Use the Norvig/Google Web Trillion Word Corpus (TWC)
# First column give language as “en” -- English 
# Second column gives the word 
# third column gives percentage of TWC consisting of the given word. 
wf <- read_csv(sprintf("%s/%s", base_url, "word_frequency.csv"))
# Do this in console: > wf

# function to join on common column names, here: "word"
tab <- inner_join(tab, wf)
# Do this in console: > tab
# filter for rows that occur with a frequency less than 0.1%: 1 in a 1000 words.
filter(tab, frequency < 0.1)
print(filter(tab, frequency < 0.002), n = 15)
