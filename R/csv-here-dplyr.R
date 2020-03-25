#' ---
#' title: "CSV, here(), dplyr"
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
#' - Discuss project structure.
#' - Discuss `here()` function.
#' - Go over reading and writing CSV files
#' - Start of date handling
#' 
#' # Setup
#+

## Load necessary libraries
library(datapasta)
library(lubridate)
library(here)
library(tidyverse)




#' # Make some data
#' 
#' Some oxygen capacity in some made up units
#+
df_oxygen <- tribble(
    ~person,    ~date_str, ~oxygen_capacity,
    "bevan", "2020-03-01", 1.2,
    "bevan", "2020-03-02", 1.5,
    "bevan", "2020-03-03", 1.4,
    "anna", "2020-03-01", 1.7,
    "anna", "2020-03-02", 1.9,
    "anna", "2020-03-03", 1.7,
    "matt", "2020-03-01", 0.5,
    "matt", "2020-03-02", 2.5,
    "matt", "2020-03-03", 1.0
)



#' ## Dates
#' 
#' Handling of dates is so important that it takes a lot of discussion.  We will only scratch the surface here.
#' 
#' First, we convert *strings* that look like dates into date objects that we can do math on.
#' 
#' Note that we'd like to do stuff like subtract and add to dates, but we can't do this as a string.
#+

## Nice to use `tryCatch()`` when we are making intentional errors.
tryCatch({
    mutate(
        df_oxygen,
        date_plus_one = date_str + 1
    )
},
error=function(e) print(e))



#' We need to convert this to a date object before we can do math on it.
#+
mutate(
    df_oxygen,
    date = ymd(date_str)
)


#' We want to actually save this back to `df_oxygen`, so we do that and reassign it:
#+
df_oxygen <- mutate(
    df_oxygen,
    date = ymd(date_str)
)

print(df_oxygen)


#' We use *piping* to do this in a slightly different way... this is more of what you see in the wild nowadays.
#+
df_oxygen <- df_oxygen %>%
    mutate(
        date = ymd(date_str)
    )

print(df_oxygen)



#' Note how the table is displayed, it shows you the type of information in the
#' columns... characters, doubles, and date.
#' 
#' Now we can do math on the date
#+
df_oxygen %>%
    mutate(
        date_plus_one = date + 1
    )






#' # Writing and reading a CSV
#' 
#' We can write this out to a CSV file, so we can look at it in Excel or something else:
#+
write_csv(
    df_oxygen,
    here("dat", "oxygen.csv")
)





#' We can now read it back into our system:
#+
df_oxygen_readin <- read_csv(
    here("dat", "oxygen.csv")
)

print(df_oxygen_readin)



#' There is some extra stuff that was printed.  What happened was that R made
#' guesses at the types of column types it thinks the data is in.  It is usually
#' pretty good, and here it made good guesses.  However, sometimes we want to
#' control what is in the columns.  Let's do it dumbly here, telling it that
#' everything is a character:
#+
read_csv(
    here("dat", "oxygen.csv"),
    col_types = cols(.default=col_character())
)





#' If you want some finer grained control, you can just use a structure like you
#' saw logged out to you when you first read it in.
#' 
#' The difference is that it won't echo back to you what it guesses were in
#' reading in the data.  It just does it with the column types that you specify.
#+
read_csv(
    here("dat", "oxygen.csv"),
    col_types =  cols(
        person = col_character(),
        date_str = col_date(format = ""),
        oxygen_capacity = col_double(),
        date = col_date(format = "")
    )
)
