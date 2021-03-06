% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/queryOpenFDA.R
\name{queryOpenFDA}
\alias{queryOpenFDA}
\title{Allow users to query Open FDA Drug Adverse Events}
\usage{
queryOpenFDA(limit = 1, skip = 0, event_or_enforcement = c("event",
  "enforcement"), date_start = NULL, date_end = NULL)
}
\arguments{
\item{limit}{the number of adverse events to return}

\item{skip}{the number of entries to skip before returning results}

\item{event_or_enforcement}{query open fda for either drug adverse events or recall information.}

\item{date_start}{date in format YYYYMMDD for which to start retrieving reports}

\item{date_end}{date in format YYYYMMDD for which to end retrieving reports

If date end is before date start then json response will contain an error.
Both dates must be specified if returning results within a date range is desired.}
}
\value{
a list with the entire response.
}
\description{
Allow users to query for a given number of result objects that represent
a set of Open FDA Drug Adverse Events. The example function returns a tidy dataframe
with drugs and events.
}
\examples{
queryOpenFDA(limit = 1, skip = 0, event_or_enforcement = "enforcement")
queryOpenFDA(date_start = "20040101", date_end = "20131231")

}
