#' ---
#' title: "SQL"
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
#' Introduction to SQL via `sqldf` package.
#' 
#' Ref:
#' 
#' - SQL formatter: https://sqlformat.org/
#' 
#' # Setup
#+

## Load necessary libraries

library(nycflights13)
library(sqldf)
library(lubridate)
library(here)
library(tidyverse)


#' # Examples


#' ## Look at flights, all columns
#+
sqldf("select * from flights") %>%
    as_tibble()


#' ## Look at one column
#+
sqldf("select origin from flights") %>%
    as_tibble()


#' ## Look at two columns, format it
#+
sqldf("
SELECT origin,
       dest
FROM flights
") %>%
    as_tibble()


#' ## Look at three columns, format it
#+
sqldf("
SELECT carrier,
       origin,
       dest
FROM flights
") %>%
    as_tibble()


#' ## Select column, add a column
#+
sqldf("
SELECT origin,
       'Anna' as name
FROM flights
") %>%
    as_tibble()


#' ## Look at all columns, January flights
#' 
#' Notes:
#' 
#' - Fewer rows returned
#' - Checking equality uses a `=`, not `==`
#+
sqldf("
SELECT *
FROM flights
WHERE month = 1
") %>%
    as_tibble()


#' ## Multiple condition
#' Notes:
#' 
#' - Look at how formatting works.
#' - Using parenthesis is important.
#+
sqldf("
SELECT year,
       month,
       day,
       carrier,
       origin,
       dest
FROM flights
WHERE (month = 1
       OR month = 12)
  AND carrier = 'UA'
") %>%
    as_tibble()



#' ## SELECT DISTINCT
#' 
#' Notes:
#' 
#' - Selects distinct values
#' 
#+
sqldf("
SELECT DISTINCT carrier
FROM flights
") %>%
    as_tibble()


#' ## Counting
#' 
#' Want to count flights by carrier.
#' Note:
#' 
#' - Not quite what we want.  Keeps first carrier, counts total rows.
#+
sqldf("
SELECT carrier, count(carrier) as n_carrier
FROM flights
") %>%
    as_tibble()


#' ## GROUP BY allows you to operate on the distinct values in a grouped column.
#+
sqldf("
SELECT carrier,
       count(carrier) AS n_carrier
FROM flights
GROUP BY carrier
") %>%
    as_tibble()


#' ## ORDER BY allows you sort the output
#+
sqldf("
SELECT carrier,
       count(carrier) AS n_carrier
FROM flights
GROUP BY carrier
ORDER BY n_carrier
") %>%
    as_tibble()


#' ## Change sort order in ORDER BY
#+
sqldf("
SELECT carrier,
       count(carrier) AS n_carrier
FROM flights
GROUP BY carrier
ORDER BY n_carrier desc
") %>%
    as_tibble()


#' ## Joining
#' 
#' Look at carrier name
#+
sqldf("
SELECT *
FROM airlines
") %>%
    as_tibble()


#' Pull flights with carrier (abbreviation)
#+
sqldf("
SELECT carrier,
       origin,
       dest
FROM flights
") %>%
    as_tibble()


#' Join on carrier full name to the above table
#+
sqldf("
SELECT f.carrier,
       f.origin,
       f.dest,
       a.name
FROM flights f
LEFT JOIN airlines a ON (f.carrier = a.carrier)
") %>%
    as_tibble()
