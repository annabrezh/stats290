#' Allow users to visualize drug information against selected variable.
#'
#' @description Allow users to request to plot a drug against a patient demographic variable
#'
#' @param drugs_and_events the dataframe that is returned from calling queryOpenFDA in queryOpenFDA.R
#' @param drug_of_interest a drug of interest for the user, must be one of the drugs
#' within the drugs_and_events dataframe
#' @param variable_of_interest the variable of interest to plot from the columns
#' of drugs_and_events dataframe. Should be one of: c("age", "sex", "reaction", "date")
#' @return a ggplot with the variable of interest as the x axis and the count of that variable for
#' a specific drug on the y axis.
#'
#' @export
#'
#' @import ggplot2
#' @import scales
#'
#' @examples
#' drugs_and_events <- queryAdverseEvents(limit = 101)
#' plotDrugAdverseEvents(drugs_and_events, "LETAIRIS", "age")
plotDrugAdverseEvents <- function(drugs_and_events, drug_of_interest = "LETAIRIS", variable_of_interest) {
    drugs_and_events %>%
        group_by_("drug", variable_of_interest) %>%
        summarize(count = n()) %>%
        arrange(desc(count)) %>%
        filter_(~drug == drug_of_interest) %>%
        top_n(10) %>%
        ggplot(aes_string(x = variable_of_interest, y = "count")) +
        geom_point() + coord_flip() + ggtitle(paste(drug_of_interest, "and", variable_of_interest))

}

#' Allow users to analyze Open FDA Drug Adverse Events data over time.
#'
#' @description Plot number of drug events over time.
#'
#' @param drugs_and_events the dataframe returned by queryAdverseEvents
#' @return a ggplot with the date as the x axis and events on date as the y axis
#' @export
#'
#' @import ggplot2
#'
#' @examples
#' drugs_and_events <- queryAdverseEvents(limit=10)
#' plotEventCounts(drugs_and_events)
plotEventCounts <- function(drugs_and_events) {
    event_counts <- getEventCounts(drugs_and_events)
    ggplot(data = event_counts, mapping = aes_(~date, ~unique_date_events)) + geom_line()

}

#' Allow users to analyze Open FDA Drug Adverse Events data over time.
#'
#' @description Plot number top 10 drug events over time.
#'
#' @param drugs_and_events the dataframe returned by queryAdverseEvents
#' @return a ggplot with the date as the x axis and events on date as the y axis
#' with colors for the top ten drugs
#' @export
#'
#' @import ggplot2
#'
#' @examples
#' drugs_and_events <- queryAdverseEvents(limit=10)
#' plotTopTenDrugs(drugs_and_events)
plotTopTenDrugs <- function(drugs_and_events) {
    drug = NULL
    top_10_drugs <- drugs_and_events %>% group_by_(~drug) %>%
        summarize(n = n()) %>% arrange(desc(n)) %>% top_n(10)

    event_counts_with_drug <- drugs_and_events %>% group_by_(~date, ~drug) %>%
        summarize(n = n()) %>% arrange(desc(n)) %>% subset(drug %in% top_10_drugs$drug)

    ggplot(data = event_counts_with_drug, mapping = aes_(~date, ~n, color = top_10_drugs$drug)) +
        geom_point()
}

