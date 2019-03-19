#' Allow users to query Open FDA Drug Adverse Events
#'
#' @description Allow users to query for a given number of result objects that represent
#' a set of Open FDA Drug Adverse Events. The example function returns a tidy dataframe
#' with drugs and events.
#' @export
#' @import httr
#' @import jsonlite
#' @import date
#'
#' @param limit the number of adverse events to return
#' @param skip the number of entries to skip before returning results
#' @param event_or_enforcement query open fda for either drug adverse events or recall information.
#' @param date_start date in format YYYYMMDD for which to start retrieving reports
#' @param date_end date in format YYYYMMDD for which to end retrieving reports
#'
#' If date end is before date start then json response will contain an error.
#' Both dates must be specified if returning results within a date range is desired.
#'
#' @return a list with the entire response.
#'
#' @examples
#' queryOpenFDA(limit = 1, skip = 0, event_or_enforcement = "enforcement")
#' queryOpenFDA(date_start = "20040101", date_end = "20131231")
#'
queryOpenFDA <- function(limit=1, skip=0, event_or_enforcement = c("event", "enforcement"),
                         date_start = NULL, date_end = NULL) {
    event_or_enforcement <- match.arg(event_or_enforcement)
    url <- paste0("https://api.fda.gov/drug/", event_or_enforcement, ".json?limit=", limit)

    url <- paste0(url, "&skip=", skip)


    # receivedate:[20040101+TO+20081231] for adverse events
    # report_date:[20040101+TO+20131231] for enforcement

    date_range <- NULL
    if(!is.null(date_start)) {
        if(!is.null(date_end)) {
            if (isDateValid(date_start) & isDateValid(date_end)) {
                date_range <- paste0(date_start, "+TO+", date_end)
            }
        }
    }

    if(!is.null(date_range)) {
        if(event_or_enforcement == "event") {
            url <- paste0(url, "&search=receivedate:[", date_range, "]")
        }
        else {
            url <- paste0(url, "&search=reportdate:[", date_range, "]")
        }
    }


    resp <- GET(url)

    df <- jsonlite::fromJSON(content(resp, "text"), simplifyVector = FALSE)
    if (is.null(df$error)) {
        df
    }
    else {
        print("No matches found. Please check url")
        print(url)
        return(NULL)
    }
    #print(df)

}

isDateValid <- function(date) {
    return(grepl("\\d{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])", date))
}
