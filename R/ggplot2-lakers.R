#' ---
#' title: "ggplot2"
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
#' To discuss:
#' 
#' - dplyr
#' - ggplot2
#' - getting help?
#' 
#' Some resources for ggplot2:
#' 
#' - Documentation: https://ggplot2.tidyverse.org/
#' - Cheatsheet: https://rstudio.com/resources/cheatsheets/
#' - Gallery: https://www.r-graph-gallery.com/ggplot2-package.html
#' - Gallery: https://thisisdaryn.github.io/gcubed/index.html#examples
#' - Detailed tutorial on the parts: https://cedricscherer.netlify.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/
#' - Themes: https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/
#' - Themes: https://www.shanelynn.ie/themes-and-colours-for-r-ggplots-with-ggthemr/
#' - Themes: https://github.com/hrbrmstr/hrbrthemes
#' 
#' 
#' 
#' # Setup
#+

## Load necessary libraries

library(ggthemes)
library(scales)
library(lubridate)
library(here)
library(tidyverse)




#' # Data
#' 
#' Use built-in data set for LA Lakers basketball scores.
#' 
#' ## Wrangle the data
#' 
#' We want to do 2 things here to make the dataframe be a bit nicer:
#' 
#' - Turn the date column into a column of 'date' objects so we can do nicer things with them.
#' - Turn this into a 'tibble' object, because it has some nicer properties, like printing nicer.
#' 
#' ... Make dataframe called `df_lakers`.  Make it a tibble, and turn date into object type <date>.
#+



#' ## Exercise: What is the total number of points scored in the season by Lakers?
#+


#' ## Exercise: What is the total number of points scored in the season by opponents?
#+




#' # ggplot: Bar chart
#' 
#' A 2-bar bar chart, showing total Laker points in season, and total opponent points in season.
#' 
#'## Exercise: Bar Chart of the points
#' 
#' ... First, make a dataframe called `df_plot` that has total points, called
#' `season_points`, grouped by team.  And the team should only have values 'LAL'
#' or 'OPP'.
#' 
#' Looks like this:
#' 
#' ```
#' # A tibble: 2 x 2
#'   team  season_points
#'   <chr>         <int>
#' 1 LAL            8319
#' 2 OPP            7702
#' ```
#+





#' Basic plot
#' 
#' ... make a bar chart of total LAL and OPP season points.
#+





#' ... add title to plot
#+







#' ... add commas to y-axis labels, and an axis name.
#+




#' Tilt the team names on x-axis
#+





#' ... change bar color to red
#+





#' ... manually control colors of bars
#+





#' Try preset theme, like 'excel'.
#+





#' # ggplot: Time series plot
#' 
#' Time series of Laker game points vs. opponents over season.
#' 
#' Set up the data
#' 
#' Should look like this:
#' 
#' ````
#' # A tibble: 156 x 4
#'    date       opponent team  game_points
#'    <date>     <chr>    <chr>       <int>
#'  1 2008-10-28 POR      LAL            96
#'  2 2008-10-28 POR      POR            76
#'  3 2008-10-29 LAC      LAC            79
#'  4 2008-10-29 LAC      LAL           117
#'  5 2008-11-01 DEN      DEN            97
#'  6 2008-11-01 DEN      LAL           104
#'  7 2008-11-05 LAC      LAC            88
#'  8 2008-11-05 LAC      LAL           106
#'  9 2008-11-09 HOU      HOU            82
#' 10 2008-11-09 HOU      LAL           111
#' # ... with 146 more rows
#' ````
#+


#' ... plot LAL and OPP points, game by game, against time.
