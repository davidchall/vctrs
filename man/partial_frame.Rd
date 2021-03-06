% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/partial-frame.R
\name{partial_frame}
\alias{partial_frame}
\title{Partially specify columns of a data frame}
\usage{
partial_frame(...)
}
\arguments{
\item{...}{Attributes of subclass}
}
\description{
This special class can be passed to \code{.ptype} in order to specify the
types of only some of the columns in a data frame.
}
\examples{
pf <- partial_frame(x = double())
pf

vec_rbind(
  data.frame(x = 1L, y = "a"),
  data.frame(x = FALSE, z = 10),
  .ptype = partial_frame(x = double(), a = character())
)
}
\keyword{internal}
