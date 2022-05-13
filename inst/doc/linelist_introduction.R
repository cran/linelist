## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(linelist)

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("linelist", build_vignettes = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  if (!require(remotes)) {
#    install.packages("remotes")
#  }
#  remotes::install_github("epiverse-trace/linelist", build_vignettes = TRUE)

## -----------------------------------------------------------------------------

library(linelist)


## -----------------------------------------------------------------------------

# load libraries
library(outbreaks)

# overview of the data
head(measles_hagelloch_1861)


## -----------------------------------------------------------------------------

library(tibble) # data.frame but with nice printing 
library(dplyr) # for data handling
library(magrittr) # for the %>% operator
library(linelist) # this package!

x <- measles_hagelloch_1861 %>%
  tibble() %>%
  make_linelist(date_onset = "date_of_prodrome",
                date_death = "date_of_death",
                age = "age",
                gender = "gender")
x


## -----------------------------------------------------------------------------

tags(x)


## -----------------------------------------------------------------------------

x <- x %>%
  mutate(inferred_outcome = if_else(is.na(date_of_death), "survided", "died")) %>%
  set_tags(outcome = "inferred_outcome")
x


## -----------------------------------------------------------------------------

x <- x %>%
  set_tags(outcome = NULL)
tags(x)


## -----------------------------------------------------------------------------

# select tagged variables only
x %>%
  select_tags(date_onset, date_death)

# select tagged variables only with renaming on the fly
x %>%
  select_tags(onset = date_onset, date_death)

# get all tagged variables in a data.frame
x %>%
  tags_df()


## -----------------------------------------------------------------------------

# hybrid selection
x %>%
  select(1:2)


## -----------------------------------------------------------------------------

# hybrid selection
x %>%
  select(1:2, tags = "gender")


## ----error = TRUE-------------------------------------------------------------
# hybrid selection
x %>%
  select(1:2, tags = "gender")

# hybrid selection - no warning
x %>%
  lost_tags_action("none") %>%
  select(1:2, tags = "gender")

# hybrid selection - error due to lost tags
x %>%
  lost_tags_action("error") %>%
  select(1:2, tags = "gender")

# note that `lost_tags_action` sets the behavior for any later operation, so we 
# need to reset the default
get_lost_tags_action() # check current behaviour
lost_tags_action() # reset default


