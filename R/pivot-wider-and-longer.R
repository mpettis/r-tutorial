#' ---
#' title: "Pivot Tables"
#' author: "Matt Pettis (Matthew.Pettis@gmail.com)"
#' date: "`r Sys.Date()`"
#' output:
#'   html_document:
#'     toc: true
#'     toc_depth: 3
#'     code_folding: show
#' editor_options:
#'   chunk_output_type: console
#' ---


#' # Overview
#' 
#' Go over pivoting, wider and longer.  Tie into Excel pivoting.
#' 
#' Underlying this is the concept of `tidy data`.  Below is a link to a discussion on that.
#' 
#' Reference:
#' 
#' - https://tidyr.tidyverse.org/index.html
#' - https://tidyr.tidyverse.org/articles/tidy-data.html
#' 
#' # Setup
#+

## Load necessary libraries

library(skimr)
library(lubridate)
library(here)
library(tidyverse)



#' # Making data wider
#' 
#' Let's look at the data we want to deal with:
#+
print(fish_encounters)



#' Look at summary of this data.  `skim` is from the `skimr` package.
#' 
#' Look at `n_unique` for the factors.  We'll defer exactly what factors are to another lesson.  Know this about factors:
#' 
#' - Factors are a "whitelist" of what values a column can take on.  So you can tell what is missing.
#' - Under the covers, factors are integers, that get mapped to characters.  So we have to be careful sometimes with operations.
#' - Factors can be ordered, so you can have some sense of bigger/smaller, like:
#'     - Small < Medium < Large
#' 
#' Note here we have 19 different types of fish at 11 different stations.  `seen` just tells you that it has been seen.
#+
skim(fish_encounters)



#' This might be easier if can see the list of stations across the top.  We can do that with `pivot_wider()`:
#' 
#+

## Code to make df_wider.  Result looks like:

## A tibble: 19 x 12
## fish  Release I80_1 Lisbon  Rstr Base_TD   BCE   BCW  BCE2  BCW2   MAE   MAW
## <fct>   <int> <int>  <int> <int>   <int> <int> <int> <int> <int> <int> <int>
## 1 4842        1     1      1     1       1     1     1     1     1     1     1
## 2 4843        1     1      1     1       1     1     1     1     1     1     1
## 3 4844        1     1      1     1       1     1     1     1     1     1     1
## 4 4845        1     1      1     1       1    NA    NA    NA    NA    NA    NA

print(df_wider)



#' Here, the `NA` values happen because there was no row for this combination of
#' fish and station.  So it is reasonable here to turn these into 0s:
#' 
#' See: https://stackoverflow.com/questions/45576805/how-to-replace-all-na-in-a-dataframe-using-tidyrreplace-na
#' 
#+
df_wider %>%
    replace(is.na(.), 0) ->
    df_wider

print(df_wider)





#' # Making data longer
#' 
#' Sometimes, you want to have your data in "longer" form.  So let's put back
#' what we just did.  But let's not fix NAs with 0s:
#+

pivot_wider(fish_encounters,
            names_from = "station",
            values_from = "seen") ->
    df_longer

print(df_wider)


#' `pivot_longer()` goes the opposite direction.  It takes a set of columns and
#' turns them into two columns -- one that has the name of the column, and the
#' other that has the value for that column.
#' 
#+

## Code to make df_wider back into long form.


#' Note that we have more observations than the original here:
#+
fish_encounters



#' That's because when we made the original dataset longer, we had to make a
#' grid, and fill spots that didn't have obs in with `NA`.  Now, when we reshape
#' this, those `NA` values come along for the ride.  We need to remove them in the end:
#+
    
## Code to remove NAs, redo pivot to longer code.



#' We can select in other ways too:
#+

## Range of contiguous columns

## Code: Pivot to longer, with column range

## Code: Pivot to longer, with dplyr helper functions.
