% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/queryAdverseEvents.R
\name{queryAdverseEvents}
\alias{queryAdverseEvents}
\title{Allow users to query Open FDA Drug Adverse Events}
\usage{
queryAdverseEvents(limit = 1, date_start = NULL, date_end = NULL)
}
\arguments{
\item{limit}{the number of adverse events to return}

\item{date_start}{the date for which you want the adverse events to start in format YYYYMMDD}

\item{date_end}{the date for which you want the adverse events to stop in format YYYYMMDD
Both date_start and date_end must be supplied if one is supplied, but both are optional.}
}
\value{
a dataframe with drug and adverse information for the number of results
Columns include: id, sex, age, drug, drug indication, date and reaction.
}
\description{
Allow users to query for a given number of result objects that represent
a set of Open FDA Drug Adverse Events. The example function returns a tidy dataframe
with drugs and events.
}
\examples{
queryAdverseEvents(limit = 101)
queryAdverseEvents(limit=10, date_start="20050101", date_end="20060101")

}
