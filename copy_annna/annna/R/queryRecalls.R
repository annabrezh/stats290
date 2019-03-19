#' Allow users to query Open FDA Drug Recall Information
#'
#' @description Allow users to query for a given number of result objects that represent
#' a set of Drug Recall Information. The example function returns a tidy dataframe
#' with recall information.
#' @export
#' @import httr
#' @import jsonlite
#' @import tidyr
#' @import tibble
#' @import dplyr
#'
#' @param limit the number of recall information events to return
#' @param date_start the date for which you want the adverse events to start in format YYYYMMDD
#' @param date_end the date for which you want the adverse events to stop in format YYYYMMDD
#' Both date_start and date_end must be supplied if one is supplied, but both are optional.
#' @return a dataframe with id, date, reason, product description, and classification
#'
#' @examples
#' queryRecalls(limit = 10)
#' queryRecalls(limit=10, date_start="20050101", date_end="20060101")
#'
queryRecalls <- function(limit=1, date_start = NULL, date_end = NULL) {

    total_recalls = 9343
    if(limit > total_recalls) {
        limit = total_recalls
    }

    limit_allowed_by_fda = 100
    recalls <- tibble()

    skip = 0
    while (limit > limit_allowed_by_fda) {
        df <- queryOpenFDA(limit_allowed_by_fda, skip, event_or_enforcement = "enforcement",
                           date_start = date_start, date_end = date_end)
        if(is.null(df)) {
            print("no matches found for parameters specified")
            return()
        }
        new_recalls <- getRecallEvents(df)
        recalls <- rbind(recalls, new_recalls)

        limit <- limit - limit_allowed_by_fda
        skip <- skip + limit_allowed_by_fda

    }

    df <- queryOpenFDA(limit, skip, event_or_enforcement = "enforcement",
                       date_start = date_start, date_end = date_end)
    if(is.null(df)) {
        print("no matches found for parameters specified")
        return()
    }
    #print(df)
    new_recalls <- getRecallEvents(df)
    recalls <- rbind(recalls, new_recalls)

    recalls

}

getJSONObject <- function(recall_results, object) {
    results <- lapply(recall_results, function(x) {
        x[[object]]
    })
    results <- lapply(results, function(x) {
        if(is.null(x)) {
            "unknown"
        }
        else {
            x
        }
    })
    #print(results)
    results
}


getRecallEvents <- function(recall_results) {
    recall_results <- recall_results$results
    ids <- getJSONObject(recall_results, "recall_number")
    date <- getJSONObject(recall_results, "recall_initiation_date")
    reason <- getJSONObject(recall_results, "reason_for_recall")
    product_desc <- getJSONObject(recall_results, "product_description")
    classification <- getJSONObject(recall_results, "classification")
    recall_results_df <- tibble(id = unlist(ids), date = unlist(date), reason = unlist(reason), product_desc = unlist(product_desc), classification = unlist(classification))
    recall_results_df[["date"]] <- as.Date(recall_results_df[["date"]], "%Y%m%d")
    recall_results_df
}
