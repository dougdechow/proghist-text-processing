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

words <- tokenize_words(text)
