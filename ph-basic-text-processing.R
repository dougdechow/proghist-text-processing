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
