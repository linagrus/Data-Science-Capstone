Data Science Capstone Project
========================================================
author: Lina Grusliene
date: 16/06/2021
autosize: true

The Shinny app has been created to demonstrate the next word prediction algorithm.

Project deliverables:
- Next Word Prediction Model
- Shinny App Demonstrating the Prediction Model
- Presentation about the algorithm and app

Prediction Model - Steps
========================================================

The Next Word Prediction Model has been created following these steps:

- Input: US blogs, news and twitter data
- Sampling: 15% sample selected to reduce the file size and recources used by a program
- Cleaning data:

  1. Non-ASCII characters removed and corpus created
  2. Removed punctuation, symbols, numbers, etc. but kept other stop words for accuracy.
  3. Corpus trimmed to cover 90% of instances to save memory and improve the app performance.

- Predict: Function _sbo_predictor_ used from _sbo_ package to train a text predictor using Stupid Back-off model with 4-grams.The model has been tested with up to 7-grams, but becomes slower with higher n-grams and does not increase accuracy significantly.
- Output: most likely next word predicted with a few more alternative predictions.

Prediction Model - Algorithm
========================================================

The algorithm works as following:
- A user types a phrase and the last three words are selected to search for in a 4-gram.
- If not enough candidates for prediction are found, the app will use the last two words to search for in the 3-gram.
- Similarly, it checks 2-grams and unigrams if predictions are not found before. 
- The Stupid Backoff model with a default value of alpha = 0.4 is used to calculate scores for the matching candidates.
- Best candidates for the prediction are selected.

The accuracy of the impremented prediction algorithm is 22.6% with uncertaintly of 0.418%.

Shinny Application
========================================================
The next word prediction app provides a simple user interface to the next word prediction model. The app takes as input a phrase in a text box input and outputs a prediction of the next word and 4 other alternatives (5 possible words in total).

*Key Features:*  

1. Text box for user input  
2. Predicted next word outputs showed on the right of user input  
3. Tab "About" provides more information about the app.

*Key Benefits:*  

1. Fast response as predictions are precomputed
2. Method allows for large training sets to be used resulting in more accurate next word predictions

[Shiny App Link](https://linagr.shinyapps.io/NLP_text_prediction/)  

Documentation and links
========================================================

Stupid Backoff Model
"https://www.aclweb.org/anthology/D07-1090.pdf"

Shiny App    
"https://linagr.shinyapps.io/NLP_text_prediction/"

Shiny App Source Code repository on Github    
"https://github.com/linagrus/Data-Science-Capstone"
