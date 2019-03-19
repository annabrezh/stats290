#' Allow users to analyze Open FDA Drug Adverse Events
#'
#' @description Allow users to look at a table relating to drug adverse events
#' and patient information
#'
#' @param drugs_and_events the dataframe returned by queryOpenFDA
#' @return a dataframe with columns date and unique_date_events on that date
#' @export
#'
#' @import dplyr
#'
#' @examples
#' drugs_and_events <- queryAdverseEvents(limit=10)
#' getEventCounts(drugs_and_events)

getEventCounts <- function(drugs_and_events) {
    drugs_and_events %>% group_by(id, date) %>% summarize(id_events = n()) %>%
        group_by(date) %>% summarize(unique_date_events = n())
}







