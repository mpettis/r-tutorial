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
#+
df_lakers <- lakers %>%
    ## Convert to a nicer data format
    as_tibble() %>%
    ## Original date is an integer.  Turn into a date object.
    mutate(date = ymd(date))


#' ## Exercise: What is the total number of points scored in the season by Lakers?
#+
df_lakers %>%
    filter(team == "LAL") %>%
    summarise(season_points = sum(points))


#' ## Exercise: What is the total number of points scored in the season by opponents?
#+
df_lakers %>%
    filter(team != "LAL") %>%
    summarise(season_points = sum(points))




#' # ggplot: Bar chart
#' 
#' A 2-bar bar chart, showing total Laker points in season, and total opponent points in season.
#' 
#'## Exercise: Bar Chart of the points
#' 
#+
df_lakers %>%
    ## Have to change all opponents into having common team name of OPP
    mutate(team = ifelse(team == "LAL", "LAL", "OPP")) %>%
    ## For each group, LAL and OPP...
    group_by(team) %>%
    ## .. add up their points
    summarise(season_points = sum(points)) %>%
    ungroup() ->
    df_plot

#' Basic plot
#+
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points))

#' Add Title
#+
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points)) +
    ggtitle("Laker vs. Opponent points, for season")

#' Add commas to y-axis labels, and an axis name
#+
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points)) +
    scale_x_discrete(name = "Team Designation") +
    scale_y_continuous(name = "Total Season Points", labels = comma) +
    ggtitle("Laker vs. Opponent points, for season")

#' Tilt the team names
#+
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points)) +
    scale_x_discrete(name = "Team Designation") +
    scale_y_continuous(name = "Total Season Points", labels = comma) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    ggtitle("Laker vs. Opponent points, for season")


#' Change bar color to red
#+
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points), fill = "red")


#' Manually control colors of bars
#+
vColorMapping <- c("LAL" = "blue", "OPP" = "green")
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points, fill = team)) +
    scale_fill_manual(values = vColorMapping)


#' Try preset theme
#+
ggplot(data = df_plot) +
    geom_col(aes(x = team, y = season_points)) +
    theme_excel()





#' # ggplot: Time series plot
#' 
#' Time series of Laker game points vs. opponents over season.
#' 
#' Set up the data
#' 
#+
df_lakers %>%
    filter(team != "OFF") %>%
    ## Have to change all opponents into having common team name of OPP
    ## For each group, LAL and OPP...
    group_by(date, opponent, team) %>%
    ## .. add up their points
    summarise(game_points = sum(points)) %>%
    ungroup() ->
    df_plot

ggplot() +
    geom_line(
        data = df_plot %>% filter(team == "LAL"),
        mapping=aes(x = date, y = game_points),
        color="blue"
    ) +
    geom_line(
        data = df_plot %>% filter(team != "LAL"),
        mapping=aes(x = date, y = game_points),
        color="red"
    ) +
    scale_x_date(
        date_breaks = "1 month",
        labels = date_format("%Y-%m-%d")
    ) +
    theme(
        axis.text.x = element_text(angle = 90, hjust = 1)
    ) +
    ggtitle("Laker vs. Opponent game points, by game")
