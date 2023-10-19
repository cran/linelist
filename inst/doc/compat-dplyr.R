## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(linelist)
library(dplyr)

data("measles_hagelloch_1861", package = "outbreaks")

x <- make_linelist(
  measles_hagelloch_1861,
  id = "case_ID",
  date_onset = "date_of_prodrome",
  age = "age",
  gender = "gender"
)

head(x)

## -----------------------------------------------------------------------------
x %>%
  arrange(case_ID) %>%
  head()

## -----------------------------------------------------------------------------
x %>%
  distinct() %>%
  head()

## -----------------------------------------------------------------------------
x %>%
  filter(age >= 10) %>%
  head()

## -----------------------------------------------------------------------------
x %>%
  slice(5:10)

x %>%
  slice_head(n = 5)

x %>%
  slice_tail(n = 5)

x %>%
  slice_min(age, n = 3)

x %>%
  slice_max(age, n = 3)

x %>%
  slice_sample(n = 5)

## -----------------------------------------------------------------------------
x %>%
  mutate(major = age >= 18) %>%
  head()

## -----------------------------------------------------------------------------
x %>%
  pull(age)

## -----------------------------------------------------------------------------
x %>%
  relocate(date_of_prodrome, .before = 1) %>%
  head()

## -----------------------------------------------------------------------------
x %>%
  rename(edad = age) %>%
  head()

x %>%
  rename_with(toupper) %>%
  head()

## -----------------------------------------------------------------------------
# Works fine
x %>%
  select(case_ID, date_of_prodrome, gender, age) %>%
  head()

# Tags are not updated!
x %>%
  select(case_ID, date_of_prodrome, gender, edad = age) %>%
  head()

# Instead, split the selecting and renaming steps:
x %>%
  select(case_ID, date_of_prodrome, gender, age) %>%
  rename(edad = age) %>%
  head()

## -----------------------------------------------------------------------------
dim(x)

dim(bind_rows(x, x))

## -----------------------------------------------------------------------------
bind_cols(
  suppressWarnings(select(x, case_ID, date_of_prodrome)),
  suppressWarnings(select(x, age, gender))
) %>%
  head()

## -----------------------------------------------------------------------------
full_join(
  suppressWarnings(select(x, case_ID, date_of_prodrome)),
  suppressWarnings(select(x, case_ID, age, gender))
) %>%
  head()

## -----------------------------------------------------------------------------
x %>%
  dplyr::arrange(dplyr::pick(ends_with("loc"))) %>%
  head()

