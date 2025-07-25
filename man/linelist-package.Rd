% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linelist-package.R
\docType{package}
\name{linelist-package}
\alias{linelist-package}
\alias{linelist}
\title{Base Tools for Storing and Handling Case Line Lists}
\description{
The \emph{linelist} package provides tools to help storing and handling case line
list data. The \code{linelist} class adds a tagging system to classical
\code{data.frame} or \code{tibble} objects which permits to identify key
epidemiological data such as dates of symptom onset, epi case definition,
age, gender or disease outcome. Once tagged, these variables can be
seamlessly used in downstream analyses, making data pipelines more robust and
reliable.
}
\section{Main functions}{

\itemize{
\item \code{\link[=make_linelist]{make_linelist()}}: to create \code{linelist} objects from a \code{data.frame} or a
\code{tibble}, with the possibility to tag key epi variables
\item \code{\link[=set_tags]{set_tags()}}: to change or add tagged variables in a \code{linelist}
\item \code{\link[=tags]{tags()}}: to get the list of tags of a \code{linelist}
\item \code{\link[=tags_df]{tags_df()}}: to get a \code{data.frame} of all tagged variables
\item \code{\link[=lost_tags_action]{lost_tags_action()}}: to change the behaviour of actions where tagged
variables are lost (e.g. removing columns storing tagged variables) to
issue warnings, errors, or do nothing
\item \code{\link[=get_lost_tags_action]{get_lost_tags_action()}}: to check the current behaviour of actions where
tagged variables are lost
}
}

\section{Dedicated methods}{


Specific methods commonly used to handle \code{data.frame} are provided for
\code{linelist} objects, typically to help flag or prevent actions which could
alter or lose tagged variables (and may thus break downstream data
pipelines).
\itemize{
\item \verb{names() <-} (and related functions, such as \code{\link[dplyr:rename]{dplyr::rename()}}) will
rename tags as needed
\item \verb{x[...] <-} and \verb{x[[...]] <-} (see \link{sub_linelist}): will adopt the
desired behaviour when tagged variables are lost
\item \code{print()}: prints info about the \code{linelist} in addition to the
\code{data.frame} or \code{tibble}
}
}

\examples{

if (require(outbreaks)) {
  # using base R style

  ## dataset we'll create a linelist from, only using the first 50 entries
  measles_hagelloch_1861[1:50, ]

  ## create linelist
  x <- make_linelist(measles_hagelloch_1861[1:50, ],
    id = "case_ID",
    date_onset = "date_of_prodrome",
    age = "age",
    gender = "gender"
  )
  x

  ## check tagged variables
  tags(x)

  ## robust renaming
  names(x)[1] <- "identifier"
  x

  ## example of dropping tags by mistake - default: warning
  x[, 2:5]

  ## to silence warnings when taggs are dropped
  lost_tags_action("none")
  x[, 2:5]

  ## to trigger errors when taggs are dropped
  # lost_tags_action("error")
  # x[, 2:5]

  ## reset default behaviour
  lost_tags_action()


  # using tidyverse style

  ## example of creating a linelist, adding a new variable, and adding a tag
  ## for it

  if (require(dplyr)) {
    x <- measles_hagelloch_1861 |>
      tibble() |>
      make_linelist(
        id = "case_ID",
        date_onset = "date_of_prodrome",
        age = "age",
        gender = "gender"
      ) \%>\%
      mutate(result = if_else(is.na(date_of_death), "survived", "died")) |>
      set_tags(outcome = "result") |>
      rename(identifier = case_ID)

    head(x)

    ## extract tagged variables
    x |>
      select(has_tag(c("gender", "age")))

    x |>
      tags()

    x |>
      select(starts_with("date"))
  }
}

}
\seealso{
Useful links:
\itemize{
  \item \url{https://epiverse-trace.github.io/linelist/}
  \item \url{https://github.com/epiverse-trace/linelist}
  \item Report bugs at \url{https://github.com/epiverse-trace/linelist/issues}
}

}
\author{
\strong{Maintainer}: Chris Hartgerink \email{chris@data.org} (\href{https://orcid.org/0000-0003-1050-6809}{ORCID}) [reviewer]

Authors:
\itemize{
  \item Hugo Gruson (\href{https://orcid.org/0000-0002-4094-1476}{ORCID})
  \item Thibaut Jombart [conceptor]
}

Other contributors:
\itemize{
  \item Tim Taylor [contributor]
}

}
\keyword{internal}
