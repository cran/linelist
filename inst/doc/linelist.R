## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(linelist)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("linelist", build_vignettes = TRUE)

## -----------------------------------------------------------------------------
library(linelist)

## -----------------------------------------------------------------------------
data(measles_hagelloch_1861, package = "outbreaks")

# overview of the data
head(measles_hagelloch_1861)

## -----------------------------------------------------------------------------
library(tibble) # data.frame but with nice printing
library(dplyr) # for data handling
library(linelist) # this package!

x <- measles_hagelloch_1861 |>
  tibble() |>
  make_linelist(date_onset = "date_of_prodrome",
                date_death = "date_of_death",
                age = "age",
                gender = "gender")
head(x)

## -----------------------------------------------------------------------------
tags(x)

## -----------------------------------------------------------------------------
x <- x |>
  mutate(
    inferred_outcome = if_else(is.na(date_of_death), "survived", "died")
  ) |>
  set_tags(outcome = "inferred_outcome")
x

## -----------------------------------------------------------------------------
x <- x |>
  set_tags(outcome = NULL)
tags(x)

## -----------------------------------------------------------------------------
# select tagged variables only
x |>
  select(has_tag(c("date_onset", "date_death")))

# select tagged variables only with renaming on the fly
x |>
  select(onset = has_tag("date_onset"))

# get all tagged variables in a data.frame
x |>
  tags_df()

## -----------------------------------------------------------------------------
x |>
  select(1:2)

## -----------------------------------------------------------------------------
# hybrid selection
x |>
  select(1:2, has_tag("gender"))

