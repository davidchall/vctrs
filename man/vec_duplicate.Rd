% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dictionary.R
\name{vec_duplicate}
\alias{vec_duplicate}
\alias{vec_duplicate_any}
\alias{vec_duplicate_detect}
\alias{vec_duplicate_id}
\title{Find duplicated values}
\usage{
vec_duplicate_any(x)

vec_duplicate_detect(x)

vec_duplicate_id(x)
}
\arguments{
\item{x}{A vector (including a data frame).}
}
\value{
\itemize{
\item \code{vec_duplicate_any()}: a logical vector of length 1.
\item \code{vec_duplicate_detect()}: a logical vector the same length as \code{x}.
\item \code{vec_duplicate_id()}: an integer vector the same length as \code{x}.
}
}
\description{
\itemize{
\item \code{vec_duplicate_any()}: detects the presence of duplicated values,
similar to \code{\link[=anyDuplicated]{anyDuplicated()}}.
\item \code{vec_duplicate_detect()}: returns a logical vector describing if each
element of the vector is duplicated elsewhere. Unlike \code{\link[=duplicated]{duplicated()}}, it
reports all duplicated values, not just the second and subsequent
repetitions.
\item \code{vec_duplicate_id()}: returns an integer vector giving the location of
the first occurrence of the value.
}
}
\section{Missing values}{

In most cases, missing values are not considered to be equal, i.e.
\code{NA == NA} is not \code{TRUE}. This behaviour would be unappealing here,
so these functions consider all \code{NAs} to be equal. (Similarly,
all \code{NaN} are also considered to be equal.)
}

\section{Dependencies}{

\itemize{
\item \code{\link[=vec_proxy_equal]{vec_proxy_equal()}}
}
}

\examples{
vec_duplicate_any(1:10)
vec_duplicate_any(c(1, 1:10))

x <- c(10, 10, 20, 30, 30, 40)
vec_duplicate_detect(x)
# Note that `duplicated()` doesn't consider the first instance to
# be a duplicate
duplicated(x)

# Identify elements of a vector by the location of the first element that
# they're equal to:
vec_duplicate_id(x)
# Location of the unique values:
vec_unique_loc(x)
# Equivalent to `duplicated()`:
vec_duplicate_id(x) == seq_along(x)
}
\seealso{
\code{\link[=vec_unique]{vec_unique()}} for functions that work with the dual of duplicated
values: unique values.
}
